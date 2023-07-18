"""
Project Euler 10

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
"""

#Here we create a primality test

def isprime(input):
	n = 2
	while input % n != 0:
		n += 1

	return n == input

#Here we create a list of primes below an input number

def primesbelow(input):
	#primes = [2]
	foo = lambda n: n if isprime(n) else 0

	primes = pool.map(foo, [i for i in range(3, input + 1, 2)])
	primes.prepend(2)

	# for i in range(3, input + 1, 2):
	# 	if isprime(i):
	# 		primes.append(i)
	#
	# 	if (i - 1) % (10**4) == 0:
	# 		print(i)

	return primes

def foo(n):
	if isprime(n):
		val = n
	else:
		val = 0
	return val

if __name__ == '__main__':
	import multiprocessing as mp
	pool = mp.Pool(mp.cpu_count() - 1)
	primes = pool.map(foo, [i for i in range(3, 2*10**6, 2)])
	primes.insert(0,2)
	print(sum(primes))
	#print(sum(primesbelow(10**4)))
	pool.close()
