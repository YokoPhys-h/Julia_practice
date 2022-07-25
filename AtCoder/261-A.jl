function main()
    function readdata()
        filename = "test.txt"
        dataset = readlines(filename)
        numdata = countlines(filename)
        column1 = Int64[]
        column2 = Int64[]
        column3 = Int64[]
        column4 = Int64[]
        for i in 1:numdata
            u = split(dataset[i]) #スプリット
            push!(column1, parse(Int64, u[1])) ## 変換
            push!(column2, parse(Int64, u[2]))
            push!(column3, parse(Int64, u[3]))
            push!(column4, parse(Int64, u[4]))
        end
        return column1, column2, column3, column4
    end

    L1, R1, L2, R2 = readdata()

    if R1[1] <= L2[1]
        rb = 0
    elseif R2[1] <= L1[1]
        rb = 0
    elseif (L1[1] <= L2[1]) && (R2[1] <= R1[1])
        rb = R2[1] - L2[1]
    elseif (L1[1] <= L2[1]) && (R1[1] <= R2[1])
        rb = R1[1] - L2[1]
    elseif (L2[1] <= L1[1]) && (R1[1] <= R2[1])
        rb = R1[1] - L1[1]
    elseif (L2[1] <= L1[1]) && (R2[1] <= R1[1])
        rb = R2[1] - L1[1]
    else
        rb = 0
    end
    println(rb)
end

main()