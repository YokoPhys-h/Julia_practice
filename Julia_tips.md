# Julia Tips
juliaを使って学んだtipsを書き溜めます.

## 型の操作
### 数値精度を上げる
```julia
julia> π
π = 3.1415926535897...

julia> BigFloat(π)
3.141592653589793238462643383279502884197169399375105820974944592307816406286198
```

## 文字列の操作
### 複数文字出力のタブ間隔空け
```julia
julia> a=4; b=3;

julia> println(a,b)
43

julia> println(a,"\t",b)
4       3
```

### 文字列に含まれる文字の取得
```julia
julia> s = "Hello Julia"
"Hello Julia"
julia> s[1]
"H" #文字列の一番最初が出力される
julia> s[1:5]
"Hello" # 文字列の出力範囲を指定できる. 
```

### 文字列の連結
```julia
julia> hello = "Hello";
julia> julia = "Julia";
julia> string(hello, " ", julia)
"Hello Julia"
julia> hello * " " * julia
"Hello Julia"
```

### 文字列の複数回出力
```julia
julia> hoge="hoge"
"hoge"

julia> hoge^5
"hogehogehogehogehoge"
```

### 文字列のうち, 特定の範囲の文字を取り込む
```julia
julia> hoge[1]
'h': ASCII/Unicode U+0068 (category Ll: Letter, lowercase)

julia> hoge[2:4]
"oge"
```

### 評価結果を文字列に埋め込む
```julia
julia> "1 + 2 = $(1 + 2)"
"1+2=3"
```

### 日本語などのUnicode文字列に対する操作
日本語などUTF-8は文字を可変長で符号化するため, 全ての文字が同じバイト数で表現されるわけではない. (ひらがなの多くは3バイト) したがってバイト数がずれたものを出力しようとするとErrorが生じる.
```julia
julia> s="こんにちは Julia";
julia> s[1]
ERROR: 
```
この場合は一度文字列を配列に変換するのがよい. 
```julia
julia> chars = Vector{Char}(s)
11-element Vector{Char}:
 'こ': Unicode U+3053 (category Lo: Letter, other)
 'ん': Unicode U+3093 (category Lo: Letter, other)
 'に': Unicode U+306B (category Lo: Letter, other)
 'ち': Unicode U+3061 (category Lo: Letter, other)
 ⋮
 'u': ASCII/Unicode U+0075 (category Ll: Letter, lowercase)
 'l': ASCII/Unicode U+006C (category Ll: Letter, lowercase)
 'i': ASCII/Unicode U+0069 (category Ll: Letter, lowercase)
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 julia> s[1]
 "こ"
```

## 演算
### 分数の計算
```julia
julia> 1//2+1//3
5//6
```

### 複素共役
```julia
julia> conj(4+5im)
4 - 5im
```

### コンビネーション
$_nC_m$の計算
```julia
julia> binomial(10,3)
120
```

### 階乗
```julia
julia> factorial(5)
120
```

### 小数点以下切り捨て
負方向に最も近い整数へと丸める
```julia
julia> floor(-1.1)
-2.0

julia> floor( 1.1)
1.0
```

### パイプライン演算
以下は同様の演算
```julia
julia> f(n,x)=cos(n*acos(x))
f (generic function with 1 method)
 
julia> g(x)=n*acos(x) |> cos
g (generic function with 1 method)
```

### ifelse条件分岐関数
最初の条件式がTrueなら2番目, falseなら3番目が返ってくる.
```julia
julia> ReLu(x)=ifelse(x<0,zero(x),x)
ReLu (generic function with 1 method)
```

### 範囲指定
```julia
julia> 1:2.5:10
1.0:2.5:8.5

julia> range(1,10,step=2.5)
1.0:2.5:8.5
```

### 等間隔で任意の点数の範囲をつくる
```julia
julia> range(0,2pi,length=10)
0.0:0.6981317007977318:6.283185307179586
```

### 指定の底でのlog
```julia
julia> log(2,8)
3.0
```

## 乱数
### 乱数の生成
```julia
julia> rand(2,3) ## 0~1の乱数
2×3 Matrix{Float64}:
 0.622121  0.568923   0.34898
 0.941021  0.0742494  0.624339

julia> rand(Int64,2,3)
2×3 Matrix{Int64}:
  5661848704774868963   5803618174787596102  -3111274951104142376
 -5369017176417626184  -5434974966175551714  -2108369232511630294
```

### 指定範囲の乱数
```julia
julia> rand(10:20, 3, 3)
3×3 Matrix{Int64}:
 12  10  11
 20  18  18
 16  19  11
```


## 配列への操作
### 末尾に要素を加える
```julia
julia> list=[1,2]
2-element Vector{Int64}:
 1
 2

julia> push!(list,3)
3-element Vector{Int64}:
 1
 2
 3
```

### 末尾の要素を取り出す
```julia
julia> pop!(list)
3
```

### 最初の要素を取り出す
```julia
julia> popfirst!(list)
1
```

### i番目に要素を追加する
```julia
julia> insert!(list,2,4)
3-element Vector{Int64}:
 1
 4
 2
```

### i番目の要素を消去する
```julia
julia> deleteat!(list,3)
2-element Vector{Int64}:
 1
 4
```

