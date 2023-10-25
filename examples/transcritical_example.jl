### A Pluto.jl notebook ###
# v0.19.30

using Markdown
using InteractiveUtils

# ╔═╡ 4681fa68-7344-11ee-2173-01442550e41d
begin
	using Pkg
	Pkg.add(url="https://github.com/rusandris/SimpleContinuation.jl.git")
end

# ╔═╡ ebf3a3ac-9c02-4ecf-abfc-8b37d88dd942
using SimpleContinuation

# ╔═╡ a65b3f3b-5887-4eef-a55a-eaa23708213d
using Plots,LaTeXStrings

# ╔═╡ 96613abd-0445-48f0-ac38-35efe5d2fda8
md"""
Készítsük el a 

$\dot{x} = f(x) = rx - x^2$

1D folytonos dinamikai rendszer bifurkációs diagramját **numerikusan**. 
"""

# ╔═╡ e3f3be86-31d3-481d-a689-0ea32d0af470
f(x,r) = r*x-x^2

# ╔═╡ 725755d5-9507-4b00-ba1b-ce26cc0f6b4c
begin
	xs = [-1.5:0.01:1;]
	
	pl1 = plot(xs,f.(xs,-1),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",ylabel=L"\dot{x}",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=-1",titlefontsize=18)

	pl2 = plot(xs,f.(xs,0),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=0",titlefontsize=18)

	
	pl3 = plot(xs,f.(xs,1),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=1",titlefontsize=18)

	l = @layout [a{0.3w} b{0.3w} c{0.3w}]
	plot(pl1,pl2,pl3,layout=l,size=(1000,400),margin=5Plots.mm)
end

# ╔═╡ 446efa6e-bffe-4527-9509-daa94d9f4aaf
begin
	x1 = -1.2 #kezdeti becslés
	br1 = continuation(f,x1;p_min=-1.0,p_max=-0.0001,Δp = 1e-4)
end

# ╔═╡ f79a6dd2-50ba-48dd-8a94-9bccb8e67568
br1.stability

# ╔═╡ b3776d57-e80e-4600-ab95-c452d4e0ec1e
begin
	x01 = -0.0 #kezdeti becslés
	br01 = continuation(f,x01;p_min=-1.0,p_max=1.0,Δp = 1e-4)
end

# ╔═╡ a95a2870-b1d2-4b4e-a53b-c129142cbd42
br01.stability

# ╔═╡ 322d226c-5250-43ed-b0b7-78ac696aaf14
begin
	x02 = -0.0 #kezdeti becslés
	br02 = continuation(f,x02;p_min=0.01,p_max=1,Δp = 1e-4)
end

# ╔═╡ 5859d648-d2f5-4755-b73e-6a506bf5a037
br02.stability

# ╔═╡ 52bc52c3-ad06-4a98-a20b-58e31a84f6c9
begin
	x2 = 1.0 #kezdeti becslés
	br2 = continuation(f,x2;p_min=0.01,p_max=1,Δp = 1e-4)
end

# ╔═╡ 3b1f6284-b82f-4fc8-92ea-c228408187aa
br2.stability

# ╔═╡ ec3986b0-ef0d-42a1-8428-7af5743c2769
begin
plot(br1.p_values,br1.values,framestyle=:origin,linestyle=:dash,lw=3,label=L"x^{*}_1",legendfontsize=15,xlabel=L"r",ylabel=L"x^{*}",guidefontsize=20,lc=:orange)

plot!(br01.p_values,br01.values,framestyle=:origin,linestyle=:solid,lw=3,lc=:gray10,label=L"x^{*}_0",legendfontsize=15,xlabel=L"r",ylabel=L"x^{*}",guidefontsize=20)

plot!(br02.p_values,br02.values,framestyle=:origin,linestyle=:dash,lw=3,lc=:gray10,label="",legendfontsize=15,xlabel=L"r",ylabel="",guidefontsize=20)
	
plot!(br2.p_values,br2.values,framestyle=:origin,linestyle=:solid,lw=3,label=L"x^{*}_2",legendfontsize=15,xlabel=L"r",ylabel=L"x^{*}",guidefontsize=20,lc=:red)
end

# ╔═╡ d1a97219-b67e-4a09-839b-8c47abba1edd
md"""
Stabilitás-csere! Ez egy **transzkritikus bifurkáció**!
"""

# ╔═╡ Cell order:
# ╠═4681fa68-7344-11ee-2173-01442550e41d
# ╠═ebf3a3ac-9c02-4ecf-abfc-8b37d88dd942
# ╟─96613abd-0445-48f0-ac38-35efe5d2fda8
# ╠═e3f3be86-31d3-481d-a689-0ea32d0af470
# ╠═a65b3f3b-5887-4eef-a55a-eaa23708213d
# ╟─725755d5-9507-4b00-ba1b-ce26cc0f6b4c
# ╠═446efa6e-bffe-4527-9509-daa94d9f4aaf
# ╠═f79a6dd2-50ba-48dd-8a94-9bccb8e67568
# ╠═b3776d57-e80e-4600-ab95-c452d4e0ec1e
# ╠═a95a2870-b1d2-4b4e-a53b-c129142cbd42
# ╠═322d226c-5250-43ed-b0b7-78ac696aaf14
# ╠═5859d648-d2f5-4755-b73e-6a506bf5a037
# ╠═52bc52c3-ad06-4a98-a20b-58e31a84f6c9
# ╠═3b1f6284-b82f-4fc8-92ea-c228408187aa
# ╠═ec3986b0-ef0d-42a1-8428-7af5743c2769
# ╟─d1a97219-b67e-4a09-839b-8c47abba1edd
