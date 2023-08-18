#= 
https://projecteuler.net/problem=13
Problem 13: Large Sum
Work out the first ten digits of the sum of the following one-hundred 50-digit numbers [given in 13_input.txt].
=#

function sumFromFile(filePath::String)
    if isfile(filePath)
        num = BigInt(0)
        for line in eachline(filePath)
            num += parse(BigInt, line)
        end
        return num
    else
        @error "File not found"
    end
end

function getFirst10(num::Number)
    digitVector = digits(num)
    return digitVector[end-9:end]
end

function fromDigits(digitVector::Vector{Int}; base=10)
    maxPower = length(digitVector)
    return sum(digitVector[i] * base^(i - 1) for i in 1:maxPower)
end

function main()
    num = sumFromFile(raw"julia\13_input.txt")
    first10Vector = getFirst10(num)
    digis = fromDigits(first10Vector)
    println(digis)
end

main()