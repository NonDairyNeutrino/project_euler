#= 
https://projecteuler.net/problem=15
Problem 15: Lattice Paths
Starting in the top left corner of a 2x2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.  How many such routes are there through a 20x20 grid?
=#

#= 
Each path is composed of exactly 20 rights and 20 downs.
Represent this as a sequence of 40 zeros or ones, as long as there is 20 of each.
Start with a path that is all right, then all down; which takes the form of 20 zeros followed by 20 ones.
=#

using Dates

function swap(vector::Vector{Int}, i::Int, j::Int)
    newVector = copy(vector)
    newVector[i] = vector[j]
    newVector[j] = vector[i]
    return newVector
end

function updater(pathStack)
    if length(pathStack) % 10^3 == 0
        println("number of paths so far: ", length(pathStack), " at time ", Dates.format(now(), "I:M:S"))
    end
end

function swapTree(path::Vector{Int}, pathStack)
    inPathStack = in(pathStack)
    for i in 1:length(path)-1
        if path[i:i+1] == [0,1]
            swapped = swap(path, i, i+1)
            # println("path: $path", " swapped: $swapped")
            !inPathStack(swapped) ? (push!(pathStack, swapped); updater(pathStack)) : continue
            swapTree(swapped, pathStack)
        else
            # println("path: $path", " index: $i")
            continue
        end
    end
end

function main()
    # initialize parameters
    dimension = 9
    path0 = [zeros(Int, dimension); ones(Int, dimension)]

    pathStack = [path0]
    swapTree(path0, pathStack)
    println("Number of paths for a $dimension x $dimension grid: $(length(pathStack))")
end

main()