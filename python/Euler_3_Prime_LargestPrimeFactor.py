# THIS TAKES WAAAAAAAAAAAAAAAAAAAAAAAAAYYYYYYYYYYYYYY TO LONG

#The overall goal of this project is to find the prime divisors of an input integer

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
        return(divs(input)==[])

#Test
# for num in [11,10,9,13195]:
#     print('Is ',num,' prime?',isprime(num))

#Here we create a list of primes below an input number

def primesbelow(input):
        primes=[]
        for i in range(2,input):
            if isprime(i):
                primes.append(i)
        return(primes)

#Test
# for num in [11,10,9,13195]:
#     print('The primes below', num,' are ',primesbelow(num))

#Here we find the prime factors of a number

def primedivisors(input):
        pdivs=[]
        for i in divs(input):
            if isprime(i):
                pdivs.append(i)
        return(pdivs)

#Test
# for num in [11,10,9,13195]:
#     print('The prime divisors of', num,' are ',primedivisors(num))

print(max(primedivisors(600851475143)))

#print('Functions added: divs, isprime, primesbelow, primedivisors')