### 重複を消去して取得する(ユニークな値を返す）.
```julia
julia> unique([1, 2, 6, 2])
3-element Array{Int64,1}:
 1
 2
 6

julia> unique(Real[1, 1.0, 2])
2-element Array{Real,1}:
 1
 2
```

### 関数を適用した時にユニークな値を返す
```julia
julia> unique(x -> x^2, [1, -1, 3, -3, 4])
3-element Array{Int64,1}:
 1
 3
 4
```



### 要素をソートする. 
```julia
julia> a1=[10,5,-7,0]
4-element Vector{Int64}:
 10
  5
 -7
  0

julia> sort(a1)
4-element Vector{Int64}:
 -7
  0
  5
 10
```

#### 逆順ソート
```julia
julia> sort([2,3,1], rev=true)
3-element Array{Int64,1}:
 3
 2
 1
```

### 最大値最小値を取得する. 
```julia
julia> maximum([1 20 15])
20

julia> minimum([1 20 15])
1
```

### 一様分布で初期化された配列
```julia
julia> rand(Float32,3,4)
3×4 Matrix{Float32}:
 0.673946  0.135566  0.0409374  0.308871
 0.726887  0.40095   0.387763   0.362832
 0.597126  0.955296  0.697196   0.509099
```
### 正規分布で初期化された配列
```julia
julia> randn(Float32,3,4)
3×4 Matrix{Float32}:
 -1.67169    1.04564  -0.107342   1.64487
 -0.731135   1.47789  -0.406963   0.0837571
  0.120444  -1.22306   0.651821  -0.239374
```

### 1で初期化された配列
```julia
julia> ones(Float32,3,4)
3×4 Matrix{Float32}:
 1.0  1.0  1.0  1.0
 1.0  1.0  1.0  1.0
 1.0  1.0  1.0  1.0
```

### 0で初期化された配列
```julia
julia> zeros(Float32,3,4)
3×4 Matrix{Float32}:
 0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0
```

### 任意の値で初期化
```julia
julia> fill(1.3,2,4)
2×4 Matrix{Float64}:
 1.3  1.3  1.3  1.3
 1.3  1.3  1.3  1.3
```

### 配列の要素の型
```julia
julia> A=rand(2,3);
julia> eltype(A)
Float64
```

### 配列の要素数
```julia
julia> length(A)
6
```

### 配列のサイズ  
```julia
julia> B=rand(3,2)
3×2 Matrix{Float64}:
 0.582339   0.574658
 0.0794225  0.183327
 0.909358   0.245754

julia> size(B)
(3, 2)
```

### 配列の次元の数
```julia
julia> B=rand(3,4)
3×4 Matrix{Float64}:
 0.0311765  0.600243   0.657966  0.130403
 0.54767    0.188354   0.424964  0.768384
 0.692218   0.0409334  0.762411  0.343303

julia> ndims(B)
2
```

### 配列の各要素に関数を適用するmap
```julia
julia> collection=[1, 2, 4]
3-element Vector{Int64}:
 1
 2
 4

julia> map(x -> x^2, collection)
3-element Vector{Int64}:
  1
  4
 16
```

### ベクトルの定義
```julia
julia> A=[1,2]
2-element Vector{Int64}:
 1
 2
```

### 配列の要素の追加と消去
基本的にはあらかじめサイズがわかっている方が早いが, 途中でサイズを変えたい場合.
```julia
julia> A=Float64[]
Float64[]

julia> push!(A,2)
1-element Vector{Float64}:
 2.0

julia> push!(A,3,4,5)
4-element Vector{Float64}:
 2.0
 3.0
 4.0
 5.0

julia> deleteat!(A,2)
3-element Vector{Float64}:
 2.0
 4.0
 5.0

julia> deleteat!(A,2:3)
1-element Vector{Float64}:
 2.0
```

### 2つの行列の合体
```julia
julia> A=[1,2,3]; B=[3,4,5];

julia> append!(A,B)
6-element Vector{Int64}:
 1
 2
 3
 3
 4
 5
```

### 行列の定義
```julia
julia> B=[1 2]
1×2 Matrix{Int64}:
 1  2

julia> B=[1 2
       3 4]
2×2 Matrix{Int64}:
 1  2
 3  4
```

### 行列から列を取り出す
```julia
julia> A=[1 2 3
       4 5 6
       7 8 9]
3×3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> A[:,1]
3-element Vector{Int64}:
 1
 4
 7

julia> A[begin:end,1]
3-element Vector{Int64}:
 1
 4
 7
```

### 配列形状の変更
```julia
julia> reshape(A,(1,4))
1×4 Matrix{Int64}:
 1  3  2  4
```

### 配列の各要素に関数を適用するmap
```julia
julia> A=rand(2,3)
2×3 Matrix{Float64}:
 0.234424  0.791376  0.411471
 0.351312  0.489175  0.658489

julia> map(x->x+1.0,A)
2×3 Matrix{Float64}:
 1.23442  1.79138  1.41147
 1.35131  1.48917  1.65849
```

### すべての要素に演算子を適用するreduce
```julia
julia> A=collect(reshape(1:10,2,5))
2×5 Matrix{Int64}:
 1  3  5  7   9
 2  4  6  8  10

julia> reduce(+,A)
55
```

