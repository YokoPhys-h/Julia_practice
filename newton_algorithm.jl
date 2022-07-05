f(x) = x^2 - 2
df(x) = 2x
x = 1.0

sq = [x]

for i in 1:100
    println("$i : $x, $(f(x))")
    if abs(f(x)) < 1.0e-6
        break
    end
    x = x - f(x) / df(x)
    push!(sq, x)
end

using Plots
error = abs.(sq .- √2)
plot(error, marker=:auto)