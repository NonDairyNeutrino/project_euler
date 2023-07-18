"""
Project Euler 9

A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a^2 + b^2 = c^2

For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.

Find the product abc.
"""

found = False
for c in range(10**3 + 1):
	if found == False:
		for b in range(c):
			if found == False:
				for a in range(b):
					if found == False and a**2 + b**2 == c**2 and a + b + c == 10**3:
						print([a, b, c, a*b*c])
						found = True
						break
			else:
				break
	else:
		break