### 要素への一括適用broadcast
```julia
julia> collection=[1, 2, 4]
3-element Vector{Int64}:
 1
 2
 4

julia> f(x)=exp(x)
f (generic function with 1 method)

julia> broadcast(f,collection)
3-element Vector{Float64}:
  2.718281828459045
  7.38905609893065
 54.598150033144236

julia> A=[1 2 
       3 4]
2×2 Matrix{Int64}:
 1  2
 3  4

julia> A.+2
2×2 Matrix{Int64}:
 3  4
 5  6

julia> f(x)=exp(x)
f (generic function with 1 method)

julia> f.(A)
2×2 Matrix{Float64}:
  2.71828   7.38906
 20.0855   54.5982
```



### 要素にフィルタリングをして取り出す
```julia
julia> A=collect(reshape(1:10,2,5))
2×5 Matrix{Int64}:
 1  3  5  7   9
 2  4  6  8  10

julia> filter(x -> x > 5, A)
5-element Vector{Int64}:
  6
  7
  8
  9
 10
```

### 配列からサブ配列をつくるview
```julia
julia> A=rand(3,3)
3×3 Matrix{Float64}:
 0.0421387  0.229252  0.781823
 0.0483192  0.430909  0.276979
 0.428952   0.810995  0.51132

julia> view(A,1,2:3)
2-element view(::Matrix{Float64}, 1, 2:3) with eltype Float64:
 0.22925192437512287
 0.7818227480885235

julia> view(A,1,:)
3-element view(::Matrix{Float64}, 1, :) with eltype Float64:
 0.04213868113521613
 0.22925192437512287
 0.7818227480885235

julia> view(A,1:2,:)
2×3 view(::Matrix{Float64}, 1:2, :) with eltype Float64:
 0.0421387  0.229252  0.781823
 0.0483192  0.430909  0.276979
```

## 便利な配列のような型
### 集合型関数Set
集合を表す型. 重複しない要素が入った配列
```julia
julia> a=Set()
Set{Any}()

julia> push!(a,4,"banana",3)
Set{Any} with 3 elements:
  4
  "banana"
  3

julia> push!(a,4) ## 既に持っているものをpush!しても変わらない.
Set{Any} with 3 elements:
  4
  "banana"
  3
```

Setの型を指定する場合は以下.
```julia
julia> a=Set{Float64}[]
Set{Float64}[]
```



## 線形代数演算
### 内積
```julia
julia> using LinearAlgebra
julia> a=[3,2im]
2-element Vector{Complex{Int64}}:
 3 + 0im
 0 + 2im

julia> dot(a,a)
13 + 0im

julia> a⋅a
13 + 0im
```

### 外積
```julia
julia> b=[1,2,3]
3-element Vector{Int64}:
 1
 2
 3

julia> cross(b,b)
3-element Vector{Int64}:
 0
 0
 0
```

### 連立方程式を解く
$A\bm{x}=\bm{b}$を解く.
```julia
julia> x=A\b
3-element Vector{ComplexF64}:
 -0.25944073351059127 - 1.6786716182797186im
    2.735770759603039 - 0.590531713280667im
 -0.13193090770994587 - 0.838912841112185im
```

### 固有値方程式を解く
固有値問題$A\bm{v}_i=e_{i}\bm{v}_i$を解く.
```julia
julia> e,v=eigen(A)
Eigen{ComplexF64, ComplexF64, Matrix{ComplexF64}, Vector{ComplexF64}}
values:
3-element Vector{ComplexF64}:
 0.05949837933710588 + 0.02707888896953431im
   0.322147815491434 + 0.5948045439933649im
  1.6972247251595767 + 1.3353684086229252im
vectors:
3×3 Matrix{ComplexF64}:
   0.68933+0.0im       -0.0819879-0.217994im  0.544277+0.0804345im
 -0.561999-0.141075im    0.812305+0.0im       0.681438+0.0im
 -0.299451+0.315291im   -0.466251+0.261779im  0.467324-0.1206im
```
i番目の固有値e[i]に対応するを取り出したい場合
```julia
julia> v[:,2]
3-element Vector{ComplexF64}:
 -0.08198789750721987 - 0.21799387441734192im
   0.8123045468392248 + 0.0im
 -0.46625066420713185 + 0.26177909903120955im
```
固有値のみ
```julia
julia> eigvals(A)
3-element Vector{ComplexF64}:
 0.05949837933710588 + 0.02707888896953431im
   0.322147815491434 + 0.5948045439933649im
  1.6972247251595767 + 1.3353684086229252im
```
固有ベクトルのみ
```julia
julia> eigvecs(A)
3×3 Matrix{ComplexF64}:
   0.68933+0.0im       -0.0819879-0.217994im  0.544277+0.0804345im
 -0.561999-0.141075im    0.812305+0.0im       0.681438+0.0im
 -0.299451+0.315291im   -0.466251+0.261779im  0.467324-0.1206im
```

### 行列式
```julia
julia> det(A)
-0.053712950983665284 + 0.07895726691355046im
```

### 逆行列
```julia
julia> inv(A)
3×3 Matrix{ComplexF64}:
  8.09913-3.51724im   -2.46817+2.22976im  -5.39516-2.2121im
 -6.75595+1.08291im     2.8675-2.12842im   3.50308+3.4917im
 -2.04928+4.93101im  0.0607824-1.68335im   4.02453-2.27731im
```

