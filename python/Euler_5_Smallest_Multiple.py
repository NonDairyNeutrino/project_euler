"""
Project Euler 5

2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
"""

# Function to answer Can this number be evenly divided by 2-11?
def mod_test(n, ub):
	data = []
	for i in range(2,ub+1):
		data.append(n%i == 0)

	val = all(data)

	return val

def main(ub):
	n = ub # Start at the given number because you have to at least be a multiple of it
	while not(mod_test(n, ub)):
		n += ub # Can increase by the input itself each time because it still has to be a multiple
	return n

# print(mod_test(10, 20))

print(main(20))
#Result: 232792560
#Answer: 232792560

#print([[k, main(k)] for k in range(2, 21)])
