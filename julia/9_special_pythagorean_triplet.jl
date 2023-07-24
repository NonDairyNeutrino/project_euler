#= 
https://projecteuler.net/problem=9
Problem 9: Special Pythagorean Triplet
Find the product of the numbers in a Pythagorean triple such that their sum equals 1000
=#

using Combinatorics

function isPythagoreanTriple(p::Vector{Int})
    return p[2]^2 + p[3]^2 == p[1]^2
end

function main()
    parts = collect(partitions(1000, 3))
    index = findall(isPythagoreanTriple, parts)[1]
    @show prod(parts[index])
end

main()