### 複素共役
```julia
julia> A=rand(ComplexF64,3,3)
3×3 Matrix{ComplexF64}:
 0.923208+0.0229548im  0.0689094+0.918959im  0.981515+0.714355im
 0.337755+0.815195im   0.0720902+0.420806im  0.334058+0.378507im
 0.229002+0.0795494im   0.780935+0.466811im  0.383953+0.672782im

julia> A'
3×3 adjoint(::Matrix{ComplexF64}) with eltype ComplexF64:
  0.923208-0.0229548im   0.337755-0.815195im  0.229002-0.0795494im
 0.0689094-0.918959im   0.0720902-0.420806im  0.780935-0.466811im
  0.981515-0.714355im    0.334058-0.378507im  0.383953-0.672782im
```

### 転置
```julia
julia> transpose(A)
3×3 transpose(::Matrix{ComplexF64}) with eltype ComplexF64:
  0.923208+0.0229548im   0.337755+0.815195im  0.229002+0.0795494im
 0.0689094+0.918959im   0.0720902+0.420806im  0.780935+0.466811im
  0.981515+0.714355im    0.334058+0.378507im  0.383953+0.672782im
```

### トレース
```julia
julia> using LinearAlgebra

julia> A=rand(1:10,3,3)
3×3 Matrix{Int64}:
 6  7  1
 1  5  7
 8  3  7

julia> tr(A)
18
```

## パラメータや変数をまとめる: struct
struct: 一度定義したら中身を変更できない.
mutable struct: 中身の変更が可能.
```julia
julia> m1=0.3; r1=[0.2,0.5,0.1]; v1=[0.3,2,-1];

julia> mutable struct Atom
       r
       v
       mass
       end

julia> atom1= Atom(r1, v1, m1)
Atom([0.2, 0.5, 0.1], [0.3, 2.0, -1.0], 0.3)

julia> atom1.r
3-element Vector{Float64}:
 0.2
 0.5
 0.1

julia> atom1.v
3-element Vector{Float64}:
  0.3
  2.0
 -1.0

julia> atom1.mass
0.3
```


## モジュールの活用
### ファイルの分割
ソースコードのファイルを取り込む`include`関数を用いてファイルの分割を行う. なお, ファイルのパスは絶対パスで記載する.
```julia
module Foo
include("hoge/file1.jl")
include("hoge/file2.jl")
include("hoge/file3.jl")
end
```
## ファイルの読み書き
### ファイルの配列としての読み込み
```julia
julia> f=open("/Users/yoko-h/Desktop/Julia_practice/hoge.txt")
IOStream(<file /Users/yoko-h/Desktop/Julia_practice/hoge.txt>)
julia> readlines(f)
1-element Vector{String}:
 "Hello Julia!"
julia> close(f)
```
### 1行ずつの読み込み
```julia
julia> f=open("/Users/yoko-h/Desktop/Julia_practice/hoge.txt","r")
IOStream(<file /Users/yoko-h/Desktop/Julia_practice/hoge.txt>)
julia> for line in eachline(f)
       println(line)
       end
Hello Julia!
julia> close(f)
```

```julia
julia> open("/Users/yoko-h/Desktop/Julia_practice/hoge.txt","r") do f
           for line in eachline(f)
               println(line)
           end
       end
Hello Julia!
```

### データの書き込み
```julia
julia> open("/Users/yoko-h/Desktop/Julia_practice/hoge.txt","w") do f
           println(f,"Line1")
       end
```


### DataFramesの利用
#### CSV形式でのデータ書き込み
```julia
julia> using DataFrames

julia> using CSV

julia> x=rand(4)
4-element Vector{Float64}:
 0.3790240370540413
 0.8673773887041707
 0.6129051811911946
 0.0963814533600228

julia> y=rand(4)
4-element Vector{Float64}:
 0.6567748575760815
 0.583725243812666
 0.5821007015770637
 0.486700661573537

julia> f=DataFrame(x=x,y=y)
4×2 DataFrame
 Row │ x          y        
     │ Float64    Float64  
─────┼─────────────────────
   1 │ 0.379024   0.656775
   2 │ 0.867377   0.583725
   3 │ 0.612905   0.582101
   4 │ 0.0963815  0.486701

julia> CSV.write("/Users/yoko-h/Desktop/Julia_practice/output.csv",f)
"/Users/yoko-h/Desktop/Julia_practice/output.csv"
```

