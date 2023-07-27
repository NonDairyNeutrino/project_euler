#= 
https://projecteuler.net/problem=12
Problem 12: Highly Divisible Triangular Number
What is the value of the first triangle number to have over five hundred divisors?
=#

using Primes

function triangleNumber(n::Int)
    return sum(1:n)
end

function nFactors(n::Int)
    sum((-1)^(k + 1) * (nFactors(n - (3k^2 - k)/2) + nFactors(n - (3k^2 + k)/2)) for k in 1:Inf)
end

n = 1
while length(divisors(triangleNumber(n))) <= 500
    global n += 1
end

println(n)