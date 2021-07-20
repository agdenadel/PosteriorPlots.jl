"""

    plot_posterior_density_check(model, predmodel, y, ndraws, args...; kwargs...)

Draw a density plot of a random sample of draws from the response variable posterior distribution against the density estimation of the actual data to visualise model fit.

Usage:
```julia-repl
plot_posterior_density_check(model, y, ndraws)
```
Arguments:

- `model` : The Turing.jl model to draw inferences from.
- `predmodel` : The Turing.jl model that specifies predictions for Missing input data.
- `y` : The vector of response variable values.
- `ndraws` : The number of random draws to take from the posterior distribution.
"""
function plot_density_check(model::Chains, predmodel::Model, y::Vector, ndraws::Int, args...; kwargs...)

end



"""

    plot_posterior_hist_check(x, y, args...; kwargs...)

Draw a plot with a binned histogram of posterior-predicted response variable values against a measure of centrality of the actual data to visualise model fit.

Usage:
```julia-repl
plot_posterior_hist(x, y)
```

Arguments:

- `x` : The vector of the actual data values to plot.
- `y` : The vector of model response variable predictions to plot.
"""

function plot_posterior_hist(x::Vector, y::Vector, args...; kwargs...)

        #------------ Computations ------------------

        m = median(x)

        #------------ Draw the plot -----------------

        gr() # gr backend for graphics
        mycolor = theme_palette(:auto).colors.colors[1]
        mycolor2 = theme_palette(:auto).colors.colors[2]

        plot(x, label = "Real Data", seriestype = :histogram, color = mycolor)
        plot!([m], seriestype = "vline", color = mycolor, label = "Real Data Median")
        myPlot = plot!(title = "Posterior Predictive Check", xlabel = "Value", ylabel = "")

        return myPlot

end
