export quasinewton_rootfinding,bisection_rootfinding

function quasinewton_rootfinding(f,x0, p; tol=1e-4,maxiter=1e4,ϵ=1e-4)
	iter = 0
	x = Inf
	
	for i in 1:maxiter
		x = x0 - f(x0,p)/df(f,x0,p,ϵ)
		
		abs(x-x0) < tol && return x
		
		x0 = x
		iter += 1
	end
			
	error("Quasi-Newton method did not converge within the specified number of iterations for p = $(p)!")
	
end

function bisection_rootfinding(f,x0,p;Δ = 1.0, a = x0 - Δ, b = x + Δ, tol=1e-4, maxiter=1e4)
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

    error("Bisection method did not converge within the specified number of iterations p = $(p)!")
end

