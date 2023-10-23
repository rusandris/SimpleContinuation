struct Branch
	values::Vector{Float64}
	stability::Symbol
	p_min::Real
	p_max::Real
	Δp::Float64
	p_values
end
Branch(values,stability,p_min,p_max,Δp) = Branch(values,stability,p_min,p_max,Δp,p_min:Δp:p_max) 


