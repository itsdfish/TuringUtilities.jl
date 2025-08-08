module TuringUtilities

using Turing
using Turing: @model

export predict_distribution

"""
    function predict_distribution(
        args...;
        simulator,
        model,
        sim_kwargs = (),
        func = (x, args...; kwargs...) -> x,
        kwargs...
    )

Generates a predictive distribution for a statistic defined by `func`.

# Arguments 

- `args...` optional positional arguments passed to function `func`

# Keywords

- `simulator`: a function that accepts parameters and returns simulated data 
- `model`: a Turing model which returns a `NamedTuple` of parameters 
- `func`: a function which computes a statistic of simulated data. The function signature is `func(data, args...; kwargs...)`
- `n_samples`: the number of observations to sample from `dist`
- `sim_kwargs = ()`: optional keyword arguments passed to `simulator` function 
- `kwargs...`: optional keyword arguments passed to `func`
"""
@model function predict_distribution(
    args...;
    simulator,
    model,
    func = (x, args...; kwargs...) -> x,
    sim_kwargs = (),
    kwargs...
)
    parms ~ to_submodel(model, false)
    sim_data = simulator(parms; sim_kwargs...)
    return func(sim_data, args...; kwargs...)
end

end