#### TXT形式データの読み込み
```julia
julia> #データダウンロード
julia> download("https://archive.ics.uci.edu/ml/machine-learning-databases/auto-mpg/auto-mpg.data-original", "auto.txt") ## データダウンロード
"auto.txt"

julia> # String形式で読み込み
julia> raw_str=read("/Users/yoko-h/Desktop/Julia_practice/auto.txt",String) ## String形式で読み込み
"18.0   8.   307.0      130.0      3504.      12.0   70.  1.\t\"chevrolet chevelle malibu\"\n15.0   8.   350.0      165.0      3693.      11.5   70.  1.\t\"buick skylark 320\"\n18.0   8.   318.0      150.0      3436.      11.0   70.  1.\t\"plymouth satellite\"\n16.0   8.   304.0      150.0      3433.      12.0   70.  1.\t\"amc rebel sst\"\n17.0   8.   302.0      140.0      3449.      10.5   70.  1.\t\"ford torino\"\n15.0   8.   429.0      198.0      4341.      10.0   70.  1.\t" ⋯ 31232 bytes ⋯ " 2.2\"\n27.0   4.   151.0      90.00      2950.      17.3   82.  1.\t\"chevrolet camaro\"\n27.0   4.   140.0      86.00      2790.      15.6   82.  1.\t\"ford mustang gl\"\n44.0   4.   97.00      52.00      2130.      24.6   82.  2.\t\"vw pickup\"\n32.0   4.   135.0      84.00      2295.      11.6   82.  1.\t\"dodge rampage\"\n28.0   4.   120.0      79.00      2625.      18.6   82.  1.\t\"ford ranger\"\n31.0   4.   119.0      82.00      2720.      19.4   82.  1.\t\"chevy s-10\"\n"

julia> #タブをスペースに
julia> str_no_tab = replace(raw_str, '\t' => ' ')
"18.0   8.   307.0      130.0      3504.      12.0   70.  1. \"chevrolet chevelle malibu\"\n15.0   8.   350.0      165.0      3693.      11.5   70.  1. \"buick skylark 320\"\n18.0   8.   318.0      150.0      3436.      11.0   70.  1. \"plymouth satellite\"\n16.0   8.   304.0      150.0      3433.      12.0   70.  1. \"amc rebel sst\"\n17.0   8.   302.0      140.0      3449.      10.5   70.  1. \"ford torino\"\n15.0   8.   429.0      198.0      4341.      10.0   70.  1. " ⋯ 31232 bytes ⋯ " 2.2\"\n27.0   4.   151.0      90.00      2950.      17.3   82.  1. \"chevrolet camaro\"\n27.0   4.   140.0      86.00      2790.      15.6   82.  1. \"ford mustang gl\"\n44.0   4.   97.00      52.00      2130.      24.6   82.  2. \"vw pickup\"\n32.0   4.   135.0      84.00      2295.      11.6   82.  1. \"dodge rampage\"\n28.0   4.   120.0      79.00      2625.      18.6   82.  1. \"ford ranger\"\n31.0   4.   119.0      82.00      2720.      19.4   82.  1. \"chevy s-10\"\n"

julia> # 読み込み形式変換(データの読み書きに便利な型)
julia> io=IOBuffer(str_no_tab)
IOBuffer(data=UInt8[...], readable=true, writable=false, seekable=true, append=false, size=32149, maxsize=Inf, ptr=1, mark=-1)

julia> # 読み込み
julia> df=CSV.File(io,
       delim=' ',## 分割間隔
       ignorerepeated=true,# 行を揃えて区切られている場合に必要. (各々の間隔が違うため)
       header=[:mpg, :cylinders, :displacement, :horsepower, :weight, :acceleration, :year, :origin, :name],## 列名
       missingstring="NA" ## 欠損した値の表示方法) |> DataFrame
406×9 DataFrame
 Row │ mpg       cylinders  displacement  horsepower  weight   acceleration  year     origin   name                      
     │ Float64?  Float64    Float64       Float64?    Float64  Float64       Float64  Float64  String                    
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │     18.0        8.0         307.0       130.0   3504.0          12.0     70.0      1.0  chevrolet chevelle malibu
   2 │     15.0        8.0         350.0       165.0   3693.0          11.5     70.0      1.0  buick skylark 320
   3 │     18.0        8.0         318.0       150.0   3436.0          11.0     70.0      1.0  plymouth satellite
  ⋮  │    ⋮          ⋮           ⋮            ⋮          ⋮          ⋮           ⋮        ⋮                 ⋮
 404 │     32.0        4.0         135.0        84.0   2295.0          11.6     82.0      1.0  dodge rampage
 405 │     28.0        4.0         120.0        79.0   2625.0          18.6     82.0      1.0  ford ranger
 406 │     31.0        4.0         119.0        82.0   2720.0          19.4     82.0      1.0  chevy s-10
                                                                                                         400 rows omitted
```

#### 行列形式の読み込み
```julia
julia> x=rand(5,5)
5×5 Matrix{Float64}:
 0.538828  0.315478  0.0633926  0.713336   0.00883301
 0.876346  0.657211  0.848946   0.01181    0.507184
 0.318878  0.715611  0.957552   0.0930531  0.166859
 0.981529  0.902519  0.521348   0.17897    0.656186
 0.750458  0.144593  0.135955   0.791016   0.292874

julia> DataFrame(x, :auto)
5×5 DataFrame
 Row │ x1        x2        x3         x4         x5         
     │ Float64   Float64   Float64    Float64    Float64    
─────┼──────────────────────────────────────────────────────
   1 │ 0.538828  0.315478  0.0633926  0.713336   0.00883301
   2 │ 0.876346  0.657211  0.848946   0.01181    0.507184
   3 │ 0.318878  0.715611  0.957552   0.0930531  0.166859
   4 │ 0.981529  0.902519  0.521348   0.17897    0.656186
   5 │ 0.750458  0.144593  0.135955   0.791016   0.292874
```

