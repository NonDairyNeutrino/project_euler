#=
https://projecteuler.net/problem=4
Project Euler Problem 4: Largest Palindrome Product
Find the largest palindrome made from the product of two 3-digit numbers.

What does this code do?
=#

"""
    isPalindrome(n::Int)

Determines if n is a palindrome

# Examples
```jldoctest
isPalindrome(1)
# output
true

isPalindrome(11)
# output
true

isPalindrome(12)
# output
false
```

See also: `digits`, `reverse`
"""
function isPalindrome(n::Int)
    return digits(n) == reverse(digits(n))
end

"""
    findAllPalindromes(prodVec::Vector{Int})

Select all palindromic numbers from prodVec.
"""
function findAllPalindromes(prodVec::Vector{Int})
    return prodVec[findall(isPalindrome, prodVec)]
end

"""
    digitsToRange(n::Int)

Get all n-digit numbers
"""
function digitsToRange(n::Int)
    return 10^(n-1) : (10^n - 1)
end

"""
    getUserDigits()

Parse user input; should be number of digits.
"""
function getUserDigits()
    print("Enter number of digits: ")
    input = parse(Int, readline())
    return input
end

function main()
    digits = getUserDigits()
    domain = digitsToRange(digits)
    prodVec = kron(domain, domain) # create vector by effecitvely concatenating the rows of the matrix formed by u[i] * v[j]
    palVec = findAllPalindromes(prodVec)
    maxPalindrome = maximum(palVec)
    println("Max palindrome: ", maxPalindrome)
end

main()