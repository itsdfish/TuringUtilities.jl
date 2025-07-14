using SafeTestsets

@safetestset "TuringUtilities.jl" begin
    using TuringUtilities
    using Turing
    using Test

    include("test_model.jl")

    n_samples = 50
    y = rand(MyDist(0, 1), n_samples)
    model = normal_model(y)

    post_chain = sample(model, NUTS(1000, 0.85), 1000)
    pred_model = predict_distribution(;
        simulator = p -> rand(MyDist(; p...), n_samples),
        model,
        func = mean
    )
    post_preds = returned(pred_model, post_chain)
end
