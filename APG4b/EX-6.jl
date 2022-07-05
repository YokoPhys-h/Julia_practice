f = open("/Users/yoko-h/Desktop/Julia_practice/APG4b/input.txt")
Ap, op, Bp = readline(f) |> split
A, B = parse(Int64, Ap), parse(Int64, Bp)

if op == "+"
    println(A + B)
elseif op == "-"
    println(A - B)
elseif op == "*"
    println(A * B)
elseif op == "/"
    if B == 0
        println("error")
    else
        println(floor(Int64, A / B))
    end
elseif op == "?"
    println("error")
elseif op == "="
    println("error")
elseif op == "!"
    println("error")
end