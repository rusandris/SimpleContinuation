### A Pluto.jl notebook ###
# v0.19.30

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

$\dot{x} = f(x) = rx + x^3$

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
A bifurkációs diagram 3 fixpont evolúcióját foglalja össze, ahogy az r paramétert változtatjuk.
"""

# ╔═╡ bae98fe2-4021-45fd-a9d5-24ff60824e85
md"""
Számítsuk ki először a pozitív fixponthoz tartozó ágat a `continuation` függvényt használva:
"""

# ╔═╡ 918d3bde-e2bf-46b2-be67-300e342102e5
begin
	x01 = 1.0 #kezdeti becslés
	br1 = continuation(f,x01;p_min=-1,p_max=0.1,Δp = 1e-4)
end

# ╔═╡ 17fc4cbc-a0ea-4f39-88ae-e540c6759bbb
md"""
Ez egy `Branch` típusú objektumot térít vissza, amelybe belecsomagoltuk a bifurkáció ág adatait:
"""

# ╔═╡ fcc33ebb-25f5-4187-a95f-8c1adafe5be6
typeof(br1)

# ╔═╡ 71654646-6ddc-495b-94a2-3cfeb8d6ba5d
fieldnames(typeof(br1))

# ╔═╡ b4e591af-1cb9-49c9-8fc0-f98a1eed0698
br1.stability

# ╔═╡ 2f6ca09a-2692-419f-88e3-308e3179f280
md"""
Mivel instabil, szaggatott vonallal ábrázoljuk:
"""

# ╔═╡ 3063e878-ff2b-4c85-8390-8fb2624f7efd
plot(br1.p_values,br1.values,framestyle=:origin,linestyle=:dash,lw=3,label=L"x^{*}_1",legend=:topright,legendfontsize=15,xlabel=L"r",ylabel=L"x^{*}",guidefontsize=20)

# ╔═╡ 1d46e2e3-9c4c-4e47-82e3-3c79690a01a2
md"""
Számítsuk ki a többi ágat is:
"""

# ╔═╡ 4416d7b9-ce7f-4172-b61f-fe3b48d9fb53
begin
	#negatív fixpont
	x02 = -1.0 #kezdeti becslés
	br2 = continuation(f,x02;p_min=-1,p_max=-0.001,Δp = 1e-4)
end

# ╔═╡ 382d9f92-bbc2-4082-948e-b68c0fb48786
md"""
Mivel az origó $r>0$ értékekre is létezik, és stabilitást vált az $r=0$-ban,
"""

# ╔═╡ 6c2addda-5285-493a-908c-48fcd94e6551
begin
	#origó
	x0 = 0.0
	br0 = continuation(f,x0;p_min=-1.0,p_max=1.0,Δp = 1e-4)
end

# ╔═╡ 883e8219-96b8-4724-9b88-e05e596e0901
begin
	#origó
	br01 = continuation(f,x0;p_min=-1,p_max=-0.001,Δp = 1e-4)
	br02 = continuation(f,x0;p_min=0.0,p_max=1.0,Δp = -1e-4)
end

# ╔═╡ 4174a390-38c0-46a4-ba0a-d4c71fcc4446
br01.stability

# ╔═╡ 110ccefe-014e-4a00-b59d-eee8eeedb24d
br02.stability

# ╔═╡ d7c3ed9f-216f-4620-b284-1941a3a690ab
md"""
A teljes bifurkációs diagram:
"""

# ╔═╡ dd20ff8b-74d8-4f62-8c3e-f083a4e6356d
begin
	plot!(br2.p_values,br2.values,framestyle=:origin,linestyle=:dash,lw=3,label=L"x^{*}_2")
	plot!(br01.p_values,br01.values,framestyle=:origin,lw=3,lc=:gray10,label=L"x^{*}_0")
	plot!(br02.p_values,br02.values,framestyle=:origin,linestyle=:dash,lw=3,lc=:gray10,label="")
end

# ╔═╡ a6605fae-2718-4ee9-ae39-93e8edad2ce4
md"""
Ez nem más, mint a **(szuperkritikus) vasvilla bifurkáció**!
"""

# ╔═╡ Cell order:
# ╠═90491098-71c3-11ee-0ec4-69690ca4f719
# ╠═8d940696-dbc6-43a9-a803-a1490bb894dc
# ╠═0018d2c0-81d2-43fc-93d7-41a27e8d016e
# ╟─8f6bfd48-d7f8-450d-bafb-c4e84566cadc
# ╟─8f722eef-ec8f-4fad-8624-4a647849f960
# ╠═1e40202a-b9dc-4002-a23b-e72c161fa7ce
# ╠═ce5addd6-56e9-45fe-be69-3478af60f734
# ╟─a8fe6b00-0ff5-46da-8d82-968afbca0f8b
# ╟─be4eddd9-3e03-44ab-8220-41bc7113fc03
# ╟─bae98fe2-4021-45fd-a9d5-24ff60824e85
# ╠═918d3bde-e2bf-46b2-be67-300e342102e5
# ╟─17fc4cbc-a0ea-4f39-88ae-e540c6759bbb
# ╠═fcc33ebb-25f5-4187-a95f-8c1adafe5be6
# ╠═71654646-6ddc-495b-94a2-3cfeb8d6ba5d
# ╠═b4e591af-1cb9-49c9-8fc0-f98a1eed0698
# ╟─2f6ca09a-2692-419f-88e3-308e3179f280
# ╠═3063e878-ff2b-4c85-8390-8fb2624f7efd
# ╟─1d46e2e3-9c4c-4e47-82e3-3c79690a01a2
# ╠═4416d7b9-ce7f-4172-b61f-fe3b48d9fb53
# ╟─382d9f92-bbc2-4082-948e-b68c0fb48786
# ╠═6c2addda-5285-493a-908c-48fcd94e6551
# ╠═883e8219-96b8-4724-9b88-e05e596e0901
# ╠═4174a390-38c0-46a4-ba0a-d4c71fcc4446
# ╠═110ccefe-014e-4a00-b59d-eee8eeedb24d
# ╟─d7c3ed9f-216f-4620-b284-1941a3a690ab
# ╠═dd20ff8b-74d8-4f62-8c3e-f083a4e6356d
# ╟─a6605fae-2718-4ee9-ae39-93e8edad2ce4
