#= 
https://projecteuler.net/problem=14
Problem 14: Longest Collatz Sequence
Which starting number, under one million, produces the longest Collatz chain?
=#

function collatzLength(n::Integer, chainLength = 0)
    chainLength += 1
    if n > 1
        next = iseven(n) ? div(n, 2) : 3n+1
        return collatzLength(next, chainLength)
    else
        return chainLength
    end
end

function main()
    chainLengthVector = [collatzLength(i) for i in 1:10^8]

    # maxNum = 10^9
    # chainLengthVector = Vector{Int}(undef, maxNum)

    # Threads.@threads for i in 1:maxNum
    #     chainLengthVector[i] = collatzLength(i)
    # end

    println("Max length: $(maximum(chainLengthVector))")
    println("Index: $(argmax(chainLengthVector))")
end

main()