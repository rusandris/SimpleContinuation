export get_stability_symbols

STABILITY_SYMBOLS = Dict(-1 => :Stable,0 => :HalfStable, 1 => :Unstable)

get_stability_symbol(s::Int) = STABILITY_SYMBOLS[s]
