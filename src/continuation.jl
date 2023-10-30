export continuation

function continuation(f,x0::Real;p_min::Real,p_max::Real,Δp::Float64=1e-2,rootfinding_function=quasinewton_rootfinding,rootfinding_options=(),ϵ=1e-4)
	#first try to convergence from x0 to root
	x = rootfinding_function(f,x0,p_min;rootfinding_options...)

	#continuation setup
	xs = Float64[x]
	ps = Float64[p_min]
	df_x = df(f,x0,p_min,ϵ)
	init_stability = sign(df_x)
	p = p_min
	
	#start continuation
	while p < p_max
		x,df_x = continuation(f,x,p;Δp=Δp,rootfinding_function=rootfinding_function,rootfinding_options=rootfinding_options,ϵ=ϵ)
		p += Δp
		if sign(df_x)* init_stability < 0
			@warn "Stability change around p = $(ps[end]) !"
			break
		end
		push!(xs,x)
		push!(ps,p)
	end
	
	return Branch(xs,get_stability_symbol(Int(init_stability)),p_min,p_max,Δp,ps)
end

function continuation(f,x::Real,p::Real;Δp::Float64=1e-2,rootfinding_function=quasinewton_rootfinding,rootfinding_options=(),ϵ=1e-4)
	
	
	#approximation of partial derivatives
	df_p = (f(x,p+Δp) - f(x,p))/Δp
	df_x = df(f,x,p,ϵ)
	
	#try to guess x for the p+Δp
	x_approx = x - df_p/df_x * Δp
	
	#iterate until convergence
	x = rootfinding_function(f,x_approx,p;rootfinding_options...)
	df_x = df(f,x,p,ϵ)
	
	return x,df_x

end

#approximation of derivative at (x0,p0)
df(f,x0,p0,ϵ=1e-4) = (f(x0+ϵ/2.0,p0) - f(x0-ϵ/2.0,p0))/ϵ

