module TuringUtilities

using Turing
using Turing: @model

export predict_distribution

"""
    predict_distribution(dist, args...; model, func, n_samples, kwargs...)

Generates a predictive distribution for a statistic defined by `func`.

# Arguments 

- `dist::Distribution`: a distribution type which accepts parameters as keyword arguments 
- `args...` optional positional arguments passed to function `func`

# Keywords

- `model`: a Turing model which returns a `NamedTuple` of parameters 
- `func`: a function which computes a statistic of simulated data. The function signature is `func(data, args...; kwargs...)`
- `n_samples`: the number of observations to sample from `dist`
- `kwargs...`: optional keyword arguments passed to `func`
"""
@model function predict_distribution(
    args...;
    simulator,
    model,
    func = (x, args...; kwargs...) -> x,
    kwargs...
)
    parms ~ to_submodel(model, false)
    sim_data = simulator(parms)
    return func(sim_data, args...; kwargs...)
end

end
