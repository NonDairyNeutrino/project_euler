#Project Euler Problem 2

#Declare initial values of the fibonacci sequence
fib=[1,1]

#Get the terms of the Fibonacci sequence whose values are below 4 x 10^6
i=2
while (fib[i-1]+fib[i-2])<4000000:
    fib.append(fib[i-1]+fib[i-2])
    i=i+1

#Now we find the even elements
even_fib=[]
for i in fib:
    if i%2==0:
        even_fib.append(i)

#Now we find the sum of the even elements
print(sum(list(even_fib)))
