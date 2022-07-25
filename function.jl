function readdata()
    filename = "test.txt"
    dataset = readlines(filename)
    numdata = countlines(filename)
    column1 = Float64[]
    column2 = Float64[]
    for i in 1:numdata
        u = split(dataset[i]) #スプリット
        push!(column1, parse(Int64, u[1])) ## 変換
        push!(column2, parse(Float64, u[2])) ## 変換
    end
    return column1, column2
end

x, y = readdata()
