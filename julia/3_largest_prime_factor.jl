#=
https://projecteuler.net/problem=3
Project Euler Problem 3: Largest Prime Factor
What is the largest prime factor of the number 600851475143?

What does this code do?
Given a positive integer n, this code:
1. finds the proper factors of n
2. finds the proper factors of each of those factors
3. if the set of factors is empty, the factor is prime
4. gives a vector of the prime factors of n
5. find the largest element in the vector of prime factors of n
=#

"""
    factor(n::Int)

Compute the proper factors of n greater than 1

# Examples
```jldoctest
factor(2)
# output
[]

factor(2*3)
# output
[2, 3]

factor(2*3*5)
# output
[2, 3, 5, 6, 10, 15]
```
"""
function factor(n::Int)
    # factorVector = [p for p in 2:div(n, 2) if n % p == 0]
    # or the same algorithm expanded
    
    factorVector = Int[]
    Threads.@threads for p in 2:div(n, 2) # executes in parallel on number of threads/core equal to `Threads.nthreads()`
        if n % p == 0
            factorVector = [factorVector; p] # append p to the end of the vector of factors
        end
    end
    return factorVector
end

"""
    isPrime(n::Int)

Determine if n is prime

# Examples
```jldoctest
isPrime(2)
# output
true

isPrime(2*3)
# output
false

isPrime(2*3*5)
# output
false
```

See also: `factor`, `isempty`
"""
function isPrime(n::Int)
    return isempty(factor(n))
end

"""
    factorPrime(n::Int)

Calculate the prime factors of n

!!! warning Inproper prime factor
    Unlike `factor`, `factorPrime(n)` will return `[n]` if `n` is prime

# Examples
```jldoctest
factorPrime(2)
# output
[2]]

factorPrime(2*3)
# output
[2, 3]

factorPrime(2*3*5)
# output
[2, 3, 5]]
```

See also: `factor`, `isPrime`, `isempty`
"""
function factorPrime(n::Int)
    primeFactors = [p for p in factor(n) if isPrime(p)]
    if isempty(primeFactors)
        primeFactors = [n]
    end
    return primeFactors
end

"""
    factorPrimeLargest(n::Int)

Calculate the largest prime factor of n

# Examples
```jldoctest
factorPrimeLargest(2)
# output
2

factorPrimeLargest(2*3)
# output
3

factorPrimeLargest(2*3*5)
# output
5
"""
function factorPrimeLargest(n::Int)
    return maximum(factorPrime(n))
end

function main()
    sol = 600851475143
    @show factorPrimeLargest(sol)
end

main()