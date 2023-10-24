### A Pluto.jl notebook ###
# v0.19.29

using Markdown
using InteractiveUtils

# ╔═╡ 90491098-71c3-11ee-0ec4-69690ca4f719
using Pkg

# ╔═╡ 8d940696-dbc6-43a9-a803-a1490bb894dc
Pkg.add(url="https://github.com/rusandris/SimpleContinuation.jl.git")

# ╔═╡ 0018d2c0-81d2-43fc-93d7-41a27e8d016e
using SimpleContinuation

# ╔═╡ ce5addd6-56e9-45fe-be69-3478af60f734
using Plots,LaTeXStrings

# ╔═╡ 8f6bfd48-d7f8-450d-bafb-c4e84566cadc
md"""
Készítsük el a 

$f(x) = rx + x^3$

1D folytonos dinamikai rendszer bifurkációs diagramját **numerikusan**. 
"""

# ╔═╡ 8f722eef-ec8f-4fad-8624-4a647849f960
md"""
A rendszer fázisportréja:
"""

# ╔═╡ 1e40202a-b9dc-4002-a23b-e72c161fa7ce
f(x,r) = r*x + x^3

# ╔═╡ a8fe6b00-0ff5-46da-8d82-968afbca0f8b
begin
	xs = [-1:0.01:1;]
	
	pl1 = plot(xs,f.(xs,-1),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",ylabel=L"\dot{x}",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=-1",titlefontsize=18)

	plot!(pl1,[-sqrt(1),sqrt(1)],[0,0],st=:scatter,mc=:white,ms=6,label=L"x^{*}_{12}")
	plot!(pl1,[0],[0],st=:scatter,mc=:gray10,ms=6,label=L"x^{*}_{0}")


	
	pl2 = plot(xs,f.(xs,0),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=0",titlefontsize=18)

	plot!(pl2,[0],[0],st=:scatter,mc=:white,ms=6,label=L"x^{*}_{0}")

	pl3 = plot(xs,f.(xs,1),framestyle=:origin,lw=2,lc=:gray10,ylims=[-1,1],xlabel=L"x",guidefontsize=20,legendfontsize=12,label=L"f(x)",title=L"r=1",titlefontsize=18)

	plot!(pl3,[0],[0],st=:scatter,mc=:white,ms=6,label=L"x^{*}_{0}")

	l = @layout [a{0.3w} b{0.3w} c{0.3w}]
	plot(pl1,pl2,pl3,layout=l,size=(1000,400),margin=5Plots.mm)
end

# ╔═╡ be4eddd9-3e03-44ab-8220-41bc7113fc03
md"""
A diagram 3 fixpont evolúcióját foglalja össze, ahogy az r paramétert változtatjuk.
"""

# ╔═╡ 918d3bde-e2bf-46b2-be67-300e342102e5
begin
	options_newton = (x0=0.8,)
	br1 = continuation(f,0.8;p_min=-1,p_max=-0.01,rootfinding_function=quasinewton_rootfinding,rootfinding_options=options_newton)
end

# ╔═╡ fcc33ebb-25f5-4187-a95f-8c1adafe5be6
typeof(br1)

# ╔═╡ 71654646-6ddc-495b-94a2-3cfeb8d6ba5d
fieldnames(typeof(br1))

# ╔═╡ b4e591af-1cb9-49c9-8fc0-f98a1eed0698
br1.stability

# ╔═╡ 3063e878-ff2b-4c85-8390-8fb2624f7efd
plot(br1.p_values,br1.values)

# ╔═╡ Cell order:
# ╠═90491098-71c3-11ee-0ec4-69690ca4f719
# ╠═8d940696-dbc6-43a9-a803-a1490bb894dc
# ╠═0018d2c0-81d2-43fc-93d7-41a27e8d016e
# ╟─8f6bfd48-d7f8-450d-bafb-c4e84566cadc
# ╟─8f722eef-ec8f-4fad-8624-4a647849f960
# ╠═1e40202a-b9dc-4002-a23b-e72c161fa7ce
# ╠═ce5addd6-56e9-45fe-be69-3478af60f734
# ╟─a8fe6b00-0ff5-46da-8d82-968afbca0f8b
# ╠═be4eddd9-3e03-44ab-8220-41bc7113fc03
# ╠═918d3bde-e2bf-46b2-be67-300e342102e5
# ╠═fcc33ebb-25f5-4187-a95f-8c1adafe5be6
# ╠═71654646-6ddc-495b-94a2-3cfeb8d6ba5d
# ╠═b4e591af-1cb9-49c9-8fc0-f98a1eed0698
# ╠═3063e878-ff2b-4c85-8390-8fb2624f7efd
