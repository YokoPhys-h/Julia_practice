n = 100
fp = open("test.txt", "w")
for i in 1:n
    x = rand()
    println(fp, i, "\t", x)
end
close(fp)

filename = "test.txt"
dataset = readlines(filename)
numdata = countlines(filename)
xs = zeros(Float64, numdata)
for i in 1:numdata
    # println(dataset[i])
    u = split(dataset[i])
    # println(u)
    i2 = parse(Int64, u[1])
    xs[i2] = parse(Float64, u[2])
    println(i2)
    println(xs[i])
end