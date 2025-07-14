using Distributions
using Distributions: ContinuousUnivariateDistribution
import Distributions: logpdf
import Distributions: rand
import Distributions: loglikelihood

@model function normal_model(y)
    μ ~ Normal(0, 5)
    σ ~ Gamma(1, 1)
    y ~ MyDist(μ, σ)
    return (; μ, σ)
end

struct MyDist{T} <: ContinuousUnivariateDistribution
    μ::T
    σ::T
end

MyDist(; μ, σ) = MyDist(μ, σ)

function logpdf(dist::MyDist, y::Float64)
    (; μ, σ) = dist
    return logpdf(Normal(μ, σ), y)
end

function rand(dist::MyDist, n::Int)
    (; μ, σ) = dist
    return rand(Normal(μ, σ), n)
end

loglikelihood(dist::MyDist, y::Vector) = sum(logpdf.(dist, y))

Broadcast.broadcastable(x::MyDist) = Ref(x)
