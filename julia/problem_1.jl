#=
Project Euler Problem 1: Multiples of 3 or 5
Find the sum of all the multiples of 3 or 5 below 1000
=#

"""
    multiples(n::Integer, max::Integer)

Compute a vector of the multiples of ``n`` less than ``max``.

# Examples
```jldoctest
julia> multiples(3, 10)
3-element Vector{Int64}:
 3
 6
 9
````

See also: `main`
"""
function multiples(n::Integer, max::Integer)
    return collect(n:n:max)
end

function main()
    factor3 = multiples(3, 1000)
    factor5 = multiples(5, 999)
    # the above double counts multiples of 3 and 5, so use union to only get single instances of multiples of 3 or 5
    distinctMultiples = union(factor3, factor5)
    total = sum(distinctMultiples)
    return total
end

main()