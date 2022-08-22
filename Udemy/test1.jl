# Clustering
using DataFrames
using CSV

houses = CSV.File("/Users/yoko-h/Desktop/Julia_practice/newhouses.csv") |> DataFrame

names(houses)

using JSON ## JSONファイルの読み込み用
using VegaLite ## MapのJSONファイルの読み込みをいい感じにする.
using VegaDatasets ## Mapをいい感じに表示する. 
using Plots

## JSONファイルの読み込み
cali_shape = JSON.parsefile("/Users/yoko-h/Desktop/Julia_practice/california-counties.json")
VV = VegaDatasets.VegaJSONDataset(cali_shape, "/Users/yoko-h/Desktop/Julia_practice/california-counties.json")

@vlplot(width = 500, height = 300) +
@vlplot(
    mark = {
        :geoshape,
        fill = :black,
        stroke = :white
    },
    data = {
        values = VV,
        format = {
            type = :topojson,
            feature = :cb_2015_california_county_20m
        }
    },
    projection = {type = :albersUsa},
) +
@vlplot(
    :circle,
    data = houses,
    projection = {type = :albersUsa},
    longitude = "longitude:q",
    latitude = "latitude:q",
    size = {value = 12},
    color = "median_house_value:q")

bucketprice = Int.(div.(houses[!, :median_house_value], 100000))

extrema(bucketprice)

insertcols!(houses, 3, :cprice => bucketprice)

@vlplot(width = 500, height = 300) +
@vlplot(
    mark = {
        :geoshape,
        fill = :black,
        stroke = :white
    },
    data = {
        values = VV,
        format = {
            type = :topojson,
            feature = :cb_2015_california_county_20m
        }
    },
    projection = {type = :albersUsa},
) +
@vlplot(
    :circle,
    data = houses,
    projection = {type = :albersUsa},
    longitude = "longitude:q",
    latitude = "latitude:q",
    size = {value = 12},
    color = "cprice:n")


# K-means Clustering
using Clustering
houses = dropmissing(houses)

X = houses[!, [:median_house_value]]

using LinearAlgebra

C = kmeans(Matrix(X)', 5)

C.assignments
