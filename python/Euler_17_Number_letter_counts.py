"""
Project Euler 17

If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
"""

digits = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
teens = ['ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
tensteps = ['twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

#Global letter count
cnt = 0

#count through digits
digitcnt = 0
for k in digits:
	digitcnt += len(k)
cnt += digitcnt

#count through teens
teencnt = 0
for k in teens:
	teencnt += len(k)
cnt += teencnt

#count through twenty, etc.
tenstepcnt = 0
for k in tensteps:
	tenstepcnt += 10*len(k) + digitcnt #e.g. len(twenty) + len(twentyone) + ... == len(twenty) + (len(twenty) + len(one)) + ... == 10*len(twenty) + len(one) + len(two) + ... == 10*len(twenty) + digitcnt
cnt += tenstepcnt

#count through hundreds
huncnt = 0
for hun in digits:
	huncnt += 100*len(hun + 'hundredand') + cnt #same argument as above
cnt += huncnt

cnt += len('onethousand')

print(cnt)
