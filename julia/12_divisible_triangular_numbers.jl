#= 
https://projecteuler.net/problem=12
Problem 12: Highly Divisible Triangular Number
What is the value of the first triangle number to have over five hundred divisors?
=#

using Primes

function triangleNumber(n::Int)
    return sum(1:n)
end

function nDivs(n::Int)
    return length(divisors(n))
end

function main()
    # initialize loop
    n = 1
    tN = triangleNumber(n)
    # execute loop
    println("Searching...")
    while nDivs(tN) <= 500
        n += 1
        tN = triangleNumber(n)
    end
    println("Solution found! $tN")
end

main()