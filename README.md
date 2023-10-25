# SimpleContinuation
Adott a paraméterfüggő 1D folytonos dinamikai rendszer:
```math
\dot{x} = f(x,p)
```

A cél, hogy numerikusan közelítsük meg a $f(x^{*},p) = 0$ megoldásait. Itt explicit görbeként kezeljük, ami csak bizonyos esetekben lehetséges (a módszer nem érvényes, ha a görbe "visszafordul"). 

```math
x^{*}(p) \approx x_0^{*}(p_0) + \frac{\partial x^{*}}{\partial p} \Delta p 
```
Kis számolás után:

```math
 x^{*}(p) \approx x_0^{*}(p_0) - \left[ \frac{f_p}{f_x}  \right]_{x^{*}_0,p_0} \Delta p 
```

