"""
Project Euler 13

The following iterative sequence is defined for the set of positive integers:

n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.
"""

import math as m

#Input: positive interger
#Output: The next step in the collatz sequence from the input
def collatz_step(n):

	if n%2 == 0:
		val = n // 2

	else:
		val = 3*n + 1

	return val

#Input: real number
#Output: Boolean on whether or not the input is an integer
def intq(n):
	return n - int(n) == 0

#Input: positive integer
#Output: the number of iterations before the input's Collatz sequence terminates
def collatz_length(n):
	k = n
	chain_length = 1

	while k != 1:
		#Turns out including this condition takes 3 times as long to run.
		# if intq(m.log2(k)):
		# 	chain_length += m.log2(k)
		# 	k = 1
		#
		# else:
		k = collatz_step(k)
		chain_length += 1
	#print(chain_length)
	return int(chain_length)

print(collatz_length(10**6))
(lambda data: print(data.index(max(data)) + 1))([collatz_length(i) for i in range(1, 10**6 + 1)])
