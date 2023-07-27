#= 
https://projecteuler.net/problem=11
Problem 11: Largest Product in a Grid
What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20x20 grid
=#

using Test

"""
    inputToMatrix(grid::String)

Parse a string formatted grid of integers to a matrix.

# Examples
```jldoctest
julia> input = "
1 2
3 4
";

julia> inputToMatrix(input)
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
    numMatrix = permutedims(numMatrix)                           # transpose to match input and convert to Matrix{Int}
    return numMatrix
end

# TODO: Include Inf as an option for chunkSize to get the rest of the array in that direction

"""
    rightChunk(array::Matrix{Int}, ind::Union{Dims{2},CartesianIndex{2}}, chunkSize::Int)

Get the elements right of some position in a matrix.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> rightChunk(mat, (2,2), 2)
2-element Vector{Int64}:
 5
 3

julia> rightChunk(mat, (2,1), 2)
2-element Vector{Int64}:
 4
 5
 ```

 See also: `CartesianIndex`, `CartesianIndices`
"""
function rightChunk(array::Matrix{Int}, ind::Union{Dims{2},CartesianIndex{2}}, chunkSize::Int)
    index = CartesianIndex(ind)
    indexOffset = CartesianIndex((0, chunkSize - 1))
    stillAMatrix = array[index:index+indexOffset]
    return vec(stillAMatrix)
end

function rightChunk(args::Union{Tuple{Any,Any,Any},NamedTuple})
    return rightChunk(args...)
end

"""
    downChunk(array::Matrix{Int}, ind::Union{Dims{2},CartesianIndex{2}}, chunkSize::Int)

Get the below some position in a matrix.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> downChunk(mat, (2,2), 2)
2-element Vector{Int64}:
 5
 8

julia> downChunk(mat, (2,1), 2)
2-element Vector{Int64}:
 4
 7
 ```

 See also: `CartesianIndex`, `CartesianIndices`
"""
function downChunk(array::Matrix{Int}, ind::Union{Dims{2},CartesianIndex{2}}, chunkSize::Int)
    return array[ind[1]:ind[1]+chunkSize-1, ind[2]]
end

function downChunk(args::Union{Tuple{Any,Any,Any},NamedTuple})
    return downChunk(args...)
end

"""
    diagChunk(array::Matrix{Int}, ind::Union{Dims{2}, CartesianIndex{2}}, chunkSize::Int; isreversed::Bool = false)

Get the diagonal elements of a matrix starting at some position.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> diagChunk(mat, (2,2), 2)
2-element Vector{Int64}:
 5
 9

julia> diagChunk(mat, (2,1), 2)
2-element Vector{Int64}:
 4
 8

 julia> diagChunk(mat, (2,2), 2, isreversed = true)
2-element Vector{Int64}:
 5
 3
 ```

 See also: `CartesianIndex`, `CartesianIndices`
"""
function diagChunk(array::Matrix{Int}, ind::Union{Dims{2},CartesianIndex{2}}, chunkSize::Int; isreversed::Bool=false)
    # CartesianIndex nor CartesianIndices support "diagonal" incrementation
    # CartesianIndices only gives a matrix of indices
    # idk restort to loop I guess
    inds = [CartesianIndex(ind) + n * CartesianIndex((1, 1)) for n in 0:chunkSize-1]

    if isreversed
        mat = reverse(array, dims = 1)
    else
        mat = array
    end

    return mat[inds]
end

"""
    diagChunk(args::Union{Tuple{Any, Any, Any}, NamedTuple})

Can also be given a Tuple of its arguments.
"""
function diagChunk(args::Union{Tuple{Any, Any, Any}, NamedTuple})
    return diagChunk(args...)
end

"""
    rightDomain(array::Matrix{Int}, len::Int)

Calculate the availabe indices that yield an directed chunk.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> rightDomain(mat, 2)
CartesianIndices((3, 2))
```

See also: `CartesianIndices`
"""
function rightDomain(array::Matrix{Int}, len::Int)
    return CartesianIndices(array)[:, 1:end-len+1]
end

"""
    downDomain(array::Matrix{Int}, len::Int)

Calculate the availabe indices that yield an directed chunk.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> downDomain(mat, 2)
CartesianIndices((2, 3))
```

See also: `CartesianIndices`
"""
function downDomain(array::Matrix{Int}, len::Int)
    return CartesianIndices(array)[1:end-len+1, :]
end

"""
    diagDomain(array::Matrix{Int}, len::Int)

Calculate the availabe indices that yield an directed chunk.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> diagDomain(mat, 2)
CartesianIndices((2, 2))
```

See also: `CartesianIndices`
"""
function diagDomain(array::Matrix{Int}, len::Int)
    return CartesianIndices(array)[1:end-len+1, 1:end-len+1]
end

"""
    rightPartition(array::Matrix{Int}, chunkSize::Int)

Partitions the matrix into directed chunks.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> rightPartition(mat, 2)
3×2 Matrix{Vector{Int64}}:
 [1, 2]  [2, 3]
 [4, 5]  [5, 6]
 [7, 8]  [8, 9]
```

See also: `rightDomain`
"""
function rightPartition(array::Matrix{Int}, chunkSize::Int)
    return [rightChunk(array, chunkIndex, chunkSize) for chunkIndex in rightDomain(array, chunkSize)]
end

"""
    downPartition(array::Matrix{Int}, chunkSize::Int)

Partitions the matrix into directed chunks.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> downPartition(mat, 2)
2×3 Matrix{Vector{Int64}}:
 [1, 4]  [2, 5]  [3, 6]
 [4, 7]  [5, 8]  [6, 9]
```

