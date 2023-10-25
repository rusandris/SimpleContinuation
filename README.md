# SimpleContinuation
Adott a paraméterfüggő 1D folytonos dinamikai rendszer:
```math
\dot{x} = f(x,p)
```

A cél, hogy numerikusan közelítsük meg a $f(x^{*},p) = 0$ megoldásait. Itt explicit görbeként kezeljük, ami csak bizonyos esetekben lehetséges (a módszer nem érvényes, ha a görbe "visszafordul"). 
