# Created for SageMath version 9.0                  │
# Using Python 3.8.10

load('../macros1.sage')
load('stern.sage')
load('stern_shifted.sage')
load('BJMM.sage')
load('BJMM_shifted.sage')


# choice of F_p and E #
p = 127
z = 14

Eset = [1,2,4,8,16,32,64, 126, 125, 123, 119, 111, 95, 63]
#Eset = [1,2,4,8,16,32,64]

print('Eset', Eset)
print(len(Eset))

Dset   = get_Dset(Eset,p)
zd     = len(Dset)

print('Dset', Dset)
print(len(Dset))


# additive structure of E #
alphaE_counts = get_alphaE(Eset,p)
alphaE = max(alphaE_counts)
print('alphaE counts', alphaE_counts)
print('alphaE =', max(alphaE_counts))
alphaD_counts = get_alphaD(Eset, Dset,p)
print('alphaD counts', alphaD_counts)
alphaD = max(alphaD_counts)
print('alphaD', max(alphaD_counts))

#For BJMM non shift alpha_E = 3, alpha_D = 10, z = 14, zd = 56
print('------------SHIFTED-----------------------')
# structure after shifting
Eshift = shift_E(Eset, Eset[0])
zshift = len(Eshift)
Dshift = get_Dset(Eshift,p)
zdshift = len(Dshift)
alphaEshift_counts = get_alphaE(Eshift,p)
alphaEshift = max(alphaEshift_counts)
alphaDshift_counts = get_alphaD(Eshift, Dshift,p)
alphaDshift = max(alphaDshift_counts)
print('Eshift', Eshift)
print('zshift', zshift)
print('alphaEshift_counts', alphaEshift_counts)
print('alphaEshift =', alphaEshift)

print('Dshift', Dshift)
print('zdshift = ', zdshift)
print('alphaDshift_counts', alphaDshift_counts)
print('alphaDshift =', alphaDshift)

print(
"#######################\n"
"# Testing RSDP authentication protocol parameters   #\n"
"#######################\n")

n_I = 26 * 3 # Multiple queries to ensure unique solution.
k_I =  34

nsolI = N(z**n_I * p**(k_I-n_I))+1
verb = False
MmaxI = -1 # no memory restriction
print('nsolI =',nsolI )
C_st_I,     M_st_I,     P_st_I      = opt_stern(p, z, n_I, k_I, MmaxI, verb)
C_shst_I,   M_shst_I,   P_shst_I    = opt_shifted_stern(p, zshift, n_I, k_I, MmaxI, verb)
C_bjmm_I,   M_bjmm_I,   P_bjmm_I    = opt_bjmm(p, z, n_I, k_I, MmaxI, verbose)
C_shbjmm_I, M_shbjmm_I, P_shbjmm_I  = opt_shifted_bjmm(p, zshift, n_I, k_I, MmaxI, True)

print(f'C: Stern={rts(C_st_I)}bit; shifted Stern={rts(C_shst_I)}bit; BJMM={rts(C_bjmm_I)}bit; shifted BJMM={rts(C_shbjmm_I)}bit') #
print(f'M: Stern={rts(M_st_I)}bit; shifted Stern={rts(M_shst_I)}bit; BJMM={rts(M_bjmm_I)}bit; shifted BJMM={rts(M_shbjmm_I)}bit') #