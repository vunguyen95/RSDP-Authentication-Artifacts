#Misc. script

"""
Misc. script to produce parameters for RSDP solvers:
The size of the difference set D.
Linearity of E and D: get_alphaE, get_alphaD.
 
"""
import numpy as np
import math
from math import comb, log2

def get_alphaE(Eset, p):
    """
    determine additive structure of E
    """
    z = len(Eset)
    counts = [0 for _ in range(z)]
    for a in Eset:
        for b in Eset:
            x = (a+b) % p
            if x in Eset:
                counts[Eset.index(x)] += 1

    return counts
def shift_E(E, shift):
    return [e-shift for e in E if (e-shift) != 0]

def get_alphaD(Eset, Dset, p):
    """
    determine additive structure of E w.r.t. D
    """
    z = len(Eset)
    counts = [0 for _ in range(z)]
    for a in Eset:
        for b in Dset:
            x = (a+b) % p 
            if x in Eset:
                counts[Eset.index(x)] += 1

    return counts
p = 127
E = [1,2,4,8,16,32,64]
Eset = [1, 2, 4, 8, 16, 32, 64, 126, 125, 123, 119, 111, 95, 63]
E_0 = [0, 1, 2, 4, 8, 16, 32, 64, 126, 125, 123, 119, 111, 95, 63]
#E_0 = [0, 1, 2, 4, 8, 16, 32, 64]

D = []
for e1 in Eset:
	#print(e)
	for e2 in Eset:
		x = (e1-e2) % p
		if x not in D and x not in E_0:
			D.append(x)

print(D)
counts_e = get_alphaE(Eset, p)
counts_d = get_alphaD(Eset, D, p)			

print('Size of D, zd =',len(D))
print('linearity of E, alphaE :', counts_e)
print('linearity of D, alphaD :', counts_d)

#----------------------SHIFTED SET---------------------
Eshift = shift_E(Eset, Eset[0]) #One can try to shift with different values of Eset to see the maximum linearity
print('Shifted E: ', Eshift)

D = []
for e1 in Eshift:
	#print(e)
	for e2 in Eshift:
		x = (e1-e2) % p
		if x not in D and x not in Eshift and x != 0:
			D.append(x)

counts_ex = get_alphaE(Eshift, p)
counts_dx = get_alphaD(Eshift, D, p)
print('Linearity of shifted E : ',counts_ex)
print('Linearity of shifted E : ', counts_dx)
print('size of shifted D: ', len(D))


# This D is for the False negative probability, defined by D := E-E = {a-b | a,b \in E}
D = []
for e1 in Eset:
	#print(e)
	for e2 in Eshift:
		x = (e1-e2) % p
		if x not in D:
			D.append(x)
print('-------------------------------------------')
print('size of set E-E:',len(D))


#exit()
print('-----------Test MitM Attack strategies---------------------')

for e1 in Eset:
	for e2 in Eset:
		if e1 == e2: continue
		print("pair", e1,e2)
		for e in Eset:
			if (e - e1 + e2) % p in Eset:
				print('possible e = ', e)

			
