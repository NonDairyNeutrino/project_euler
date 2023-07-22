#= 
https://projecteuler.net/problem=5
Problem 5: Smallest Multiple
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

What does this code do?
This code calculates the least common multiple of the first 20 natural numbers
=#

function main()
    println("Answer: ", lcm(1:20))
end

main()