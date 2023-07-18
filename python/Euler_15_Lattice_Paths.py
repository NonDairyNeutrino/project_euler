"""
Project Euler 15

Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20×20 grid?
"""

import numpy as np
import itertools as it

def step(pos, dir):
	if dir == 'r':
		pos = np.array(pos) + np.array([1,0])
	elif dir == 'd':
		pos = np.array(pos) + np.array([0,1])
	else:
		print('no')
	return pos

def perms(list):
	new_list = []
	new_list.append()

start = [0,0]
dims = [5,5]
seq = ['r' for i in range(dims[0])] + ['d' for i in range(dims[1])]
paths = list(it.permutations(seq))
paths.sort()
paths = list(k for k,_ in it.groupby(paths))

#print(seq)
#print(paths)
print(len(paths))

#print(step(start, 'r'))
