"""
Project Euler 7

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10001st prime number?
"""

#Here we are finding the remainder of a number with respect to an input

#input: Integer > 0
#output: List of divisors of input
def divs(input):
        a=[]
        #Here we test is the input is even because we only need to consider the integers before the half-way point
        if (input+1)%2==0:
            for i in range(2,int((input+1)/2)):
                #Here we test if the number i is a divisor of the input.  If so, put it in the list of divisors
                if input%i==0:
                    a.append(i)
        else:
            for i in range(2,int(input/2)+1):
                if input%i==0:
                    a.append(i)
        return(a)

#Test
# for num in [11,10,9,13195]:
#     print('The divisors of ',num,' are ',divs(num))

#Here we create a primality test

def isprime(input):
	val = divs(input)==[]

	return val

# Input: natural number n
# Output: the n-th prime
def prime(n):
	primes = [2]
	i = 3
	while len(primes) < n:
		if isprime(i):
			primes.append(i)

		i += 2
		print(i)

	return primes[-1]

print(prime(10**4 + 1))
#Result: 104743
#Answer: 104743
