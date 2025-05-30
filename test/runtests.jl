using SafeTestsets

@safetestset "TuringUtilities.jl" begin
    using SequentialSamplingModels
    using TuringUtilities
    using Turing
    using Test

    include("test_model.jl")

    n_samples = 50
    rts = rand(Wald(ν = 1.5, α = 0.8, τ = 0.3), n_samples)
    model = wald_model(rts)

    post_chain = sample(model, NUTS(1000, 0.85), 1000)
    pred_model = TuringUtilities.predict_distribution(Wald; model, func = mean, n_samples)
    post_preds = returned(pred_model, post_chain)
end