See also: `downDomain`
"""
function downPartition(array::Matrix{Int}, chunkSize::Int)
    return [downChunk(array, chunkIndex, chunkSize) for chunkIndex in downDomain(array, chunkSize)]
end

"""
    diagPartition(array::Matrix{Int}, chunkSize::Int; isreversed::Bool = false)

Partitions the matrix into directed chunks.

# Examples
```jldoctest
julia> mat = permutedims(reshape(1:9, (3,3)))
3x3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> diagPartition(mat, 2)
2×2 Matrix{Vector{Int64}}:
 [1, 5]  [2, 6]
 [4, 8]  [5, 9]
```

See also: `diagDomain`
"""
function diagPartition(array::Matrix{Int}, chunkSize::Int; isreversed::Bool = false)
    return [diagChunk(array, chunkIndex, chunkSize, isreversed = isreversed) for chunkIndex in diagDomain(array, chunkSize)]
end

function debugTest()
    if split(PROGRAM_FILE, "\\")[end] == "run_debugger.jl"

        testMat1 = permutedims(reshape(1:9, (3,3)))
        testMat2 = inputToMatrix(gridString)
        testArg1 = (mat=testMat1, ind=(2,2), len=2)
        testArg2 = (mat=testMat2, ind=(7, 9), len=4)

        @testset verbose = true begin
            @testset verbose = true "Input Parsing" begin
                @test inputToMatrix("1 2 3
                    4 5 6
                    7 8 9") == [
                        1 2 3
                        4 5 6
                        7 8 9
                    ]
            end
            @testset verbose = true "Chunk" begin
                @testset verbose = true "diagChunk" begin
                    @test diagChunk(testArg1) == [5, 9]
                    @test diagChunk(testArg2) == [26, 63, 78, 14]
                    @test_throws BoundsError diagChunk(testArg1.mat, (3,3), testArg1.len)
                    @test_throws BoundsError diagChunk(testArg2.mat, (18, 19), testArg2.len)
                end
                @testset verbose = true "rightChunk" begin
                    @test rightChunk(testArg1) == [5, 6]
                    @test rightChunk(testArg2) == [26, 38, 40, 67]
                    @test_throws BoundsError rightChunk(testArg1.mat, (3, 3), testArg1.len)
                    @test_throws BoundsError rightChunk(testArg2.mat, (18, 19), testArg2.len)
                end
                @testset verbose = true "downChunk" begin
                    @test downChunk(testArg1) == [5, 8]
                    @test downChunk(testArg2) == [26, 95, 97, 20]
                    @test_throws BoundsError downChunk(testArg1.mat, (3, 3), testArg1.len)
                    @test_throws BoundsError downChunk(testArg2.mat, (18, 19), testArg2.len)
                end
            end
            @testset verbose = true "Domain" begin
                @testset verbose = true "diagDomain" begin
                    @test diagDomain(testArg1.mat, testArg1.len) == CartesianIndices((2, 2))
                    @test diagDomain(testArg2.mat, testArg2.len) == CartesianIndices((17,17))
                end
                @testset verbose = true "rightDomain" begin
                    @test rightDomain(testArg1.mat, testArg1.len) == CartesianIndices((3, 2))
                    @test rightDomain(testArg2.mat, testArg2.len) == CartesianIndices((20,17))
                end
                @testset verbose = true "downDomain" begin
                    @test downDomain(testArg1.mat, testArg1.len) == CartesianIndices((2, 3))
                    @test downDomain(testArg2.mat, testArg2.len) == CartesianIndices((17, 20))
                end
            end
            @testset verbose = true "Partition" begin
                @test rightPartition(testArg1.mat, testArg1.len) == [
                    [[1, 2]] [[2, 3]]
                    [[4, 5]] [[5, 6]]
                    [[7, 8]] [[8, 9]]
                ]
                @test downPartition(testArg1.mat, testArg1.len) == [
                    [[1, 4]] [[2, 5]] [[3, 6]]
                    [[4, 7]] [[5, 8]] [[6, 9]]
                ]
                @test diagPartition(testArg1.mat, testArg1.len) == [
                    [[1, 5]] [[2, 6]]
                    [[4, 8]] [[5, 9]]
                ]
            end
            @testset verbose = true "Max Prod" begin
                @test maximum(prod, rightPartition(testArg1.mat, testArg1.len)) == 8 * 9
                @test maximum(prod, downPartition(testArg1.mat, testArg1.len)) == 6 * 9
                @test maximum(prod, diagPartition(testArg1.mat, testArg1.len)) == 5 * 9
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
    rightProd = maximum(prod, rightPartition(mat, chunkSize))
    downProd  = maximum(prod, downPartition(mat, chunkSize))
    diagProd  = maximum(prod, diagPartition(mat, chunkSize))
    # the above implementation doesn't reach the lower left and top right corners of the grid
    # reverse rows to effectively get to them
    # this is also effectively applying the same algorithm but with the direction of the diagonal reverse (i.e. down-left instead of down-right) on the original grid
    otherDiagProd = maximum(prod, diagPartition(mat, chunkSize, isreversed = true))
    maxProd = max(rightProd, downProd, diagProd, otherDiagProd)
    println("Largest product: $maxProd")
end

main()