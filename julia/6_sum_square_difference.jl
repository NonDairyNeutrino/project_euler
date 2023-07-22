#=
https://projecteuler.net/problem=6
Problem 6: Sum Square Difference
Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
=#

squareofsum = sum(1:100)^2
sumofsquare = sum(map(x -> x^2, 1:100))
println(squareofsum - sumofsquare)