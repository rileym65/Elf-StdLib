# Elf-StdLib
Standard functions library for CDP1802

At this point this library contains the following:

32-bit integer library
Strings library
part of my floating point library

Currently contains the following functions:

l_add32:   lbr     add32                ; M[R7] = M[R7] + M[R8]
l_sub32:   lbr     sub32                ; M[R7] = M[R7] - M[R8]
l_mul32:   lbr     mul32                ; M[R7] = M[R7] * M[R8]
l_div32:   lbr     div32                ; M[R7] = M[R7] / M[R8]
l_inc32:   lbr     inc32                ; M[RF] = M[RF] + 1
l_dec32:   lbr     dec32                ; M[RF] = M[RF] - 1
l_cmp32:   lbr     cmp32                ; M[R7] - M[R8] ?
l_shr32:   lbr     shr32                ; M[RF] = M[RF] >> 1
l_shl32:   lbr     shl32                ; M[RF] = M[RF] << 1
l_neg32:   lbr     comp2s               ; M[RF] = -M[RF]
l_eqz32:   lbr     iszero               ; M[RF] == 0 ?
l_itoa:    lbr     itoa                 ; M[RD] = itoa(M[RF])
l_atoi:    lbr     atoi                 ; M[RD] = atoi(M[RF])
l_strcpy:  lbr     strcpy               ; M[RD] = M[RF]
l_strcat:  lbr     strcat               ; M[RD] = M[RD] + M[RF]
l_strlen:  lbr     strlen               ; RC = strlen(M[RF])
l_left:    lbr     left                 ; M[RD] = left(M[RF],RC)
l_mid:     lbr     mid                  ; M[RD] = mid(M[RF],RB,RC)
l_right:   lbr     right                ; M[RD] = right(M[RF],RC)
l_lower:   lbr     lower                ; M[RF] = lower(M[RF])
l_upper:   lbr     upper                ; M[RF] = upper(M[RF])
l_strcmp:  lbr     strcmp               ; M[RF] == M[RD] ?
l_itof:    lbr     itof                 ; M[RD] = float(M[RF])
l_fpmul:   lbr     fpmul                ; M[RF] = M[RF] * M[RD]
l_fpadd:   lbr     fpadd                ; M[RF] = M[RF] + M[RD]
l_fpsub:   lbr     fpsub                ; M[RF] = M[RF] - M[RD]
l_fpdiv:   lbr     fpdiv                ; M[RF] = M[RF] / M[RD]

