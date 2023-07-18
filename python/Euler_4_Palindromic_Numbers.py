#Project Euler 4

#A palindromic number reads the same both ways. The largest palindrome
#made from the product of two 2-digit numbers is 9009 = 91 × 99.

#Find the largest palindrome made from the product of two 3-digit numbers.
###############################################################################

# Define a function to find the number of digits a number has in base 10
# Input: integer
# Output: The number of digits the number has in base 10
def num_length(num):
	n = -1
	x = num - 1

	while x != num:
		n = n + 1
		x = num % 10**n

	return n

# Define a function that gets the digits from a numbers
# Input: integer
# Output: array of digits of the input number
def get_digits(num):
	digits = []
	for n in range(num_length(num)):
		x = num // 10**n % 10
		digits.append(x)
	digits = digits[::-1]

	return digits

# Defining a function to test if a number is a palindromic
# Input: integer
# Output: Whether or not the input number is palindromic
def is_palindrome(num):
	digits = get_digits(num)
	value = True
	for i in range(len(digits)):
		if digits[i] != digits[-i-1]:
			value = False
			break
		else:
			continue

	return value

#TESTS

# for i in [9009, 711, 1221]:
# 	# print(num_length(i))
# 	# print(get_digits(i))
# 	print(is_palindrome(i))

# Verification of the 9009 result
# nums = []
# for i in range(10,100):
# 	for j in range(10, 100):
# 		nums.append([i,j,i*j])
#
# data = []
# for i in nums:
# 	if is_palindrome(i[2]):
# 		data.append(i)
#
# print(max([row[2] for row in data]))

# Main Routine
nums = []
for i in range(100,1000):
	for j in range(100, 1000):
		nums.append([i,j,i*j])

data = []
for i in nums:
	if is_palindrome(i[2]):
		data.append(i)

max_pal = max([row[2] for row in data])
print(max_pal)
