#= 
https://projecteuler.net/problem=11
Problem 11: Largest Product in a Grid
What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20x20 grid
=#

using Test

"""
    inputToMatrix(grid::String)

Parse a string formatted grid of integers to a matrix

# Examples
```jldoctest
>julia input = "
1 2
3 4
"
2×2 Matrix{Int64}:
 1  2
 3  4
```

See also `split`, `parse`, `collect`
"""
function inputToMatrix(gridString::String)
    numStringVector = split(gridString)                          # split at space or newline, giving a Vector
    sqrdim = Int(sqrt(length(numStringVector)))                  # get dimension of square grid
    numStringMatrix = reshape(numStringVector, (sqrdim, sqrdim)) # turn vector into matrix of strings
    numMatrix = parse.(Int, numStringMatrix)                     # parse strings to numbers
    numMatrix = collect(transpose(numMatrix))                    # transpose to match input and convert to Matrix{Int}
    return numMatrix
end

# TODO: Include Inf as an option for chunkSize to get the rest of the array in that direction

"""
    diagChunk(array::Matrix{Int}, ind::Union{Tuple{Int,Int},CartesianIndex{2}}, chunkSize::Int)

Get the diagonal elements of a matrix starting at some position.

# Examples
```jldoctest
julia> mat = collect(transpose(reshape(1:9, (3,3))))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> diag(mat, (2,2), 2)
2-element Vector{Int64}:
 5
 9

julia> diag(mat, (2,1), 2)
2-element Vector{Int64}:
 4
 8
"""
function diagChunk(array::Matrix{Int}, ind::Union{Tuple{Int,Int},CartesianIndex{2}}, chunkSize::Int)
    # CartesianIndex nor CartesianIndices support "diagonal" incrementation
    # CartesianIndices only gives a matrix of indices
    # idk restort to loop I guess
    inds = [CartesianIndex(ind) + n * CartesianIndex((1, 1)) for n in 0:chunkSize-1]
    return array[inds]
end

function diagChunk(args::Union{Tuple{Any,Any,Any},NamedTuple})
    return diagChunk(args...)
end

"""
    rightChunk(array::Matrix{Int}, ind::Union{Tuple{Int, Int}, CartesianIndex{2}}, chunkSize::Int)

TBW
"""
function rightChunk(array::Matrix{Int}, ind::Union{Tuple{Int,Int},CartesianIndex{2}}, chunkSize::Int)
    index = CartesianIndex(ind)
    indexOffset = CartesianIndex((0, chunkSize - 1))
    stillAMatrix = array[index:index+indexOffset]
    return vec(stillAMatrix)
end

function rightChunk(args::Union{Tuple{Any,Any,Any},NamedTuple})
    return rightChunk(args...)
end

"""
    downChunk(array::Matrix{Int}, ind::Union{Tuple{Int, Int}, CartesianIndex{2}}, chunkSize::Int)

TBW
"""
function downChunk(array::Matrix{Int}, ind::Union{Tuple{Int,Int},CartesianIndex{2}}, chunkSize::Int)
    return array[ind[1]:ind[1]+chunkSize-1, ind[2]]
end

function downChunk(args::Union{Tuple{Any,Any,Any},NamedTuple})
    return downChunk(args...)
end

"""
    diagDomain(array::Matrix{Int}, len::Int)

TBW
"""
function diagDomain(array::Matrix{Int}, len::Int)
    return CartesianIndices(array)[1:end-len+1, 1:end-len+1]
end

"""
    rightDomain(array::Matrix{Int}, len::Int)

TBW
"""
function rightDomain(array::Matrix{Int}, len::Int)
    return CartesianIndices(array)[:, 1:end-len+1]
end

"""
    downDomain(array::Matrix{Int}, len::Int)

TBW
"""
function downDomain(array::Matrix{Int}, len::Int)
    return CartesianIndices(array)[1:end-len+1, :]
end

"""
    debugTest()

TBW
"""
function debugTest()
    if split(PROGRAM_FILE, "\\")[end] == "run_debugger.jl"

        testMat = collect(transpose(reshape(1:9, (3,3))))
        testArg = (mat=testMat, ind=(2,2), len=2)

        @testset verbose = true "Function Tests" begin
            @testset "Chunk Tests" begin
                @test diagChunk(testArg) == [5, 9]
                @test rightChunk(testArg) == [5, 6]
                @test downChunk(testArg) == [5, 8]
            end
            @testset "Domain Tests" begin
                @test diagDomain(testArg.mat, testArg.len) == CartesianIndices((2, 2))
                @test rightDomain(testArg.mat, testArg.len) == CartesianIndices((3, 2))
                @test downDomain(testArg.mat, testArg.len) == CartesianIndices((2, 3))
            end
        end
    end
end

const gridString = "08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48"

function main(gridString=gridString, chunkSize=4)
    debugTest()
    
    mat = inputToMatrix(gridString)
    rightProd = maximum([prod(rightChunk(mat, chunkIndex, chunkSize)) for chunkIndex in rightDomain(mat, chunkSize)])
    downProd = maximum([prod(downChunk(mat, chunkIndex, chunkSize)) for chunkIndex in downDomain(mat, chunkSize)])
    diagProd = maximum([prod(diagChunk(mat, chunkIndex, chunkSize)) for chunkIndex in diagDomain(mat, chunkSize)])
    output = max(rightProd, downProd, diagProd)
    println(output)
end

main()