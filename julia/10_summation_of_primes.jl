#= 
https://projecteuler.net/problem=10
Problem 10: Summation of Primes
Find the sum of all the primes below two million.
=#

using Primes

@show sum(prevprimes(2 * 10^6))