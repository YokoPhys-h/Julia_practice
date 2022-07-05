# 変数
x = 1

y = 2.0

ans

2x + 3

θ = π / 4

typeof(1)


x = 1

x += 1

1 + 2im

real(1 + 2im)

s = "hello julia!"

typeof(s)
s[1]
s[end]
s[1:5]

s = "こんにちは julia"

Vector{Char}(s)
s[1]

length("julia")

repeat("julia", 2)
replace("python is the best!", "python" => "julia")

# 正規表現
regex = r"J.*g"
typeof(regex)

m = match(regex, "JuliaLang is the best")

m.match

x = 3;
y = 2;

if x < y
    println("x is less than y")
elseif x > y
    println("x is grater than y")
else
    println("x is equal to y")
end

x = 100;
x > 100 ? true : false

n = 100;

## ループ
i = 1;

while i <= 5
    println(i)
    global i += 1
end

for i in 1:5
    println(i)
end

function add(x, y)
    return x + y
end

add_typed(x::Int, y::Int)::Float64 = x + y;
add_typed(1, 2)

function sum_diff(x, y)
    return (x + y, x - y)
end
sum_diff(1, 4)

list = []
list = [1, 2]
push!(list, 3)
pop!(list)

using Plots
plotly()
plot(sin)

A = [x^2 + y^2 for x in -1:01:1, y in -1:0.2:1]

plot(A)
contour(A)
heatmap(A)

wireframe(A)

surface(A)

plot(x -> x^4 - 20 * x^2 + 1)

savefig("hoge2.png")

using Interact

@manipulate for x in 0:10
    x^2
end
