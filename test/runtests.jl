using PosteriorPlots
using Test

import Logging

# Silence all warnings

level = Logging.min_enabled_level(Logging.current_logger())
Logging.disable_logging(Logging.Warn)

#------------- Build some demo models ---------------

using Soss
using Random

model = @model X begin
    p = size(X, 2) # number of features
    α ~ Normal(0, 1) # intercept
    β ~ Normal(0, 1) |> iid(p) # coefficients
    σ ~ HalfNormal(1) # dispersion
    η = α .+ X * β # linear predictor
    μ = η # `μ = g⁻¹(η) = η`
    y ~ For(eachindex(μ)) do j
        Normal(μ[j], σ) # `Yᵢ ~ Normal(mean=μᵢ, variance=σ²)`
    end
end;

X = randn(6,2)

forward_sample = rand(model(X=X))

num_rows = 1_000
num_features = 2
X = randn(num_rows, num_features)

β_true = [2.0, -1.0]
α_true = 1.0
σ_true = 0.5

η_true = α_true .+ X * β_true
μ_true = η_true
noise = randn(num_rows) .* σ_true
y_true = μ_true .+ noise

posterior = dynamicHMC(model(X=X), (y=y_true,))

#------------- Run package tests --------------------

@testset "PosteriorPlots.jl" begin
    # plot_posterior_intervals
    println("plot_posterior_intervals")
    plot_posterior_intervals(posterior)
    println()

    # plot_posterior_hist
    println("plot_posterior_hist")
    plot(plot_posterior_hist(posterior, true)...)
    println()

    # plot_posterior_density
    println("plot_posterior_density")
    plot(plot_posterior_density(posterior, true)...)
    println()
end

# Reset log level

Logging.disable_logging(level)
