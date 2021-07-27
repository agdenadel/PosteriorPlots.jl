"""

    plot_density_check(y, yrep, plot_legend, args...; kwargs...)

Draw a density plot of a random sample of draws from the response variable posterior distribution against the density estimation of the actual data to visualise model fit.

Usage:
```julia-repl
plot_density_check(y, yrep, plot_legend)
```
Arguments:

- `y` : The vector of response variable values.
- `yrep` : The Draws x Values matrix of posterior predictions.
- `plot_legend` : Boolean of whether to add a legend to the plot or not.
"""
function plot_density_check(y::Vector, yrep::AbstractMatrix, plot_legend::Bool, args...; kwargs...)

    gr() # gr backend for graphics
    mycolor = theme_palette(:auto).colors.colors[1]
    Random.seed!(123) # Fix seed for reproducibility

    #-------- Wrangling --------

    # Pull yreps into long DataFrame

    x

    #-------- Draw plot --------

    # yreps

    myPlot = plot(thevec, title = "Posterior Predictive Check", fillalpha = 0.3, 
        xlabel = "", ylabel = "", label = "yrep",
        seriestype = :density, color = :grey, size = (400, 400))

    # y

    plot!(y, fillalpha = 0.9, xlabel = "Value", ylabel = "Density", label = "y",
        seriestype = :density, color = mycolor)

    return myPlot
end



"""

    plot_hist_check(y, yrep, plot_legend, args...; kwargs...)

Draw a plot with a binned histogram of posterior-predicted response variable values against a measure of centrality of the actual data to visualise model fit.

Usage:
```julia-repl
plot_hist_check(y, yrep, plot_legend)
```

Arguments:

- `y` : The vector of response variable values.
- `yrep` : The Draws x Values matrix of posterior predictions.
- `plot_legend` : Boolean of whether to add a legend to the plot or not.
"""

function plot_hist_check(y::Vector, yrep::AbstractMatrix, plot_legend::Bool, args...; kwargs...)

    # Compute median

    m = median(y)

    # Set up graphics helpers

    mycolor = theme_palette(:auto).colors.colors[1]
    mycolor2 = theme_palette(:auto).colors.colors[2]

    # Draw plot

    myPlot = plot(yrep, seriestype = :histogram, fillalpha = 0.6, 
                  xlabel = "Value", ylabel = "", label = "yrep",
                  color = mycolor, title = "Posterior Predictive Check", size = (400, 400),
                  legend = plot_legend)

    plot!([m], seriestype = "vline", color = mycolor2, label = "y", linewidth = 2.5)

    return myPlot
end
