"""
Project Euler Problem 1: Multiples of 3 or 5
Add all multiples of 3 or 5 that are under 1000
"""

n = 10^3
domain = range(1, n)
mult_3 = domain .% 3 .== 0
mult_5 = domain .% 5 .== 0

total = sum(domain[mult_3]) + sum(domain[mult_5])
println(total)
