# Julia Tips
juliaを使って学んだtipsを書き溜めます.

## 文字列の操作
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
### 小数点以下切り捨て
負方向に最も近い整数へと丸める
```julia
julia> floor(-1.1)
-2.0

julia> floor( 1.1)
1.0
```

## リストへの操作
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

## 配列の操作
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

## 多次元配列
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

### すべての要素を集約して行う演算
```julia
julia> A=collect(reshape(1:10,2,5))
2×5 Matrix{Int64}:
 1  3  5  7   9
 2  4  6  8  10

julia> reduce(+,A)
55
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

julia> CSV.write("/Users/yoko-h/Desktop/Julia_practice/output.csv")
"/Users/yoko-h/Desktop/Julia_practice/output.csv"
```

#### CSV形式データの読み込み
```julia
julia> data=CSV.read("/Users/yoko-h/Desktop/Julia_practice/output.csv",DataFrame)
4×2 DataFrame
 Row │ x          y        
     │ Float64    Float64  
─────┼─────────────────────
   1 │ 0.379024   0.656775
   2 │ 0.867377   0.583725
   3 │ 0.612905   0.582101
   4 │ 0.0963815  0.486701

julia> data
4×2 DataFrame
 Row │ x          y        
     │ Float64    Float64  
─────┼─────────────────────
   1 │ 0.379024   0.656775
   2 │ 0.867377   0.583725
   3 │ 0.612905   0.582101
   4 │ 0.0963815  0.486701

julia> data.x
4-element Vector{Float64}:
 0.3790240370540413
 0.8673773887041707
 0.6129051811911946
 0.0963814533600228
```


## Packageに関する情報
- [Primes.jl](https://juliamath.github.io/Primes.jl/v0.3/): 素数に対する演算パッケージ, 素因数分解とか素数求めるもの全般.