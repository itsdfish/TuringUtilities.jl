@model function wald_model(rts)
    ν ~ truncated(Normal(1.5, 1), 0, Inf)
    α ~ truncated(Normal(.8, 1), 0, Inf)
    τ = 0.3
    rts ~ Wald(ν, α, τ)
    return (;ν, α, τ)
end