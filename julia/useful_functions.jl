#= Collection of useful functions from the problems I've completed =#

module UsefulFunctions

"""
    fibonacci(n::Integer)

Compute the n-th Fibonacci number. From problem 2.

# Examples
```jldoctest
julia> fibonacci(4)
5
```

See also: `main`
"""
function fibonacci(n::Integer)
    if n == 1
        fib = 1
    elseif n == 2
        fib = 2
    else
        fib = fibonacci(n - 2) + fibonacci(n - 1)
    end
    return fib
end

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
function factor(n::Int; parallel = false)
    try
        @assert isa(parallel, Bool)

        if parallel == false
            return [p for p in 2:div(n, 2) if n % p == 0]

        elseif parallel == true
            factorVector = Int[]
            Threads.@threads for p in 2:div(n, 2) # executes in parallel on number of threads/core equal to `Threads.nthreads()`
                if n % p == 0
                    factorVector = [factorVector; p] # append p to the end of the vector of factors
                end
            end
            return factorVector
        end
    catch
        @error "`parallel` needs to be either false (default) or true."
    end
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
function isPrime(n::Int; parallel = false)
    return isempty(factor(n, parallel = parallel))
end

end