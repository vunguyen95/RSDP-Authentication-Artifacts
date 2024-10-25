# Created for SageMath version 9.0                  │
# Using Python 3.8.10

load('../macros.sage')
load('stern.sage')
load('stern_shifted.sage')
load('BJMM.sage')
load('BJMM_shifted.sage')


# choice of F_p and E #
p = 127
z = 7
z_new = 14
zshift_new = 13
# additive structure of E #
Eset   = get_Eset(p,z)
Dset   = get_Dset(Eset)
zd     = len(Dset)
alphaE = get_alphaE(Eset)
alphaD = get_alphaD(Eset, Dset)

# structure after shifting
Eshift = shift_E(Eset, Eset[0])
zshift = len(Eshift)
Dshift = get_Dset(Eshift)
alphaEshift = get_alphaE(Eshift)
alphaDshift = get_alphaD(Eshift, Dshift)

print(
"#######################\n"
"# PARAMS for NIST I   #\n"
"#######################\n")

n_I = 75
k_I =  34
nsolI = N(z_new**n_I * p**(k_I-n_I))+1
print('nsolI =',nsolI )
verb = False
MmaxI = -1 # no memory restriction

C_st_I,     M_st_I,     P_st_I      = opt_stern(p, z_new, n_I, k_I, MmaxI, verb)
#C_shst_I,   M_shst_I,   P_shst_I    = opt_shifted_stern(p, zshift, n_I, k_I, MmaxI, verb)
#C_bjmm_I,   M_bjmm_I,   P_bjmm_I    = opt_bjmm(p, z, n_I, k_I, MmaxI, verbose)
#C_shbjmm_I, M_shbjmm_I, P_shbjmm_I  = opt_shifted_bjmm(p, zshift_new, n_I, k_I, MmaxI, True)
print(f'C: Stern={rts(C_st_I)}bit')
print('-----------------------------')
C_shbjmm_I, M_shbjmm_I = cost_shifted_bjmm(p, zshift_new, n_I, k_I, 26, 48, 4, 0, 0, 0, Mmax = -1, verb = True)
print(f'C: shifted BJMM={rts(C_shbjmm_I)}bit')
C_shbjmm_II, M_shbjmm_II = cost_shifted_bjmm(p, zshift_new, n_I, k_I, 26, 48, 4, 0, 4, 0, Mmax = -1, verb = True)
print(f'C: shifted BJMM={rts(C_shbjmm_II)}bit')
#print(f'C: Stern={rts(C_st_I)}bit; shifted Stern={rts(C_shst_I)}bit; BJMM={rts(C_bjmm_I)}bit; shifted BJMM={rts(C_shbjmm_I)}bit')
#print(f'C: Stern={rts(C_st_I)}bit; shifted BJMM={rts(C_shbjmm_I)}bit')

#print(f'M: Stern={rts(M_st_I)}bit; shifted Stern={rts(M_shst_I)}bit; BJMM={rts(M_bjmm_I)}bit; shifted BJMM={rts(M_shbjmm_I)}bit')

exit()

