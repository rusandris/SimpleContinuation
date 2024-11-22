# SimpleContinuation
## 


## A módszerről röviden
Adott a paraméterfüggő 1D folytonos dinamikai rendszer:
```math
\dot{x} = f(x,p),
```
ahol x és p valós skalármennyiségek. 
A cél, hogy automatizáljuk a fixpontok bifurkáció-elemzését. Ha ismerjük egy adott $p_0$ paraméterre a fixpont helyzetét $x^{\*}(p_0)$, azaz
```math
f(x^{*}(p_0),p_0) = 0
```
a $(x^{\*}(p_0),p_0)$ megoldás felhasználható a fixpont helyzetének becslésére a $p_0 + \Delta p$ értékre. Gyakorlatilag "folytatni" szeretnénk a meglévő megoldást, vagyis kiszámítani egy teljes megoldás-görbét (ág,branch). Ezeknek a módszereknek a gyűjtőneve a numerikus kontinuáció (**numerical continuation**).

Két lépéses prediktor-korrektor algoritmus:
* prediktor: új kezdeti becslést javasol a fixpont értékére $p_0 + \Delta p$ esetén
* korrektor: korrigálja a becslést

Itt a bifurkációs ágat explicit görbeként kezeljük, ami csak bizonyos esetekben lehetséges (a módszer nem érvényes, ha a görbe "visszafordul").


## Egyszerű iteratív módszer [(Natural parameter continuation)](https://en.wikipedia.org/wiki/Numerical_continuation#Natural_parameter_continuation)

Numerikusan, [iteratív eljárással](https://en.wikipedia.org/wiki/Numerical_continuation#Natural_parameter_continuation) szeretnénk közelíteni a $x^{\*}(p)$ görbét egy adott $p \in [p_{min},p_{max}]$ intevallumon. 


#### Prediktor
A fixpont helyzetét megközelíthetjük a $p_1 = p_0 + \Delta p$ paraméterértékre ($|\Delta p| << 1$) ha sorbafejtünk első rendig,
```math
x^{*}(p_1) \approx x_0^{*}(p_0) + \frac{d x^{*}}{dp} \Delta p 
```
Hogy ezt használni tudjuk, meg kell határoznunk $\frac{d x^{*}}{dp}$-t (fixpont $p$ szerinti deriváljta). Ehhez felhasználjuk a kezdeti megoldást:
```math
f(x^{*}(p_0),p_0) = 0
```
Differenciálva mindkét oldalt:
```math
\left. \frac{\partial f}{\partial x} \right|_{x^{*}_0,p_0} dx + \left. \frac{\partial f}{\partial p} \right|_{x^{*}_0,p_0} dp = 0 
```
vagy rövidebben: $f_x dx + f_p dp = 0$, ahonnan
```math
\frac{dx^*}{dp} = \left. -\frac{f_p}{f_x}  \right|_{x^{*}_0,p_0}
```
Ezt visszaírva az $x^{*}(p)$-re kapott közelítésbe:
```math
 x^{*}(p_1) \approx x_0^{*}(p_0) - \left. \frac{f_p}{f_x}  \right|_{x^{*}_0,p_0} \cdot \Delta p 
```
Ezt az értéket használhatjuk valamilyen gyökkereső algoritmus kezdőbecsléseként. A csomag `continuation` függvénye numerikusan közelíti az $f_x,f_p$ deriváltakat, így ezeket nem szükséges megadni. 

#### Korrektor
A korrektor kétfajta lehet:
* egy közelítő Newton-módszer [(Secant method)](https://en.wikipedia.org/wiki/Secant_method), amely az $f$ függvény deriváltját numerikusan közelíti (nem kell az analitikus deriváltat megadni): `quasinewton_rootfinding`
* felező módszer (Bisection method): `bisection_rootfinding`

## Használat
`continuation(f,x0;p_min,p_max,kwargs...) -> br::Branch`

Visszatéríti a `Branch`-et `p_min` és `p_max` közt `Δp` paraméterbeli lépésközzel.
Az ágon való haladás irányát a `Δp` előjele dönti el (lehet negatív vagy pozitív is).


A `continuation` függvény argumentumai:
* `f`: a dinamikai rendszer "jobboldala", `f(x,p)` alakú
* `x0`: a kezdeti becslés. Nem kell egzakt fixpontmegoldásnak lennie, a függvény gyökkereső algoritmussal kerül közelebb a pontos értékhez.
Kulcsszó-argumentumok:
* `p_min`: paraméter minimum értéke
* `p_max`: paraméter maximum értéke
* `Δp`: paraméter lépésköz
* `rootfinding_function`: gyökkereső (opciók: `quasinewton_rootfinding,bisection_rootfinding`)
* `rootfinding_options`: további gyökkereső opciók
* `ϵ`: paraméter deriváltak közelítéséhez
  
## Telepítés
`] add https://github.com/rusandris/SimpleContinuation.jl.git`

Pluto:
`using Pkg; Pkg.add(url="https://github.com/rusandris/SimpleContinuation.jl.git")`

## Példák
Példák notebook és html formátumban [itt](/examples) . 
 
