export continuation,quasinewton_rootfinding,bisection_rootfinding

function continuation(f,x0::Real;p_min::Real,p_max::Real,Δp::Float64=1e-2,rootfinding_function=quasinewton_rootfinding,rootfinding_options,ϵ::Float64=1e-3)
	#first try to convergence from x0 to root
	x = rootfinding_function(f,p_min;rootfinding_options...)

	#continuation setup
	ps = p_min:Δp:p_max
	xs = Float64[x] 
	df_x = 0
	
	#start continuation
	for p in ps[1:end-1]
		x,df_x = continuation(f,p,x;Δp=Δp,ϵ=ϵ,rootfinding_function=rootfinding_function,rootfinding_options=rootfinding_options)
		isapprox(0,df_x,atol=1e-2) && @warn "Stability change at p = $p !"
		push!(xs,x)
	end
	return Branch(xs,get_stability_symbol(Int(sign(df_x))),p_min,p_max,Δp)
end

function continuation(f,p0::Real,x0::Real;Δp::Float64=1e-2,rootfinding_function=quasinewton_rootfinding,rootfinding_options,ϵ::Float64=1e-3)
	#first try to convergence from x0 to root
	x = rootfinding_function(f,p0;rootfinding_options...)
	
	#----------continuation----------
	#try to guess x for the p+Δp
	#approximation of partial derivatives
	df_p = (f(x,p0+Δp) - f(x,p0))/Δp
	df_x = df(f,x,p0,ϵ)
	
	return x - df_p/df_x * Δp, df_x

end

function quasinewton_rootfinding(f, p; x0, tol=1e-4,maxiter=1e4,ϵ=1e-4)
	iter = 0
	x = Inf
	
	for i in 1:maxiter
		x = x0 - f(x0,p)/df(f,x0,p,ϵ)
		
		abs(x-x0) < tol && return x
		
		x0 = x
		iter += 1
	end
			
	error("Quasi-Newton method did not converge within the specified number of iterations!")
	
end

function bisection_rootfinding(f, p; a, b, tol=1e-4, maxiter=1e4)
    if f(a,p) * f(b,p) >= 0
        error("Function values at a and b must have opposite signs.")
    end

    for i in 1:maxiter
        c = (a + b) / 2  # Calculate the midpoint of the interval
        fc = f(c,p)        # Evaluate the function at the midpoint

        if abs(fc) < tol || (b - a) / 2 < tol
            return c
        end

        if f(a,p) * fc < 0
            b = c
        else
            a = c
        end
    end

    error("Bisection method did not converge within the specified number of iterations.")
end


#approximation of derivative at (x0,p0)
df(f,x0,p0,ϵ) = (f(x0+ϵ/2.0,p0) - f(x0-ϵ/2.0,p0))/ϵ

