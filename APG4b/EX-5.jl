# N
# M
#というように渡される場合は
# N=readline() M=readline() とする. 
# N=parse.(Int64,readline())
# M=parse.(Int64,readline())
# println(N)
# println(M)
# または
# 入力
# 1
# 2
# a=readline() |> x -> parse(Int64,x)
# println(a)

# 入力
# 2 3
# N, W = readline() |> split .|> x -> parse(Int64,x)
# N,W=a
# println(a) # [2, 3]
# println(N) # 2
# println(W) # 3
# println(a[1]) # 2
# println(a[2]) # 3

f = open("/Users/yoko-h/Desktop/Julia_practice/APG4b/input.txt")
N, W = readline(f) |> split .|> x -> parse(Int64, x)
println(N + W)
close(f)