#### 読み込んだデータの列名の表示
```julia
julia> name(df)
```

#### 欠損値のカウント
```julia
julia> sum(count(ismissing, col) for col in eachcol(df))
14

julia> count(ismissing, Matrix(df))
14
```

#### 欠損値の0置き換え
```julia
julia> dropmissing(df)
392×10 DataFrame
 Row │ mpg      cylinders  displacement  horsepower  weight   acceleration  year     origin   name                       brand     
     │ Float64  Float64    Float64       Float64     Float64  Float64       Float64  Float64  String                     SubStrin… 
─────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │    18.0        8.0         307.0       130.0   3504.0          12.0     70.0      1.0  chevrolet chevelle malibu  chevrolet
   2 │    15.0        8.0         350.0       165.0   3693.0          11.5     70.0      1.0  buick skylark 320          buick
   3 │    18.0        8.0         318.0       150.0   3436.0          11.0     70.0      1.0  plymouth satellite         plymouth
  ⋮  │    ⋮         ⋮           ⋮            ⋮          ⋮          ⋮           ⋮        ⋮                 ⋮                  ⋮
 390 │    32.0        4.0         135.0        84.0   2295.0          11.6     82.0      1.0  dodge rampage              dodge
 391 │    28.0        4.0         120.0        79.0   2625.0          18.6     82.0      1.0  ford ranger                ford
 392 │    31.0        4.0         119.0        82.0   2720.0          19.4     82.0      1.0  chevy s-10                 chevy
                                                                                                                   386 rows omitted
```


#### CSV形式データの読み込み
```julia
julia> df=CSV.read("/Users/yoko-h/Desktop/Julia_practice/output.csv",DataFrame)
11×8 DataFrame
 Row │ x1     x2     x3     x4     y1       y2       y3       y4      
     │ Int64  Int64  Int64  Int64  Float64  Float64  Float64  Float64 
─────┼────────────────────────────────────────────────────────────────
   1 │    10     10     10      8     8.04     9.14     7.46     6.58
   2 │     8      8      8      8     6.95     8.14     6.77     5.76
   3 │    13     13     13      8     7.58     8.74    12.74     7.71
  ⋮  │   ⋮      ⋮      ⋮      ⋮       ⋮        ⋮        ⋮        ⋮
   9 │    12     12     12      8    10.84     9.13     8.15     5.56
  10 │     7      7      7      8     4.82     7.26     6.42     7.91
  11 │     5      5      5      8     5.68     4.74     5.73     6.89
                                                        5 rows omitted

julia> df.x1
11-element Vector{Int64}:
 10
  8
 13
  9
 11
 14
  6
  4
 12
  7
  5

julia> df[:,"x1"]
11-element Vector{Int64}:
 10
  8
 13
  9
 11
 14
  6
  4
 12
  7
  5
```


#### 条件抽出
```julia
julia> df[1:4, :x1]
4-element Vector{Int64}:
 10
  8
 13
  9

julia> df[df.A.>3,:] ## それぞれの行に適用するからブロードキャスト.
2×4 DataFrame
│ Row │ A     │ B        │ C      │ D     │
│     │ Int64 │ Float64  │ String │ Int64 │
├─────┼───────┼──────────┼────────┼───────┤
│ 1   │ 4     │ 0.578579 │ A      │ 160   │
│ 2   │ 5     │ 0.142839 │ B      │ 200   │

julia> df[df.A. == "hoge",:]
```

#### DataFrame内のデータ情報describe
```julia
julia> describe(df)

8 rows × 7 columns

variable	mean	min	median	max	nmissing	eltype
Symbol	Float64	Real	Float64	Real	Int64	DataType
1	x1	9.0	4	9.0	14	0	Int64
2	x2	9.0	4	9.0	14	0	Int64
3	x3	9.0	4	9.0	14	0	Int64
4	x4	9.0	8	8.0	19	0	Int64
5	y1	7.50091	4.26	7.58	10.84	0	Float64
6	y2	7.50091	3.1	8.14	9.26	0	Float64
7	y3	7.5	5.39	7.11	12.74	0	Float64
8	y4	7.50091	5.25	7.04	12.5	0	Float64

```

#### DataFrame内のデータの平均と分散
```julia
julia> describe(df, :mean, :std)
8×3 DataFrame
 Row │ variable  mean     std     
     │ Symbol    Float64  Float64 
─────┼────────────────────────────
   1 │ x1        9.0      3.31662
   2 │ x2        9.0      3.31662
   3 │ x3        9.0      3.31662
   4 │ x4        9.0      3.31662
   5 │ y1        7.50091  2.03157
   6 │ y2        7.50091  2.03166
   7 │ y3        7.5      2.03042
   8 │ y4        7.50091  2.03058
```

#### DataFrame内の行数, 列数を確認
```julia
julia> nrow(df), ncol(df)

(11, 8)

julia> size(df)

(11, 8)
```

#### 特定の文字列を含むものを出力
```julia
julia> select(df,r"x")
11×4 DataFrame
 Row │ x1     x2     x3     x4    
     │ Int64  Int64  Int64  Int64 
─────┼────────────────────────────
   1 │    10     10     10      8
   2 │     8      8      8      8
   3 │    13     13     13      8
  ⋮  │   ⋮      ⋮      ⋮      ⋮
   9 │    12     12     12      8
  10 │     7      7      7      8
  11 │     5      5      5      8
                    5 rows omitted
```

