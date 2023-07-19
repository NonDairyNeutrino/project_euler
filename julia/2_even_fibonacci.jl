#=
Project Euler Problem 2: Even Fibonacci Numbers
By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
=#

"""
    fibonacci(n::Integer)

Compute the n-th Fibonacci number

# Examples
```jldoctest
julia> fibonacci(4)
5
````

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

function main()
    n = 1
    total = 0
    while (fibn = fibonacci(n)) < 4 * 10^6
        #println(fibn)
        total += fibn % 2 == 0 ? fibn : 0
        n += 1
    end
    return total
end

main()