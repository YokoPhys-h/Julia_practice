f = open("/Users/yoko-h/Desktop/Julia_practice/APG4b/input.txt")
num = readline(f) |> x -> parse(Int64, x)
if num == 1
    price = readline(f) |> x -> parse(Int64, x)
    N = readline(f) |> x -> parse(Int64, x)
    println(N * price)
elseif num == 2
    text = readline(f)
    price = readline(f) |> x -> parse(Int64, x)
    N = readline(f) |> x -> parse(Int64, x)
    println(text * "!")
    println(N * price)
end
close(f)