#### コピー配列をつくるか, 新しくメモリを作る
```julia
julia> X=houses[!,[:hoge]] ## 新しくメモリを作る(速い)

julia> X=houses[:,[:median_house_value]] # コピーを作る.
```



#### DataFrame内のデータの行列変換
```julia
julia> Matrix(df[!,[:hoge]])

julia> Matrix(select(df, r"x"))
11×4 Matrix{Int64}:
 10  10  10   8
  8   8   8   8
 13  13  13   8
  9   9   9   8
 11  11  11   8
 14  14  14   8
  6   6   6   8
  4   4   4  19
 12  12  12   8
  7   7   7   8
  5   5   5   8
```

#### 読み込んだデータ中の分割(split)
##### 空白で分ける
```julia
julia> df.name
406-element Vector{String}:
 "chevrolet chevelle malibu"
 "buick skylark 320"
 "plymouth satellite"
 "amc rebel sst"
 "ford torino"
 ⋮
 "ford mustang gl"
 "vw pickup"
 "dodge rampage"
 "ford ranger"
 "chevy s-10"

julia> split.(df.name)
406-element Vector{Vector{SubString{String}}}:
 ["chevrolet", "chevelle", "malibu"]
 ["buick", "skylark", "320"]
 ["plymouth", "satellite"]
 ["amc", "rebel", "sst"]
 ["ford", "torino"]
 ⋮
 ["ford", "mustang", "gl"]
 ["vw", "pickup"]
 ["dodge", "rampage"]
 ["ford", "ranger"]
 ["chevy", "s-10"]
```

#### 既存データへの追加
```julia
julia> df.brand = first.(split.(df.name))
406-element Vector{SubString{String}}:
 "chevrolet"
 "buick"
 "plymouth"
 "amc"
 "ford"
 ⋮
 "ford"
 "vw"
 "dodge"
 "ford"
 "chevy"

julia> df[1:10, ["name", "brand"]]
10×2 DataFrame
 Row │ name                       brand     
     │ String                     SubStrin… 
─────┼──────────────────────────────────────
   1 │ chevrolet chevelle malibu  chevrolet
   2 │ buick skylark 320          buick
   3 │ plymouth satellite         plymouth
  ⋮  │             ⋮                  ⋮
   8 │ plymouth fury iii          plymouth
   9 │ pontiac catalina           pontiac
  10 │ amc ambassador dpl         amc
                              4 rows omitted
```

#### 既存データの消去
```julia
julia> select!(df, Not([:bramd]))
```

## 大きなデータを保存し, 使用するためのArrow
### データの保存
```julia
julia> Arrow.write("auto-cleaned.arrow",df)
"auto-cleaned.arrow"
```

### DataFrame形式への変換
```julia
julia> df2=Arrow.Table("/Users/yoko-h/Desktop/Julia_practice/auto-cleaned.arrow") |> DataFrame
406×10 DataFrame
 Row │ mpg       cylinders  displacement  horsepower  weight   acceleration  year     origin   name                       brand     
     │ Float64?  Float64    Float64       Float64?    Float64  Float64       Float64  Float64  String                     String    
─────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │     18.0        8.0         307.0       130.0   3504.0          12.0     70.0      1.0  chevrolet chevelle malibu  chevrolet
   2 │     15.0        8.0         350.0       165.0   3693.0          11.5     70.0      1.0  buick skylark 320          buick
   3 │     18.0        8.0         318.0       150.0   3436.0          11.0     70.0      1.0  plymouth satellite         plymouth
  ⋮  │    ⋮          ⋮           ⋮            ⋮          ⋮          ⋮           ⋮        ⋮                 ⋮                  ⋮
 404 │     32.0        4.0         135.0        84.0   2295.0          11.6     82.0      1.0  dodge rampage              dodge
 405 │     28.0        4.0         120.0        79.0   2625.0          18.6     82.0      1.0  ford ranger                ford
 406 │     31.0        4.0         119.0        82.0   2720.0          19.4     82.0      1.0  chevy s-10                 chevy
                                                                                                                    400 rows omitted
```


