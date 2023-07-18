#Project Euler Problem 1

#Declare the initial list
a=[]

#Create a list of multiples of 3 or 5
for i in range(1000):
	if i%3==0 and i!=0:
		a.append(i)
	elif i%5==0 and i!=0:
		a.append(i)

#Check
#print(a)

#Total the list
print(sum(list(a)))
