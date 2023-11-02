### A Pluto.jl notebook ###
# v0.19.30

using Markdown
using InteractiveUtils

# ╔═╡ 489e885a-7341-11ee-144f-c12ac1c41912
begin
	using Pkg
	Pkg.add(url="https://github.com/rusandris/SimpleContinuation.jl.git")
end

# ╔═╡ 4a87a5a4-75db-432c-9e73-c494a651f43e
using SimpleContinuation

# ╔═╡ 5f890b56-287c-4f9d-bdae-2080e5d44d5b
using Plots,LaTeXStrings

# ╔═╡ e9a58556-b1d1-425c-9823-edbd0f9dfb72
md"""
Készítsük el a 

$\dot{x} = f(x) = r + x - ln(1+x)$

1D folytonos dinamikai rendszer bifurkációs diagramját **numerikusan**. 
"""

# ╔═╡ d7679c19-82c3-4351-b728-6423cf6bdeea
f(x,r) = r+x - log(1+x)

# ╔═╡ 4c5107f2-b501-43cc-8ed9-acce0adcc842
begin
	xs = [-0.95:0.01:1;]
	
	pl1 = plot(xs,f.(xs,-0.1),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",ylabel=L"\dot{x}",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=-0.1",titlefontsize=18)

	pl2 = plot(xs,f.(xs,0),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=0",titlefontsize=18)

	
	pl3 = plot(xs,f.(xs,0.1),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=0.1",titlefontsize=18)

	l = @layout [a{0.3w} b{0.3w} c{0.3w}]
	plot(pl1,pl2,pl3,layout=l,size=(1000,400),margin=5Plots.mm)
end

# ╔═╡ 025d1cff-2ce6-4119-b028-cd21eb61e575
md"""
Számítsuk ki először a pozitív fixponthoz tartozó ágat a continuation függvényt használva:
"""

# ╔═╡ 3325f49b-5fed-4e59-b1ef-b1d4f8b8b968
begin
	x01 = 0.5 #kezdeti becslés
	br1 = continuation(f,x01;p_min=-0.5,p_max=0.0,Δp = 1e-4)
	br1.stability
end

# ╔═╡ a8158d83-938d-4c25-82ce-b06870cece77
plot(br1.p_values,br1.values,framestyle=:origin,linestyle=:dash,lw=3,label=L"x^{*}_1",legend=:topright,legendfontsize=15,xlabel=L"r",ylabel=L"x^{*}",guidefontsize=20)

# ╔═╡ 832819d5-0b68-4fb6-a9e7-9e47db4b12d3
md"""
Az alapértelmezett gyökkeresési módszer egy közelítő Newton-módszer (`quasinewton_rootfinding`).Az $x=-1$-ben lévő aszimptota miatt ezzel a módszerrel nagyon nehéz megkeresni a negatív fixpont kezdeti helyzetét, ezért a `bisection_rootfinding` módszert fogjuk használni.  
"""

# ╔═╡ 655a47d3-dcd4-475d-842f-7f782af68064
begin
	x02 = -0.2 #kezdeti becslés, itt most nem lényeges
	options = (a=-0.95,b=-0.1) #a fixpontot tartalmazó intervallum két széle
	br2 = continuation(f,x02;p_min=-0.5,p_max=0.0,Δp = 1e-4,rootfinding_function=bisection_rootfinding,rootfinding_options=options)
	br2.stability
end

# ╔═╡ 182db064-a360-4a93-99d3-119b251e312a
begin
plot!(br2.p_values,br2.values,framestyle=:origin,linestyle=:solid,lw=3,label=L"x^{*}_2",legend=:topright,legendfontsize=15,xlabel=L"r",ylabel=L"x^{*}",guidefontsize=20)
end

# ╔═╡ 6a575048-d321-4743-afa1-f79368b9e823
md"""
Ez nem más, mint egy **nyeregpont bifurkáció**!
"""

# ╔═╡ Cell order:
# ╠═489e885a-7341-11ee-144f-c12ac1c41912
# ╠═4a87a5a4-75db-432c-9e73-c494a651f43e
# ╟─e9a58556-b1d1-425c-9823-edbd0f9dfb72
# ╠═d7679c19-82c3-4351-b728-6423cf6bdeea
# ╠═5f890b56-287c-4f9d-bdae-2080e5d44d5b
# ╠═4c5107f2-b501-43cc-8ed9-acce0adcc842
# ╟─025d1cff-2ce6-4119-b028-cd21eb61e575
# ╠═3325f49b-5fed-4e59-b1ef-b1d4f8b8b968
# ╠═a8158d83-938d-4c25-82ce-b06870cece77
# ╟─832819d5-0b68-4fb6-a9e7-9e47db4b12d3
# ╠═655a47d3-dcd4-475d-842f-7f782af68064
# ╠═182db064-a360-4a93-99d3-119b251e312a
# ╟─6a575048-d321-4743-afa1-f79368b9e823
