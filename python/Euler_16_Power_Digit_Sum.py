"""
Project Euler 16

215 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 21000?
"""

num = 2**1000

#Function to get the digits of a number
#Input: integer
#Output: list of digits
def to_digits(n):
	digits = []
	shorter_n = n
	while shorter_n != 0:
		digit = shorter_n % 10
		digits.append(digit)
		shorter_n = (shorter_n - digit) // 10

	return digits[::-1]

print(sum(to_digits(num)))