#### グループ化
```julia
julia> grouped_brands = groupby(df, :brand)
GroupedDataFrame with 38 groups based on key: brand
First Group (44 rows): brand = "chevrolet"
 Row │ mpg        cylinders  displacement  horsepower  weight   acceleration  year     origin   name                              br ⋯
     │ Float64?   Float64    Float64       Float64?    Float64  Float64       Float64  Float64  String                            Su ⋯
─────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │      18.0        8.0         307.0       130.0   3504.0          12.0     70.0      1.0  chevrolet chevelle malibu         ch ⋯
   2 │      14.0        8.0         454.0       220.0   4354.0           9.0     70.0      1.0  chevrolet impala                  ch
   3 │ missing          8.0         350.0       165.0   4142.0          11.5     70.0      1.0  chevrolet chevelle concours (sw)  ch
   4 │      15.0        8.0         400.0       150.0   3761.0           9.5     70.0      1.0  chevrolet monte carlo             ch
  ⋮  │     ⋮          ⋮           ⋮            ⋮          ⋮          ⋮           ⋮        ⋮                    ⋮                     ⋱
  42 │      27.0        4.0         112.0        88.0   2640.0          18.6     82.0      1.0  chevrolet cavalier wagon          ch ⋯
  43 │      34.0        4.0         112.0        88.0   2395.0          18.0     82.0      1.0  chevrolet cavalier 2-door         ch
  44 │      27.0        4.0         151.0        90.0   2950.0          17.3     82.0      1.0  chevrolet camaro                  ch
                                                                                                          1 column and 37 rows omitted
⋮
Last Group (1 row): brand = "nissan"
 Row │ mpg       cylinders  displacement  horsepower  weight   acceleration  year     origin   name              brand     
     │ Float64?  Float64    Float64       Float64?    Float64  Float64       Float64  Float64  String            SubStrin… 
─────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │     36.0        4.0         120.0        88.0   2160.0          14.5     82.0      3.0  nissan stanza xe  nissan
```

#### グループ化したものの表示
```julia
julia> grouped_brands[("ford", )] ## 文字列からタプルに変換して取り出す.
53×10 SubDataFrame
 Row │ mpg        cylinders  displacement  horsepower  weight   acceleration  year     origin   name                   brand     
     │ Float64?   Float64    Float64       Float64?    Float64  Float64       Float64  Float64  String                 SubStrin… 
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │      17.0        8.0         302.0       140.0   3449.0          10.5     70.0      1.0  ford torino            ford
   2 │      15.0        8.0         429.0       198.0   4341.0          10.0     70.0      1.0  ford galaxie 500       ford
   3 │ missing          8.0         351.0       153.0   4034.0          11.0     70.0      1.0  ford torino (sw)       ford
  ⋮  │     ⋮          ⋮           ⋮            ⋮          ⋮          ⋮           ⋮        ⋮               ⋮                ⋮
  51 │      22.0        6.0         232.0       112.0   2835.0          14.7     82.0      1.0  ford granada l         ford
  52 │      27.0        4.0         140.0        86.0   2790.0          15.6     82.0      1.0  ford mustang gl        ford
  53 │      28.0        4.0         120.0        79.0   2625.0          18.6     82.0      1.0  ford ranger            ford
                                                                                                                  47 rows omitted
```

## 統計パッケージStatisticsの利用
### グループごとの演算
```julia
julia> brand_mpg=combine(grouped_brands #=結合したいものの指表=#, :mpg => mean #=適用する内容.=#) ## meanを変えれば様々な関数を適用できる.
37×2 DataFrame
 Row │ brand          mpg_mean 
     │ SubStrin…      Float64  
─────┼─────────────────────────
   1 │ chevrolet       20.4721
   2 │ buick           19.1824
   3 │ plymouth        21.7032
  ⋮  │       ⋮           ⋮
  35 │ vokswagen       29.8
  36 │ triumph         35.0
  37 │ nissan          36.0
                31 rows omitted
```

#### データのソート
```julia
julia> sort!(brand_mpg, :mpg_mean, rev=true)
37×2 DataFrame
 Row │ brand      mpg_mean 
     │ SubStrin…  Float64  
─────┼─────────────────────
   1 │ vw          39.0167
   2 │ nissan      36.0
   3 │ triumph     35.0
  ⋮  │     ⋮         ⋮
  35 │ chrysler    17.2667
  36 │ chevroelt   16.0
  37 │ hi           9.0
            31 rows omitted
```

## PythonおよびRパッケージ利用
### PyCallの利用
```julia
julia> using PyCall

julia> math = pyimport("math") ##ここに入れたいパッケージを入れる. 自身で定義した関数も利用可能.
PyObject <module 'math' from '/Users/yoko-h/.julia/conda/3/lib/python3.9/lib-dynload/math.cpython-39-darwin.so'>

julia> math.sin(math.pi/4)
0.7071067811865475
```

## Plotsに関する情報
### 各種設定
```julia
julia> using Plots

julia> plot(
      sin,
       -2π, 2π
       )

julia> plot(
       x -> sin(x)^2 + cos(x)^3,
       -2π, 2π, ## 範囲
       label="hoge",
       xlabel="val",
       ylabel="hoge",
       title="Behavior"
       )

julia> plot(x, y, 
            seriestype=:scatter, ## 散布図
            thickness_scaling = 0.7, ## 太さ
            opacity=0.8 ## 透明度
            )
```

### 複雑な関数のプロット
```julia
julia> plot(
       x -> sin(x)^2 + cos(x)^3,
       -2π, 2π, ## 範囲
            )
```


### 2つ以上のグラフを同時プロット
```julia
julia> x=[1:10];

julia> y1, y2 = rand(10), rand(10);

julia> plot(x, y1, label="y1")

julia> plot!(x, y2, label="y2")

julia> plot(x, [y1, y2], label=["First"  "Second"])
```



## Packageに関する情報
- [Primes.jl](https://juliamath.github.io/Primes.jl/v0.3/): 素数に対する演算パッケージ, 素因数分解とか素数求めるもの全般.
- [Clustering.jl](https://juliastats.org/Clustering.jl/stable/): クラスタリングに対する演算パッケージ
