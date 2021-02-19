; ********************************************************************
; ***** Beginning of test code, will be removed in final library *****
; ********************************************************************
include  bios.inc

#define BASE     0c000h
#define TEST

#ifdef TEST

arg1:    equ     01000h
arg2:    equ     01004h
tmp:     equ     01008h
buffer:  equ     02000h

         org     08000h
         mov     r2,01ffh
         sex     r2
         mov     r6,start
         lbr     f_initcall
start:   sep     scall             ; now call the autobaud
         dw      f_setbd

         mov     rf,fp1
         mov     rd,arg1
         sep     scall
         dw      l_atof

         mov     rf,arg1
         mov     rc,fpdot5
         mov     rd,arg2
         sep     scall
         dw      l_fpacos

         mov     rf,arg2
         mov     rd,buffer
         sep     scall
         dw      l_ftoa

         mov     rf,buffer
         sep     scall
         dw      f_msg
         lbr     stop

         mov     rf,arg1
         mov     rd,buffer
         sep     scall
         dw      l_ftoa
         mov     rf,buffer
         sep     scall
         dw      f_msg
         lbr     stop


         lbr     show


         mov     rf,ascii1
         mov     rd,tmp
         sep     scall
         dw      l_atoi
         mov     rf,tmp
         mov     rd,arg1
         sep     scall
         dw      l_itof

         mov     rf,ascii2
         mov     rd,tmp
         sep     scall
         dw      l_atoi
         mov     rf,tmp
         mov     rd,arg2
         sep     scall
         dw      l_itof

         mov     rf,arg1
         mov     rd,arg2
         sep     scall
         dw      l_fpdiv


show:    mov     rf,arg1+2
         lda     rf
         plo     rd
         lda     rf
         phi     rd
         mov     rf,buffer
         sep     scall
         dw      f_hexout4
         ldi     0
         str     rf

         mov     rf,arg1
         lda     rf
         plo     rd
         lda     rf
         phi     rd
         mov     rf,buffer+4
         sep     scall
         dw      f_hexout4

         mov     rf,buffer
         sep     scall
         dw      f_msg

stop:    lbr     stop

int1:    db      165,1,1,0

n1:      equ     01000h
n2:      equ     01004h
ascii1:  db      '5',0
ascii2:  db      '-17',0
string1: db      'abide',0
string2: db      'abade',0
fp1:     db      '-0.8',0

; *************************************************************************
; *****                         End of test code                      *****
; *************************************************************************

#endif
           org     BASE
           db      'SL',0,0,1
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
l_atof:    lbr     atof                 ; M[RD] = atof(M[RF])
l_ftoa:    lbr     ftoa                 ; M[RD] = ftoa(M[RF])
l_ftoi:    lbr     ftoi                 ; M[RD] = ftoi(M[RF])
l_fpsin:   lbr     fpsin                ; M[RD] = sin(M[RF])
l_fpcos:   lbr     fpcos                ; M[RD] = cos(M[RF])
l_fptan:   lbr     fptan                ; M[RD] = tan(M[RF])
l_fplog:   lbr     fplog                ; M[RD] = ln(M[RF])
l_fpexp:   lbr     fpexp                ; M[RD] = exp(M[RF])
l_fppow:   lbr     fppow                ; M[RD] = M[RF]**M[RC]
l_fpsqrt:  lbr     fpsqrt               ; M[RD] = sqrt(M[RF])
l_fpatan:  lbr     fpatan               ; M[RD] = atan(M[RF])
l_fpasin:  lbr     fpasin               ; M[RD] = asin(M[RF])
l_fpacos:  lbr     fpacos               ; M[RD] = acos(M[RF])

           org     BASE+0c0h
fpdot1:    db      0cdh, 0cch, 0cch, 03dh
fp_0:      db      00,00,00,00
fp_1:      db      00,00,080h,03fh
fp_2:      db      00,00,000h,040h
fp_10:     db      00,00,020h,041h
fp_100:    db      00,00,0c8h,042h
fp_1000:   db      00,00,07ah,044h
fp_e:      db      054h, 0f8h, 02dh, 040h
fp_pi:     db      0dbh, 00fh, 049h, 040h
fp_3:      db      00,00,040h,040h
fpdot5:    db      000h, 000h, 000h, 03fh
fp_halfpi: db      0dbh, 00fh, 0c9h, 03fh

; ************************************************
; ***** 32-bit Add.    M[R7]=M[R7]+M[R8]     *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
add32:   sex      r8                ; point x to second number
         ldn      r7                ; get lsb
         add                        ; add second lsb of second number
         str      r7                ; store it
         inc      r7                ; point to 2nd byte
         inc      r8
         ldn      r7                ; get second byte
         adc                        ; add second byte of second number
         str      r7                ; store it
         inc      r7                ; point to 3rd byte
         inc      r8
         ldn      r7                ; get third byte
         adc                        ; add third byte of second number
         str      r7                ; store it
         inc      r7                ; point to msb
         inc      r8
         ldn      r7                ; get msb byte
         adc                        ; add msb byte of second number
         str      r7                ; store it
         sex      r2                ; restore stack
         dec      r7                ; restore registers to original values
         dec      r7
         dec      r7
         dec      r8
         dec      r8
         dec      r8
         sep      sret              ; return to caller
        
    

; ************************************************
; ***** 32-bit subtract.  M[R7]=M[R7]-M[R8]  *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
sub32:   sex      r8                ; point x to second number
         ldn      r7                ; get lsb
         sm                         ; subtract second lsb of second number
         str      r7                ; store it
         inc      r7                ; point to 2nd byte
         inc      r8
         ldn      r7                ; get second byte
         smb                        ; subtract second byte of second number
         str      r7                ; store it
         inc      r7                ; point to 3rd byte
         inc      r8
         ldn      r7                ; get third byte
         smb                        ; subtract third byte of second number
         str      r7                ; store it
         inc      r7                ; point to msb
         inc      r8
         ldn      r7                ; get msb byte
         smb                        ; subtract msb byte of second number
         str      r7                ; store it
         sex      r2                ; restore stack
         dec      r7                ; restore registers to original values
         dec      r7
         dec      r7
         dec      r8
         dec      r8
         dec      r8
         sep      sret              ; return to caller
        

    
; ************************************************
; ***** 32-bit Inc.  M[RF]=M[RF]+1           *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
inc32:   ldn      rf                ; get lsb
         adi      1                 ; add 1
         str      rf                ; store it
         inc      rf                ; point to next byte
         ldn      rf                ; get second byte
         adci     0                 ; propagate carry
         str      rf                ; store it
         inc      rf                ; point to 3rd byte
         ldn      rf                ; retreive it
         adci     0                 ; propagate carry
         str      rf                ; store it
         inc      rf                ; point to msb
         ldn      rf                ; get it
         adci     0                 ; propagate carry
         str      rf                ; store msb
         dec      rf                ; restore rf
         dec      rf
         dec      rf
         sep      sret              ; and return


    
; ************************************************
; ***** 32-bit Dec.  M[RF]=M[RF]-1           *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
dec32:   ldn      rf                ; get lsb
         smi      1                 ; subtract 1
         str      rf                ; store it
         inc      rf                ; point to next byte
         ldn      rf                ; get second byte
         smbi     0                 ; propagate borrow
         str      rf                ; store it
         inc      rf                ; point to 3rd byte
         ldn      rf                ; retreive it
         smbi     0                 ; propagate borrow
         str      rf                ; store it
         inc      rf                ; point to msb
         ldn      rf                ; get it
         smbi     0                 ; propagate borrow
         str      rf                ; store msb
         dec      rf                ; restore rf
         dec      rf
         dec      rf
         sep      sret              ; and return


; ************************************************
; ***** 32-bit cmp.  M[R7]-M[R8]             *****
; ***** Numbers in memory stored LSB first   *****
; ***** Returns: D=0 if M[R7]=M[R8]          *****
; *****          DF=1 if M[R7]<M[R8]         *****
; ************************************************
cmp32:   lda      r8                ; get lsb from second number
         str      r2                ; store for subtract
         lda      r7                ; get lsb from first number
         sm                         ; subtract
         plo      re                ; save as zero test
         lda      r8                ; get 2nd byte of second number
         str      r2                ; store for subtract
         lda      r7                ; get 2nd byte of first number
         smb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         glo      re                ; get zero test
         or                         ; or last result
         plo      re                ; and put back
         lda      r8                ; get 3rd byte of second number
         str      r2                ; store for subtract
         lda      r7                ; get 3rd byte of first number
         smb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         glo      re                ; get zero test
         or                         ; or last result
         plo      re                ; and put back
         ldn      r8                ; get msb of second number
         str      r2                ; store for subtract
         ldn      r7                ; get msb of first number
         smb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         shl                        ; shift sign bit into df
         glo      re                ; get zero test
         or                         ; or last result
         dec      r7                ; restore registers
         dec      r7
         dec      r7
         dec      r8
         dec      r8
         dec      r8
         sep      sret              ; return to caller

; ************************************************
; ***** 32-bit cmp.  M[R8]-M[R7]             *****
; ***** Numbers in memory stored LSB first   *****
; ***** Returns: D=0 if M[R7]=M[R8]          *****
; *****          DF=1 if M[R8]<M[R7]         *****
; ************************************************
icmp32:  lda      r8                ; get lsb from second number
         str      r2                ; store for subtract
         lda      r7                ; get lsb from first number
         sd                         ; subtract
         plo      re                ; save as zero test
         lda      r8                ; get 2nd byte of second number
         str      r2                ; store for subtract
         lda      r7                ; get 2nd byte of first number
         sdb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         glo      re                ; get zero test
         or                         ; or last result
         plo      re                ; and put back
         lda      r8                ; get 3rd byte of second number
         str      r2                ; store for subtract
         lda      r7                ; get 3rd byte of first number
         sdb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         glo      re                ; get zero test
         or                         ; or last result
         plo      re                ; and put back
         ldn      r8                ; get msb of second number
         str      r2                ; store for subtract
         ldn      r7                ; get msb of first number
         sdb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         shl                        ; shift sign bit into df
         glo      re                ; get zero test
         or                         ; or last result
         dec      r7                ; restore registers
         dec      r7
         dec      r7
         dec      r8
         dec      r8
         dec      r8
         sep      sret              ; return to caller


; ***************************************
; ***** is zero check               *****
; ***** returnss: DF=1 if M[RF]=0   *****
; ***************************************
iszero:  push     rf                ; save position
         lda      rf                ; get lsb
         lbnz     notzero           ; jump if not zero
         lda      rf                ; get second number
         lbnz     notzero           ; jumpt if not zero
         lda      rf                ; get third number
         lbnz     notzero           ; jump if not zero
         ldn      rf                ; get msb
         lbnz     notzero           ; jump if not zero
         ldi      1                 ; number was zero
         shr                        ; shift into df
         sep      sret              ; and return
notzero: ldi      0                 ; number was not zero
         shr                        ; shift into df
         pop      rf                ; recover position
         sep      sret              ; and return

        
; ***************************************
; ***** M[RF] = 0                   *****
; ***************************************
null32:  ldi      0                 ; need to zero
         str      rf                ; store to lsb
         inc      rf                ; point to second byte
         str      rf                ; store to second byte
         inc      rf                ; point to third byte
         str      rf                ; store to third byte
         inc      rf                ; point to msb
         str      rf                ; store to msb
         dec      rf                ; restore rf
         dec      rf
         dec      rf
         sep      sret              ; return to caller
    
; *************************************************
; ***** Check if M[RF] is negative            *****
; ***** Returns: DF=1 if number is negative   *****
; *************************************************
isneg:   inc      rf                ; point to msb
         inc      rf
         inc      rf
         ldn      rf                ; retrieve msb
         shl                        ; shift sign bit into df
         dec      rf                ; restore rf
         dec      rf
         dec      rf
         sep      sret              ; and return


; *********************************************
; ***** 2s compliment the number in M[RF] *****
; *********************************************
comp2s:  ldn      rf                ; get lsb
         xri      0ffh              ; invert it
         adi      1                 ; +1
         str      rf
         inc      rf                ; point to 2nd byte
         ldn      rf                ; retrieve it
         xri      0ffh              ; invert it
         adci     0                 ; propagate carry
         str      rf                ; and put back
         inc      rf                ; point to 3rd byte
         ldn      rf                ; retrieve it
         xri      0ffh              ; invert it
         adci     0                 ; propagate carry
         str      rf                ; and put back
         inc      rf                ; point to msb
         ldn      rf                ; retrieve it
         xri      0ffh              ; invert it
         adci     0                 ; propagate carry
         str      rf                ; and put back
         dec      rf                ; restore rf
         dec      rf
         dec      rf
         sep      sret              ; return


; ************************************************
; ***** 32-bit shift left.  M[RF]=M[RF]<<1   *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
shl32:   ldn      rf                ; get lsb
         shl                        ; shift it
         str      rf                ; put it back
         inc      rf                ; point to second byte
         ldn      rf                ; get it
         shlc                       ; shift it
         str      rf
         inc      rf                ; point to third byte
         ldn      rf                ; get it
         shlc                       ; shift it
         str      rf
         inc      rf                ; point to msb
         ldn      rf                ; get it
         shlc                       ; shift it
         str      rf
         dec      rf                ; restore rf
         dec      rf
         dec      rf
         sep      sret              ; and return

    

; ************************************************
; ***** 32-bit shift right. M[RF]=M[RF]>>1   *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
shr32:   inc      rf                ; point to msb
         inc      rf
         inc      rf
         ldn      rf                ; get msb
         shr                        ; shift it right
         str      rf                ; put it back
         dec      rf                ; point to third byte
         ldn      rf                ; get third byte
         shrc                       ; shift it
         str      rf                ; put it back
         dec      rf                ; point to second byte
         ldn      rf                ; get second byte
         shrc                       ; shift it
         str      rf                ; put it back
         dec      rf                ; point to lsb
         ldn      rf                ; get lsb
         shrc                       ; shift it
         str      rf                ; put it back
         sep      sret              ; return to caller


; ************************************************
; ***** 32-bit multiply. M[R7]=M[R7]*M[R8]   *****
; ***** Numbers in memory stored LSB first   *****
; ***** In routine:                          *****
; *****    R7 - points to answer             *****
; *****    R9 - points to first number       *****
; *****    R8 - points to second number      *****
; ************************************************
mul32:   push     r7                ; save consumed registers
         push     r8
         push     r9
         push     rf
         ldi      0                 ; need to zero answer
         stxd
         stxd
         stxd
         stxd
         mov      r9,r7             ; rf will point to first number
         mov      r7,r2             ; r7 will point to where the answer is
         inc      r7                ; point to LSB of answer
scmul2:  mov      rf,r8             ; need second number
         sep      scall             ; check for zero
         dw       iszero
         lbnf     scmul4            ; jump if number was not zero
         inc      r2                ; now pointing at lsb of answer
         lda      r2                ; get number from stack
         str      r9                ; store into destination
         inc      r9                ; point to 2nd byte
         lda      r2                ; get number from stack
         str      r9                ; store into destination
         inc      r9                ; point to 3rd byte
         lda      r2                ; get number from stack
         str      r9                ; store into destination
         inc      r9                ; point to msb
         ldn      r2                ; get number from stack
         str      r9                ; store into destination
         pop      rf                ; recover consumed registers
         pop      r9
         pop      r8
         pop      r7
         sep      sret              ; return to caller
scmul4:  ldn      r8                ; get lsb of second number
         shr                        ; shift low bit into df
         lbnf     scmulno           ; no add needed
         push     r7                ; save position of first number
         push     r8                ; save position of second number
         mov      r8,r9             ; r8 needs to be first number
         sep      scall             ; call add routine
         dw       add32
         pop      r8                ; recover positions
         pop      r7
scmulno: mov      rf,r9             ; point to first number
         sep      scall             ; shift left
         dw       shl32
         mov      rf,r8             ; now need pointer to second number
         sep      scall             ; shift right
         dw       shr32
         lbr      scmul2            ; loop until done


; ************************************************
; ***** 32-bit division. M[R7]=M[R7]/M[R8]   *****
; ***** D = number of bytes in integer       *****
; ***** Numbers in memory stored LSB first   *****
; ***** In routine:                          *****
; *****    R7=a                              *****
; *****    R8=b                              *****
; *****    RA=result                         *****
; *****    RB=shift                          *****
; ************************************************
div32:   push     r7                ; save consumed registers
         push     r8
         push     ra
         push     rb
         push     rf
         ldi      0                 ; set sign flag as positive
         str      r2                ; place on the stack
         inc      r7                ; point to msb of first number
         inc      r7
         inc      r7
         ldn      r7                ; retrieve it
         dec      r7                ; restore position
         dec      r7
         dec      r7
         ani      080h              ; is number negative
         lbz      div32_1           ; jump if not
         ldi      1                 ; set sign flag
         xor
         stxd                       ; save flag
         mov      rf,r7             ; 2s compliment number
         sep      scall
         dw       comp2s
         irx                        ; point back to sign flag
div32_1: inc      r8                ; point to msb of second number
         inc      r8
         inc      r8
         ldn      r8                ; retrieve it
         dec      r8                ; restore position
         dec      r8
         dec      r8
         ani      080h              ; is number negative
         lbz      div32_2           ; jump if not
         ldi      1                 ; adjust sign flag
         xor
         stxd                       ; save sign flag
         mov      rf,r8             ; 2s compliment second number
         sep      scall
         dw       comp2s
         irx
div32_2: dec      r2                ; preserve sign flag
         dec      r2                ; reserve bytes on stack for result
         dec      r2
         dec      r2
         mov      ra,r2             ; set RA here
         dec      r2
         mov      rf,ra             ; point to result
         sep      scall             ; set answer to 0
         dw       null32            ; set to zero
         ldi      1                 ; set shift to 1
         plo      rb
scdiv1:  sep      scall             ; compare a to b
         dw       icmp32
         lbnf     scdiv4            ; jump if b>=a
         mov      rf,r8             ; need to shift b
         sep      scall 
         dw       shl32
         inc      rb                ; increment shift
         lbr      scdiv1            ; loop until b>=a
scdiv4:  mov      rf,r7             ; point to a
         sep      scall             ; is a zero
         dw       iszero
         lbdf     scdivd1           ; jump if it was zero
         mov      rf,r8             ; point to b
         sep      scall             ; is b zero
         dw       iszero
         lbdf     scdivd1           ; jump if so
         mov      rf,ra             ; point to result
         sep      scall             ; need to shift result left
         dw       shl32
         sep      scall             ; compare a to b
         dw       cmp32
         lbdf     scdiv6            ; jump if a < b
         ldn      ra                ; get LSB of result
         ori      1                 ; set low bit
         str      ra                ; and but it back
         sep      scall             ; subtract a from b
         dw       sub32
scdiv6:  ldn      r8                ; get lsb of b
         shr                        ; see if low bit is set
         lbnf     scdiv5            ; jump if not
         dec      rb                ; mark final shift
         lbr      scdivd1           ; and then done
scdiv5:  mov      rf,r8             ; point to b
         sep      scall             ; need to shift b right
         dw       shr32
         dec      rb                ; decrement shift
         lbr      scdiv4            ; loop back until done
scdivd1: glo      rb                ; get shift
         shl                        ; shift sign into df
         lbdf     scdivd2           ; jump if so
scdivd3: glo      rb                ; get shift
         lbz      scdivdn           ; jump if zero
         mov      rf,ra             ; point to result
         sep      scall             ; shift it left
         dw       shl32
         dec      rb                ; decrement shift
         lbr      scdivd3           ; loop back
scdivd2: glo      rb                ; get shift
         lbz      scdivdn           ; jump if zero
         mov      rf,ra             ; point to result
         sep      scall             ; shift it right
         dw       shr32
         inc      rb                ; increment shift
         lbr      scdivd2
scdivdn: push     r7                ; save answer position
         ldi      4                 ; 4 bytes to transfer
         plo      r9
scdivd5: lda      ra                ; get result byte
         str      r7                ; store into answer
         inc      r7
         dec      r9                ; decrement count
         glo      r9                ; see if done
         lbnz     scdivd5           ; jump if not
         pop      r7                ; recover answer
         glo      ra                ; need to clean up the stack
         plo      r2
         ghi      ra
         phi      r2
         ldn      r2                ; retrieve sign
         shr                        ; shift into df
         lbnf     scdivrt           ; jump if signs were the same
         mov      rf,r7             ; otherwise negate number
         sep      scall
         dw       comp2s
scdivrt: pop      rf                ; recover consumed registers
         pop      rb
         pop      ra
         pop      r8
         pop      r7
         sep      sret              ; return to caller

; *****************************************
; ***** Convert R7:R8 to bcd in M[RF] *****
; *****************************************
tobcd:     push    rf           ; save address
           ldi     10           ; 10 bytes to clear
           plo     re
tobcdlp1:  ldi     0
           str     rf           ; store into answer
           inc     rf
           dec     re           ; decrement count
           glo     re           ; get count
           lbnz    tobcdlp1     ; loop until done
           pop     rf           ; recover address
           ldi     32           ; 32 bits to process
           plo     r9
tobcdlp2:  ldi     10           ; need to process 5 cells
           plo     re           ; put into count
           push    rf           ; save address
tobcdlp3:  ldn     rf           ; get byte
           smi     5            ; need to see if 5 or greater
           lbnf    tobcdlp3a    ; jump if not
           adi     8            ; add 3 to original number
           str     rf           ; and put it back
tobcdlp3a: inc     rf           ; point to next cell
           dec     re           ; decrement cell count
           glo     re           ; retrieve count
           lbnz    tobcdlp3     ; loop back if not done
           glo     r8           ; start by shifting number to convert
           shl
           plo     r8
           ghi     r8
           shlc
           phi     r8
           glo     r7
           shlc
           plo     r7
           ghi     r7
           shlc
           phi     r7
           shlc                 ; now shift result to bit 3
           shl
           shl
           shl
           str     rf
           pop     rf           ; recover address
           push    rf           ; save address again
           ldi     10           ; 10 cells to process
           plo     re
tobcdlp4:  lda     rf           ; get current cell
           str     r2           ; save it
           ldn     rf           ; get next cell
           shr                  ; shift bit 3 into df
           shr
           shr
           shr
           ldn     r2           ; recover value for current cell
           shlc                 ; shift with new bit
           ani     0fh          ; keep only bottom 4 bits
           dec     rf           ; point back
           str     rf           ; store value
           inc     rf           ; and move to next cell
           dec     re           ; decrement count
           glo     re           ; see if done
           lbnz    tobcdlp4     ; jump if not
           pop     rf           ; recover address
           dec     r9           ; decrement bit count
           glo     r9           ; see if done
           lbnz    tobcdlp2     ; loop until done
           sep     sret         ; return to caller

; ***************************************************
; ***** Convert 32-bit binary to ASCII          *****
; ***** RF - Pointer to 32-bit integer          *****
; ***** RD - destination buffer                 *****
; ***************************************************
itoa:      push    rf           ; save consumed registers
           push    r9
           push    r8
           push    r7
           lda     rf           ; retrieve number into R7:R8
           plo     r8
           lda     rf
           phi     r8
           lda     rf
           plo     r7
           lda     rf
           phi     r7
           glo     r2           ; make room on stack for buffer
           smi     11
           plo     r2
           ghi     r2
           smbi    0
           phi     r2
           mov     rf,r2        ; RF is output buffer
           inc     rf
           ghi     r7           ; get high byte
           shl                  ; shift bit to DF
           lbdf    itoan        ; negative number
itoa1:     sep     scall        ; convert to bcd
           dw      tobcd
           mov     rf,r2
           inc     rf
           ldi     10
           plo     r8
           ldi     9            ; max 9 leading zeros
           phi     r8
loop1:     lda     rf
           lbz     itoaz        ; check leading zeros
           str     r2           ; save for a moment
           ldi     0            ; signal no more leading zeros
           phi     r8
           ldn     r2           ; recover character
itoa2:     adi     030h
           str     rd           ; store into output buffer
           inc     rd
itoa3:     dec     r8
           glo     r8
           lbnz    loop1
           glo     r2           ; pop work buffer off stack
           adi     11
           plo     r2
           ghi     r2
           adci    0
           phi     r2
           ldi     0            ; place terminator in destination
           str     rd
           pop     r7
           pop     r8           ; recover consumed registers
           pop     r9
           pop     rf
           sep     sret         ; return to caller
itoaz:     ghi     r8           ; see if leading have been used up
           lbz     itoa2        ; jump if so
           smi     1            ; decrement count
           phi     r8
           lbr     itoa3        ; and loop for next character
itoan:     ldi     '-'          ; show negative
           str     rd           ; write to destination buffer
           inc     rd
           glo     r8           ; 2s compliment
           xri     0ffh
           adi     1
           plo     r8
           ghi     r8
           xri     0ffh
           adci    0
           phi     r8
           glo     r7
           xri     0ffh
           adci    0
           plo     r7
           ghi     r7
           xri     0ffh
           adci    0
           phi     r7
           lbr     itoa1        ; now convert/show number

; ****************************************************
; ***** Convert ascii to int32                   *****
; ***** RF - buffer to ascii                     *****
; ***** RD - destinatin int32                    *****
; ***** Returns R7:R8 result                     *****
; *****         RF - First non-numeric character *****
; ****************************************************
atoi:      push    ra           ; save consumed registers
           push    rb
           ldi     0            ; zero result
           phi     r7
           plo     r7
           phi     r8
           plo     r8
           stxd                 ; store sign on stack
           ldn     rf           ; get byte from input
           smi     '-'          ; check for negative number
           lbnz    atoi_lp      ; jump if not a negative number
           ldi     1            ; replace sign
           irx
           stxd
           inc     rf           ; move past sign
atoi_lp:   ldn     rf           ; get byte from input
           smi     '0'          ; see if below digits
           lbnf    atoi_dn      ; jump if not valid digit
           smi     10           ; check for high of range
           lbdf    atoi_dn      ; jump if not valid digit
           glo     r8           ; multiply answer by 2
           shl
           plo     r8
           plo     rb           ; put a copy in RA:RB as well
           ghi     r8
           shlc
           phi     r8
           phi     rb
           glo     r7
           shlc
           plo     r7
           plo     ra
           ghi     r7
           shlc
           phi     r7
           phi     ra
           ldi     2            ; want to shift RA:RB twice
           plo     re
atoi_1:    glo     rb           ; now shift RA:RB
           shl
           plo     rb
           ghi     rb
           shlc
           phi     rb
           glo     ra
           shlc
           plo     ra
           ghi     ra
           shlc
           phi     ra
           dec     re           ; decrement shift count
           glo     re           ; see if done
           lbnz    atoi_1       ; shift again if not
           glo     rb           ; now add RA:RB to R7:R8
           str     r2
           glo     r8
           add
           plo     r8
           ghi     rb
           str     r2
           ghi     r8
           adc
           phi     r8
           glo     ra
           str     r2
           glo     r7
           adc
           plo     r7
           ghi     ra
           str     r2
           ghi     ra
           str     r2
           ghi     r7
           adc
           phi     r7
           lda     rf           ; get byte from input
           smi     '0'          ; conver to binary
           str     r2           ; and add it to R7:R8
           glo     r8
           add
           plo     r8
           ghi     r8
           adci    0
           phi     r8
           glo     r7
           adci    0
           plo     r7
           ghi     r7
           adci    0
           phi     r7
           lbr     atoi_lp      ; loop back for more characters
atoi_dn:   irx                  ; recover sign
           ldx
           shr                  ; shift into DF
           lbnf    atoi_dn2     ; jump if not negative
           glo     r8           ; negate the number
           xri     0ffh
           adi     1
           plo     r8
           ghi     r8
           xri     0ffh
           adci    0
           phi     r8
           glo     r7
           xri     0ffh
           adci    0
           plo     r7
           ghi     r7
           xri     0ffh
           adci    0
           phi     r7
atoi_dn2:  glo     r8           ; store result into destination
           str     rd
           inc     rd
           ghi     r8
           str     rd
           inc     rd
           glo     r7
           str     rd
           inc     rd
           ghi     r7
           str     rd
           dec     rd           ; restore RD
           dec     rd
           dec     rd
           pop     rb           ; recover consumed registers
           pop     ra
           sep     sret         ; and return to caller

; **************************
; ***** String library *****
; **************************

; ***********************************
; ***** Copy string             *****
; ***** RD - destination string *****
; ***** RF - source string      *****
; ***********************************
strcpy:    push    rd           ; save consumed registers
           push    rf
strcpy_1:  lda     rf           ; get byte from source string
           str     rd           ; store into destination
           inc     rd
           lbnz    strcpy_1     ; loop back until terminator copied
           pop     rf           ; recover consumed registers
           pop     rd
           sep     sret         ; return to caller
           
; ***********************************
; ***** Concatenate string      *****
; ***** RD - destination string *****
; ***** RF - source string      *****
; ***********************************
strcat:    push    rd           ; save consumed registers
           push    rf
strcat_1:  lda     rd           ; look for terminator
           lbnz    strcat_1     ; loop back until terminator found
           dec     rd           ; move back to terminator
           lbr     strcpy_1     ; and then copy source string to end

; **********************************
; ***** String length          *****
; ***** RF - pointer to string *****
; ***** Returns: RC - length   *****
; **********************************
strlen:    push    rf           ; save consumed register
           ldi     0            ; set count to zero
           plo     rc
           phi     rc
strlen_1:  lda     rf           ; get byte from string
           lbz     strlen_2     ; jump if terminator found
           inc     rc           ; otherwise increment count
           lbr     strlen_1     ; and keep looking
strlen_2:  pop     rf           ; recover consumed register
           sep     sret         ; return to caller

; *****************************************
; ***** Left portion of string        *****
; ***** RF - pointer to source string *****
; ***** RD - pointer to destination   *****
; ***** RC - Count of characters      *****
; *****************************************
left:      push    rf           ; save consumed registers
           push    rd
           push    rc
left_1:    glo     rc           ; see if characters left
           str     r2
           ghi     rc
           or
           lbz     left_dn      ; jump if not
           dec     rc           ; decrement count
           lda     rf           ; get byte from source
           str     rd           ; write into destination
           inc     rd
           lbnz    left_1       ; jump if terminator not found
left_rt:   pop     rc           ; recover consumed registers
           pop     rd
           pop     rf
           sep     sret         ; otherwise return to caller
left_dn:   ldi     0            ; write terminator to destination
           str     rd
           lbr     left_rt      ; then return

; *****************************************
; ***** Middle portion of string      *****
; ***** RF - pointer to source string *****
; ***** RD - pointer to destination   *****
; ***** RB - Starting point           *****
; ***** RC - Count of characters      *****
; *****************************************
mid:       push    rb           ; save consumed register
mid_1:     glo     rb           ; see if starting position found
           str     r2
           ghi     rc
           or
           lbz     mid_2        ; use left to copy characters
           dec     rb           ; decrement count
           lda     rf           ; get byte from source string
           lbz     mid_dn       ; jump if terminator found, will be empty destination
           lbr     mid_1        ; keep looping until start point 
mid_dn:    ldi     0            ; write terminator to destination
           str     rd
           pop     rb           ; recover consumed register
           sep     sret         ; and return
mid_2:     sep     scall        ; call left to copy characters
           dw      left
           pop     rb           ; pop consumed register
           sep     sret         ; and return to caller

; *****************************************
; ***** Right portion of string       *****
; ***** RF - pointer to source string *****
; ***** RD - pointer to destination   *****
; ***** RC - Count of characters      *****
; *****************************************
right:     push    rc           ; save consumed register
           ldi     0            ; zero counter
           plo     rb
           phi     rb
right_1:   lda     rf           ; get byte from source
           lbz     right_2      ; jump if terminator found
           inc     rb           ; increment length
           lbr     right_1      ; keep looking for terminator
right_2:   dec     rf           ; point back to previous character
           glo     rb           ; check RB counter
           str     r2
           ghi     rb
           or
           lbz     right_dn     ; start found, so now just copy
           glo     rc           ; check rc counter
           str     r2
           ghi     rc
           or
           lbz     right_dn     ; start found, so now just copy
           dec     rb           ; decrement counters
           dec     rc
           lbr     right_2      ; keep looking for start point
right_dn:  sep     scall        ; call strcpy to copy the string
           dw      strcpy
           pop     rc           ; recover consumed register
           sep     sret         ; and return

; ***************************************
; ***** Convert string to lowercase *****
; ***** RF - Pointer to string      *****
; ***************************************
lower:     push    rf           ; save consumed register
lower_1:   ldn     rf           ; get byte from buffer
           lbz     return       ; jump if terminator found
           smi     'A'          ; Check for lower range
           lbnf    lowernxt     ; jump if below range
           smi     26           ; check for above range
           lbdf    lowernxt     ; jump if above range
           ldn     rf           ; get character
           adi     32           ; convert to lowercvase
           str     rf           ; and put it back
lowernxt:  inc     rf           ; point to next character
           lbr     lower_1      ; process rest of string
return:    pop     rf           ; recover consumed register
           sep     sret         ; return to caller

; ***************************************
; ***** Convert string to uppercase *****
; ***** RF - Pointer to string      *****
; ***************************************
upper:     push    rf           ; save consumed register
upper_1:   ldn     rf           ; get byte from buffer
           lbz     return       ; jump if terminator found
           smi     'a'          ; Check for lower range
           lbnf    uppernxt     ; jump if below range
           smi     26           ; check for above range
           lbdf    uppernxt     ; jump if above range
           ldn     rf           ; get character
           smi     32           ; convert to lowercvase
           str     rf           ; and put it back
uppernxt:  inc     rf           ; point to next character
           lbr     upper_1      ; process rest of string

; *********************************************
; ***** String compare                    *****
; ***** RF - string1                      *****
; ***** RD - string2                      *****
; ***** Returns: DF=0 - strings unequal   *****
; *****          DF=1 - strings equal     *****
; *****          D=1  - string1 > string2 *****
; *****          D=0  - string1 < string2 *****
; *********************************************
strcmp:    push    rd           ; save consumed registers
           push    rf
strcmp_2:  lda     rf           ; get byte from string1
           str     r2
           lbnz    strcmp_1     ; jump if terminator not found
           lda     rd           ; get byte from second string
           lbz     strcmp_eq    ; jump if strings are equal
           lbr     strcmp_lt    ; jump if string1 is smaller
strcmp_1:  lda     rd           ; get byte from second string
           lbz     strcmp_gt    ; jump if string2 is lower
           sd                   ; subtract from first string
           lbz     strcmp_2     ; loop to check remaining bytes
           lbdf    strcmp_gt    ; jump if 
strcmp_lt: ldi     0            ; signal string 1 is lower
           lbr     strcmp_rt
strcmp_eq: ldi     1            ; signal strings equal
           lbr     strcmp_rt
strcmp_gt: ldi     2            ; signal string 2 is lower
strcmp_rt: shr
           plo     re           ; preserve result
           pop     rf           ; recover consumed registers
           pop     rd
           glo     re           ; recover result
           sep     sret


; **********************************
; ***** Floating point library *****
; **********************************


; ******************************************
; ***** 2's compliment number in r7:r8 *****
; ******************************************
fpcomp2:   glo     r8           ; perform 2s compliment on input
           xri     0ffh
           adi     1
           plo     r8
           ghi     r8
           xri     0ffh
           adci    0
           phi     r8
           glo     r7
           xri     0ffh
           adci    0
           plo     r7
           ghi     r7
           xri     0ffh
           adci    0
           phi     r7
           sep     sret

; ****************************************************
; ***** Convert 32-bit integer to floating point *****
; ***** RF - Pointer to 32-bit integer           *****
; ***** RD - Destination floating point          *****
; ****************************************************
itof:      lda     rf           ; retrieve 32-bit integer into r7:r8
           plo     r8
           str     r2           ; store for zero check
           lda     rf
           phi     r8
           or                   ; combine with zero check
           str     r2           ; keep zero check on stack
           lda     rf
           plo     r7
           or
           str     r2
           lda     rf           ; MSB
           phi     r7
           or
           lbz     itof0        ; jump if input number is zero
           ldi     0            ; set sign flag
           str     r2
           ghi     r7           ; see if number is negative
           shl                  ; shift sign bit into DF
           lbnf    itof_p       ; jump if number is positive
           ldi     1            ; set sign flag
           stxd
           sep     scall        ; 2s compliment input number
           dw      fpcomp2
           irx                  ; point x back to sign flag
itof_p:    ldi     150          ; exponent starts at 150
           plo     re
itof_1:    ghi     r7           ; see if need right shifts
           lbz     itof_2       ; jump if not
           shr                  ; otherwise shift number right
           phi     r7
           glo     r7
           shrc
           plo     r7
           ghi     r8
           shrc
           phi     r8
           glo     r8
           shrc
           plo     r8
           inc     re           ; increment exponent
           lbr     itof_1       ; and loop to see if more shifts needed
itof_2:    glo     r7           ; see if we need left shifts
           ani     080h
           lbnz    itof_3       ; jump if no shifts needed
           glo     r8           ; shift number left
           shl
           plo     r8
           ghi     r8
           shlc
           phi     r8
           glo     r7
           shlc
           plo     r7
           ghi     r7
           shlc
           phi     r7
           dec     re           ; decrement exponent
           lbr     itof_2       ; and loop to see if more shifts needed
itof_3:    glo     r7           ; prepare to merge in exponent
           shl
           plo     r7
           glo     re           ; get exponent
           phi     r7           ; store into result
           shr                  ; shift it right 1 bit
           glo     r7
           shrc                 ; shift final exponent bit in
           plo     r7
           ldx                  ; recover sign flag
           shr                  ; shift it into DF
           ghi     r7           ; get msb of result
           shrc                 ; shift in sign bit
           phi     r7           ; and put it back
itof0:     glo     r8           ; store answer into destination
           str     rd
           inc     rd
           ghi     r8
           str     rd
           inc     rd
           glo     r7
           str     rd
           inc     rd
           ghi     r7
           str     rd
           sep     sret         ; and return

; *******************************************
; ***** Normalize and combine FP result *****
; ***** R7:R8 - Mantissa                *****
; ***** R9.0  - Exponent                *****
; ***** R9.1  - Sign                    *****
; ***** Returns: R7:R8 - FP number      *****
; *******************************************
fpnorm:    glo     r9           ; Get exponent
           lbz     fpnorm0      ; jump if zero
           glo     r8           ; zero check mantissa
           lbnz    fpnormnz     ; jump if not
           ghi     r8
           lbnz    fpnormnz
           glo     r7
           lbnz    fpnormnz
           ghi     r7
           lbnz    fpnormnz
fpnorm0:   ldi     0            ; set result to 0
           plo     r8
           phi     r8
           plo     r7
           phi     r7
           sep     sret         ; and return
fpnormi:   ldi     03fh         ; set infinity
           phi     r7
           ldi     080h
           plo     r7
           ldi     0
           phi     r8
           plo     r8
           sep     sret         ; and return
fpnormnz:  ghi     r7           ; check for need to right shift
           lbz     fpnorm_1     ; jump if no right shifts needed
           shr                  ; shift mantissa right
           phi     r7
           glo     r7
           shrc
           plo     r7
           ghi     r8
           shrc
           phi     r8
           glo     r8
           shrc
           plo     r8
           inc     r9           ; increment exponent
           glo     r9           ; get exponent
           smi     0ffh         ; check for exponent overflow
           lbz     fpnormi      ; jump if exponent overflow, returns 0
           lbr     fpnormnz     ; keep checking for bits too high in mantissa
fpnorm_1:  glo     r7           ; check for need to shift left
           shl                  ; shift high bit into DF
           lbdf    fpnorm_2     ; jump if high bit is set
           glo     r8           ; shift mantissa left
           shl
           plo     r8
           ghi     r8
           shlc
           phi     r8
           glo     r7
           shlc 
           plo     r7
           dec     r9           ; decrement exponent
           glo     r9           ; check for exponent underflow
           lbz     fpnorm0      ; jump if underflow occured
           lbr     fpnorm_1     ; loop until high bit set
fpnorm_2:  glo     r7           ; prepare mantissa for merging exponent
           shl
           plo     r7
           ghi     r9           ; get sign
           shr                  ; shift into DF
           glo     r9           ; get exponent
           shrc                 ; shift in sign
           phi     r7           ; place into answer
           glo     r7           ; get high byte of mantissa
           shrc                 ; shift in least bit from exponent
           plo     r7           ; and put back
           sep     sret         ; return to caller

; *********************************
; ***** Retrieve fp arguments *****
; ***** M[RF] -> R7:R8 R9.0   *****
; ***** M[RD] -> RA:RB R9.1   *****
; *********************************
fpargs:    lda     rf           ; retrieve first number
           plo     r8
           lda     rf
           phi     r8
           lda     rf
           plo     r7
           shl                  ; shift low bit of exponent
           lda     rf
           phi     r7
           shlc                 ; get full exponent
           plo     r9           ; save exponent 1
           lda     rd           ; retrieve second number
           plo     rb
           lda     rd
           phi     rb
           lda     rd
           plo     ra
           shl                  ; shift low bit of exponent
           lda     rd
           phi     ra
           shlc                 ; get full exponent
           phi     r9           ; save exponent 2
           sep     sret         ; return to caller

fpret_0:   pop     rf           ; recover destination address
           ldi     0            ; write 0
           str     rf
           inc     rf
           str     rf
           inc     rf
           str     rf
           inc     rf
           str     rf
           sep     sret         ; and return

fpret_a:   pop     rf           ; recover destination address
           glo     r8           ; store a as answer
           str     rf
           inc     rf
           ghi     r8
           str     rf
           inc     rf
           glo     r7
           str     rf
           inc     rf
           ghi     r7
           str     rf
           sep     sret         ; and return to caller

fpret_b:   pop     rf           ; recover destination address
           glo     rb           ; store a as answer
           str     rf
           inc     rf
           ghi     rb
           str     rf
           inc     rf
           glo     ra
           str     rf
           inc     rf
           ghi     ra
           str     rf
           sep     sret         ; and return to caller

; ********************************************
; ***** Floating point addition          *****
; ***** RF - pointer to first fp number  *****
; ***** RD - pointer to second fp number *****
; ***** Uses: R7:R8 - first number (aa)  *****
; *****       RA:RB - second number (bb) *****
; *****       R9.0  - exponent           *****
; *****       R9.1  - sign               *****
; ********************************************
fpadd:     push    rf           ; save destination address
           sep     scall        ; retrieve arguments
           dw      fpargs
fpsub_1:   lbz     fpret_a      ; return a if b==0
           smi     0ffh         ; check for infinity
           lbz     fpret_b      ; return b if b==infinity
           glo     r9           ; get exponent 1
           lbz     fpret_b      ; return b if a==0
           smi     0ffh         ; check for infinity
           lbz     fpret_a      ; return a if a==infinity
           glo     r9           ; get exponent 1
           str     r2           ; store for comparison
           ghi     r9           ; get exponent 2
           sm                   ; compare to exponent 1
           lbnf    fpadd_1      ; jump if b<a
           glo     r8           ; swap a and b
           plo     re
           glo     rb
           plo     r8
           glo     re
           plo     rb
           ghi     r8           ; swap a and b
           plo     re
           ghi     rb
           phi     r8
           glo     re
           phi     rb
           glo     r7           ; swap a and b
           plo     re
           glo     ra
           plo     r7
           glo     re
           plo     ra
           ghi     r7           ; swap a and b
           plo     re
           ghi     ra
           phi     r7
           glo     re
           phi     ra
           glo     r9           ; also swap exponents
           plo     re
           ghi     r9
           plo     r9
           glo     re
           phi     r9
fpadd_1:   ghi     r7           ; compare signs
           str     r2
           ghi     ra
           xor
           plo     rc           ; store operation, 0=+, 1=-
           ghi     r7           ; get sign of largest number
           phi     rc           ; save it for now
           ldi     0            ; clear high bytes of numbers
           phi     ra
           phi     r7
           glo     ra           ; set implied 1 bit
           ori     080h
           plo     ra
           glo     r7           ; in first number too
           ori     080h
           plo     r7
fpadd_2:   glo     r9           ; compare exponents
           str     r2
           ghi     r9
           sm
           lbz     fpadd_3;     ; jump if exponents match
           ghi     r9           ; increment exponent 2
           adi     1
           phi     r9
           ghi     ra           ; shift b right
           shr
           phi     ra
           glo     ra
           shrc
           plo     ra
           ghi     rb
           shrc
           phi     rb
           glo     rb
           shrc
           plo     rb
           lbr     fpadd_2      ; loop until exponents match
fpadd_3:   glo     rc           ; get operation
           shl                  ; shift into DF
           lbdf    fpadd_s      ; jump if subtraction
           glo     r8           ; a += b
           str     r2
           glo     rb
           add
           plo     r8
           ghi     r8
           str     r2
           ghi     rb
           adc
           phi     r8
           glo     r7
           str     r2
           glo     ra
           adc
           plo     r7
           ghi     r7
           str     r2
           ghi     ra
           adc
           phi     r7
           lbr     fpadd_4      ; jump to completion
fpadd_s:   glo     r8           ; a -= b
           str     r2
           glo     rb
           sd
           plo     r8
           ghi     r8
           str     r2
           ghi     rb
           sdb
           phi     r8
           glo     r7
           str     r2
           glo     ra
           sdb
           plo     r7
           ghi     r7
           str     r2
           ghi     ra
           sdb
           phi     r7
           shl                  ; need to check sign of answer
           lbnf    fpadd_4      ; jump if positive
           sep     scall        ; 2s compliment number
           dw      fpcomp2
           ghi     rc           ; compliment sign
           xri     080h
           phi     rc           ; put it back
fpadd_4:   ghi     rc           ; move sign to R9.1
           shl
           ldi     0
           shlc
           phi     r9
           ghi     r7           ; check for zero
           lbnz    fpadd_5
           glo     r7
           lbnz    fpadd_5
           ghi     r8
           lbnz    fpadd_5
           glo     r8
           lbnz    fpadd_5
           lbr     fpret_0      ; otherwise answer is 0
fpadd_5:   sep     scall        ; normalize the answer
           dw      fpnorm
           lbr     fpret_a      ; write answer and return


; ********************************************
; ***** Floating point subtraction       *****
; ***** RF - pointer to first fp number  *****
; ***** RD - pointer to second fp number *****
; ***** Uses: R7:R8 - first number (aa)  *****
; *****       RA:RB - second number (bb) *****
; *****       R9.0  - exponent           *****
; *****       R9.1  - sign               *****
; ********************************************
fpsub:     push    rf           ; save destination address
           sep     scall        ; retrieve arguments
           dw      fpargs
           ghi     ra           ; invert number
           xri     080h
           phi     ra           ; save inverted sign
           ghi     r9
           lbr     fpsub_1      ; now process with add


; ********************************************
; ***** Floating point multiplication    *****
; ***** RF - pointer to first fp number  *****
; ***** RD - pointer to second fp number *****
; ***** Uses: R7:R8 - answer       (cc)  *****
; *****       RA:RB - second number (bb) *****
; *****       R9.0  - exponent           *****
; *****       R9.1  - sign               *****
; *****       RC:RD - first number (aa)  *****
; ********************************************
fpmul:    push     rf           ; save destination addres
          lda      rd           ; retrieve second number
          plo      rb           ; place into bb
          lda      rd
          phi      rb
          lda      rd
          plo      ra
          shl                   ; shift high bit into DF
          lda      rd
          phi      ra
          shlc                  ; now have full 8 bits of exponent
          phi      r9           ; store into r9
          lbz      fpret_0      ; jump if number is zero
          lda      rf           ; retrieve first number
          plo      rd           ; place into aa
          lda      rf
          phi      rd
          lda      rf
          plo      rc
          shl                   ; shift high bit into DF
          lda      rf
          phi      rc
          shlc                  ; now have exponent of first number
          plo      r9           ; save it
          lbz      fpret_0      ; jump if number was zero
          glo      r9           ; get exponent of first number
          smi      0ffh         ; check for infinity
          lbz      fpmul_a      ; jump if so
          ghi      r9           ; get exponent of second number
          smi      0ffh         ; check for infinity
          lbz      fpmul_b      ; jump if so
          glo      r9           ; get exponent 1
          smi      127          ; remove bias
          str      r2           ; store for add
          ghi      r9           ; get exponent 2
          smi      127          ; remove bias
          add                   ; add in exponent 1
          adi      127          ; add bias back in
          plo      r9           ; r9 now has exponent of result
          ghi      ra           ; get msb of bb
          str      r2           ; store it
          ghi      rc           ; get msb of aa
          xor                   ; now have sign comparison
          shl                   ; shift sign into DF
          ldi      0            ; clear byte
          shlc                  ; shift in sign
          phi      r9           ; save sign for later
          ldi      0            ; need to clear high bytes
          phi      ra           ; of bb
          phi      rc           ; and aa
          plo      r8           ; also clear answer
          phi      r8
          plo      r7
          phi      r7
          glo      ra           ; get msb of bb mantissa
          ori      080h         ; add in implied 1
          plo      ra           ; and put it back
          glo      rc           ; get msb of aa mantissa
          ori      080h         ; add in implied 1
          plo      rc           ; and put it back
fpmul_lp: glo      ra           ; need to zero check bb
          str      r2
          ghi      ra
          or
          str      r2
          glo      rb
          or
          str      r2
          ghi      rb
          or
          lbz      fpmul_dn     ; jump of bb==0
          ghi      r7           ; cc >>= 1
          shr
          phi      r7
          glo      r7
          shrc
          plo      r7
          ghi      r8
          shrc
          phi      r8
          glo      r8
          shrc
          plo      r8
          ghi      ra           ; bb >>= 1
          shr
          phi      ra
          glo      ra
          shrc
          plo      ra
          ghi      rb
          shrc
          phi      rb
          glo      rb
          shrc
          plo      rb
          lbnf     fpmul_lp     ; back to loop if no addition needed
          glo      r8           ; cc += aa
          str      r2
          glo      rd
          add
          plo      r8
          ghi      r8
          str      r2
          ghi      rd
          adc
          phi      r8
          glo      r7
          str      r2
          glo      rc
          adc
          plo      r7
          ghi      r7
          str      r2
          ghi      rc
          adc
          phi      r7
          lbr      fpmul_lp     ; back to beginning of loop
fpmul_dn: sep      scall        ; assemble answer
          dw       fpnorm
          pop      rf           ; recover destination address
          glo      r8           ; store answer
          str      rf
          inc      rf
          ghi      r8
          str      rf
          inc      rf
          glo      r7
          str      rf
          inc      rf
          ghi      r7
          str      rf
          sep      sret         ; return to caller
fpmul_a:  pop      rf           ; recover destination address
          glo      rd           ; write a to answer
          str      rf
          inc      rf
          ghi      rd 
          str      rf
          inc      rf
          glo      rc
          str      rf
          inc      rf
          ghi      rc
          str      rf
          sep      sret         ; and return to caller
fpmul_b:  pop      rf           ; recover destination address
          glo      rb           ; write b to answer
          str      rf
          inc      rf
          ghi      rb 
          str      rf
          inc      rf
          glo      ra
          str      rf
          inc      rf
          ghi      ra
          str      rf
          sep      sret         ; and return to caller

          

; ********************************************
; ***** Floating point division          *****
; ***** RF - pointer to first fp number  *****
; ***** RD - pointer to second fp number *****
; ***** Uses: R7:R8 - answer       (a)   *****
; *****       RA:RB - second number (b)  *****
; *****       RA    - pointer to (aa)    *****
; *****       RB    - pointer to (bb)    *****
; *****       R9.0  - exponent           *****
; *****       R9.1  - sign               *****
; *****       RC:RD - mask               *****
; ********************************************
fpdiv:    push     rf           ; save destination address
          sep      scall        ; get arguments
          dw       fpargs
          glo      r9           ; check for a==0
          lbz      fpret_0      ; return 0 if so
          ghi      r9           ; check for b==0
          lbz      fpret_0      ; return 0 if so
          glo      r9           ; check for a==infinity
          smi      0ffh
          lbz      fpret_a      ; return a if so
          ghi      r9           ; check for b==infinity
          smi      0ffh
          lbz      fpret_b      ; return b if so
          ghi      r9           ; get exp2
          smi      127          ; remove bias
          str      r2           ; store for subtraction
          glo      r9           ; get exp1
          smi      127          ; remove bias
          sm                    ; subtract exp2
          adi      127          ; add bias back in
          plo      r9           ; now have final exp
          ghi      r7           ; get sign of a
          str      r2           ; store for xor
          ghi      ra           ; get sign of b
          xor                   ; now have sign comparison
          shl                   ; shift it into DF
          ldi      0            ; clear D
          shlc                  ; and shift in sign
          phi      r9           ; store sign
          glo      ra           ; put bb on stack
          ori      080h         ; set implied 1 bit
          stxd
          ghi      rb
          stxd
          glo      rb
          stxd
          ldi      0
          stxd
          stxd
          stxd
          mov      rb,r2        ; point RB to bb
          inc      rb
          glo      r7           ; put aa on stack
          ori      080h         ; set implied 1 bit
          stxd
          ghi      r8
          stxd
          glo      r8
          stxd
          ldi      0
          stxd
          stxd
          stxd
          mov      ra,r2        ; set RA to point to aa
          inc      ra
          ldi      0            ; clear a
          plo      r8
          phi      r8
          plo      r7
          phi      r7
          plo      rd           ; setup mask
          phi      rd
          phi      rc
          ldi      080h
          plo      rc
fpdiv_lp: glo      rd           ; need to check for mask==0
          lbnz     fpdiv_1      ; jump if not 0
          ghi      rd
          lbnz     fpdiv_1
          glo      rc
          lbnz     fpdiv_1
          sep      scall        ; division is done, so call normalize
          dw       fpnorm
          glo      r2           ; clear work space from stack
          adi      12
          plo      r2
          ghi      r2
          adci     0
          phi      r2
          lbr      fpret_a      ; and return the answer
fpdiv_1:  smi      0            ; set DF for first byte
          ldi      6            ; 6 bytes to subtract
          plo      re
          sex      rb           ; point x to bb
fpdiv_1a: lda      ra           ; get byte from aa
          smb                   ; subtract byte from bb from aa
          inc      rb           ; point to next byte
          dec      re           ; decrement count
          glo      re           ; see if done
          lbnz     fpdiv_1a     ; loop back if not
          ldi      6            ; need to move pointers back
          plo      re
fpdiv_1b: dec      ra
          dec      rb
          dec      re
          glo      re
          lbnz     fpdiv_1b
          lbnf     fpdiv_2      ; jump if b>a
          ldi      6            ; 6 bytes to subtract bb from aa
          plo      re
          smi      0            ; set DF for first subtract
fpdiv_1c: ldn      ra           ; get byte from a
          smb                   ; subtract bb
          str      ra           ; put it back
          inc      ra           ; increment pointers
          inc      rb
          dec      re           ; decrement byte count
          glo      re           ; see if done
          lbnz     fpdiv_1c     ; loop back if not
          ldi      6            ; need to move pointers back
          plo      re
fpdiv_1d: dec      ra
          dec      rb
          dec      re
          glo      re
          lbnz     fpdiv_1d
          sex      r2           ; point x back to stack
          glo      rc           ; add mask to answer
          str      r2
          glo      r7
          or
          plo      r7
          ghi      rd
          str      r2
          ghi      r8
          or
          phi      r8
          glo      rd
          str      r2
          glo      r8
          or
          plo      r8
fpdiv_2:  sex      r2           ; point x back to stack
          glo      rc           ; right shift mask
          shr
          plo      rc
          ghi      rd
          shrc
          phi      rd
          glo      rd
          shrc
          plo      rd
          inc      rb           ; need to start at msb of bb
          inc      rb
          inc      rb
          inc      rb
          inc      rb
          inc      rb
          ldi      6            ; 6 bytes in bb to shift right
          plo      re
          adi      0            ; clear DF for first shift
fpdiv_2a: dec      rb
          ldn      rb           ; get byte from bb
          shrc                  ; shift it right
          str      rb           ; and put it back
          dec      re           ; decrement count
          glo      re           ; see if done
          lbnz     fpdiv_2a     ; loop back if not
          lbr      fpdiv_lp     ; loop for rest of division

; ********************************************
; ***** Convert ASCII to floating point  *****
; ***** RF - Pointer to ASCII string     *****
; ***** RD - Desintation FP              *****
; ***** Uses:                            *****
; *****       R7:R8 - mantissa           *****
; *****       R9.0  - exponent           *****
; *****       R9.1  - sign               *****
; *****       RA:RB - mask               *****
; *****       RC    - fractional pointer *****
; ********************************************
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; +++++ First convert integer portion to floating point +++++
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
atof:     ldi      0            ; set sign to positive
          phi      r9
          ldn      rf           ; get first byte from buffer
          smi      '-'          ; is it minus
          lbnz     atof_1       ; jump if not
          ldi      1            ; indicate negative number
          phi      r9
          inc      rf           ; and move past minus
atof_1:   push     rd           ; save destination
          sep      scall        ; convert integer portion of number
          dw       atoi
          pop      rd           ; recover destination
          push     rd           ; save destination for later
          lda      rd           ; retrieve integer number
          plo      r8 
          str      r2           ; store for zero check
          lda      rd
          phi      r8
          or                    ; combine with zero check
          str      r2
          lda      rd
          plo      r7
          or                    ; combine with zero check
          str      r2
          lda      rd
          phi      r7
          or                    ; combine with zero check
          lbz      atof_z       ; jump if integer is zero
          ldi      150          ; initial exponent starts at 150
          plo      r9
          ldi      1            ; initial mask is 1
          plo      rb
          ldi      0
          phi      rb
          plo      ra
          phi      ra
          ghi      r7           ; check if high byte has anything
          lbz      atof_b       ; jump if not
atof_a1:  ghi      r7           ; get high byte
          lbz      atof_a2      ; jump if done shifting
          shr                   ; shift mantissa right
          phi      r7
          glo      r7
          shrc
          plo      r7
          ghi      r8
          shrc
          phi      r8
          glo      r8
          shrc
          plo      r8
          glo      r9           ; get exponent
          adi      1            ; increment it
          plo      r9           ; put it back
          lbr      atof_a1      ; loop until high byte cleared
atof_a2:  ldi      0            ; clear mask
          phi      ra
          plo      ra
          phi      rb
          plo      rb
          lbr      atof_2       ; and then jump to next section
atof_b:   glo      r7           ; get first byte of mantissa
          shl                   ; shift high bit into DF
          lbdf     atof_2       ; if set, no more shifts needed
          glo      r8           ; shift mantissa left
          shl
          plo      r8
          ghi      r8
          shlc
          phi      r8
          glo      r7
          shlc
          plo      r7
          glo      rb           ; shift mask left
          shl
          plo      rb
          ghi      rb
          shlc
          phi      rb
          glo      ra
          shlc
          plo      ra
          glo      r9           ; get exponent
          smi      1            ; decrement it
          plo      r9           ; and put it back
          lbr      atof_b       ; loop until high bit of mantissa set
atof_z:   ldi      080h         ; set initial mask
          plo      ra
          ldi      0
          phi      ra
          phi      rb
          plo      rb
          ldi      127          ; initial exponent
          plo      r9
; ++++++++++++++++++++++++++++++++++++++++++++++++++
; +++++ Now convert number after decimal point +++++
; ++++++++++++++++++++++++++++++++++++++++++++++++++
atof_2:   ldn      rf           ; get next byte from input
          smi      '.'          ; is it a decimal
          lbnz     atof_e       ; jump if not
          inc      rf           ; move past decimal
          ldi      99           ; need marker on stack
          stxd
atof_2a:  lda      rf           ; get next byte from input
          plo      re           ; keep a copy
          smi      '0'          ; see if below digits
          lbnf     atof_2b      ; jump if not valid digit
          smi      10           ; check for high of range
          lbdf     atof_2b      ; jump if not valid digit
          glo      re           ; recover number
          smi      '0'          ; convert to binary
          stxd                  ; and store on stack
          lbr      atof_2a      ; loop until all numerals copied
atof_2b:  dec      rf           ; move pointer back to non-numeral character
; ------------------------------------
; ----- Main loop for fractional -----
; ------------------------------------
atof_2c:  glo      rb           ; check mask for zero
          lbnz     atof_2d
          ghi      rb
          lbnz     atof_2d
          glo      ra
          lbnz     atof_2d
          lbr      atof_2z      ; done with fractional
atof_2d:  glo      r7           ; check mantissa for zero
          lbnz     atof_2e
          ghi      r8 
          lbnz     atof_2e
          glo      r8 
          lbnz     atof_2e
          glo      r9           ; zero result
          smi      1            ; so subtract 1 from exponent
          plo      r9           ; put it back
          lbr      atof_2f
atof_2e:  glo      ra           ; if result nonzero, shift mask right
          shr
          plo      ra
          ghi      rb
          shrc
          phi      rb
          glo      rb
          shrc
          plo      rb
atof_2f:  ldi      0            ; set carry to 0
          plo      re
          mov      rc,r2        ; point to fractional data
          inc      rc
atof_2g:  ldn      rc           ; get next byte from fractional
          smi      99           ; check for end
          lbz      atof_2j      ; jump if end found
          glo      re           ; get carry
          shr                   ; shift into DF
          ldn      rc           ; get next fractional digit
          shlc                  ; add to itself plus carry
          str      rc           ; put it back
          smi      10           ; see if exceeded 10
          lbnf     atof_2h      ; jump if not
          str      rc           ; store corrected number
          ldi      1            ; set carry
atof_2i:  plo      re
          inc      rc           ; point to next character
          lbr      atof_2g      ; and loop back for more
atof_2h:  ldi      0            ; clear carry
          lbr      atof_2i
atof_2j:  glo      re           ; get carry
          shr                   ; shift into DF
          lbnf     atof_2c      ; loop until mask==0
          glo      rb           ; check mask for zero
          lbnz     atof_2k      ; jump if not zero
          ghi      rb
          lbnz     atof_2k      ; jump if not zero
          glo      ra
          lbnz     atof_2k      ; jump if not zero
          glo      r8           ; mask==0, add 1
          adi      1
          plo      r8
          ghi      r8
          adci     0
          phi      r8
          glo      r7
          adci     0
          plo      r7
          lbr      atof_2z      ; done with fractional
atof_2k   glo      rb           ; combine mask with result
          str      r2
          glo      r8
          or
          plo      r8
          ghi      rb
          str      r2
          ghi      r8
          or
          phi      r8
          glo      ra
          str      r2
          glo      r7
          or
          plo      r7
          lbr      atof_2c      ; loop until mask == 0
atof_2z:  irx                   ; clean temp data from stack
atof_2z2: ldxa                  ; get next byte
          smi      99           ; look for end marker
          lbnz     atof_2z2     ; loop until marker found
          dec      r2           ; move stack pointer back

atof_e:   sep      scall        ; normalize number
          dw       fpnorm
          ldn      rf           ; get next character
          smi      'E'          ; check for exponent
          lbz      atof_ex      ; jump if so
          smi      32           ; check lowercase e as well
          lbz      atof_ex      ; jump if exponent
atof_dn:  pop      rd           ; recover destination
          glo      r8           ; store answer in destination
          str      rd
          inc      rd
          ghi      r8
          str      rd
          inc      rd
          glo      r7
          str      rd
          inc      rd
          ghi      r7
          str      rd
          dec      rd           ; restore destination pointer
          dec      rd
          dec      rd
          sep      sret         ; return to caller
; ++++++++++++++++++++++++++++
; +++++ Process exponent +++++
; ++++++++++++++++++++++++++++
atof_ex:  ldi      0            ; signal positive exponent
          phi      r9           ; put it here
          inc      rf           ; move past E
          ldn      rf           ; need to check for sign
          smi      '+'          ; check for positive
          lbz      atof_exp     ; jump if so
          smi      2            ; check for negative
          lbnz     atof_ex1     ; jump if not
          ldi      1            ; signal negative number
          phi      r9
atof_exp: inc      rf           ; move past sign
atof_ex1: ldi      0            ; set exponent count to zero
          plo      rc
atof_ex2: ldn      rf           ; get byte from input
          smi      '0'          ; see if below digits
          lbnf     atof_ex3     ; jump if not valid digit
          smi      10           ; check for high of range
          lbdf     atof_ex3     ; jump if not valid digit
          glo      rc           ; get count
          shl                   ; multiply by 2
          str      r2           ; save for add
          shl                   ; multiply by 4
          shl                   ; by 8
          add                   ; by 10
          str      r2           ; store for add
          lda      rf           ; get input byte
          smi      '0'          ; convert to binary
          add                   ; add in prior total
          plo      rc           ; put it back
          lbr      atof_ex2     ; loop until no more digits
atof_ex3: ghi      r7           ; put result on stack
          stxd
          glo      r7
          stxd
          ghi      r8
          stxd
          glo      r8
          stxd
          ghi      r9           ; check sign of exponent
          shr
          lbdf     atof_exn     ; jump if negative
atof_ex4: glo      rc           ; see if done
          lbz      atof_exd     ; jump if done
          mov      rf,r2        ; point to result
          inc      rf
          mov      rd,fp_10     ; point to 10.0
          glo      rc           ; save count
          stxd
          sep      scall        ; multiply result by 10.0
          dw       fpmul
          irx                   ; recover count
          ldx        
          plo      rc           ; put back into count
          dec      rc           ; decrement count
          lbr      atof_ex4     ; loop until done
atof_exn: glo      rc           ; see if done
          lbz      atof_exd     ; jump if done
          mov      rf,r2        ; point to result
          inc      rf
          mov      rd,fp_10     ; point to 10.0
          glo      rc           ; save count
          stxd
          sep      scall        ; divide result by 10.0
          dw       fpdiv
          irx                   ; recover count
          ldx        
          plo      rc           ; put back into count
          dec      rc           ; decrement count
          lbr      atof_exn     ; loop until done
atof_exd: irx                   ; recover answer
          ldxa
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldx
          phi      r7
          lbr      atof_dn      ; and return result

; *************************************************
; ***** Convert floating point to ASCII       *****
; ***** RF - pointer to floating point number *****
; ***** RD - destination buffer               *****
; ***** Uses:                                 *****
; *****       R9.0  - exponent                *****
; *****       R9.1  - E                       *****
; *****       R7:R8 - number                  *****
; *****       RA:RB - fractional              *****
; *****       RC.0  - digit count             *****
; *************************************************
ftoa:     lda      rf           ; retrieve number into R7:R8
          plo      r8
          lda      rf
          phi      r8
          lda      rf
          plo      r7
          lda      rf
          phi      r7
          shl                   ; shift sign into DF
          lbnf     ftoa_1       ; jump if number is positive
          ldi      '-'          ; place minus sign into output
          str      rd
          inc      rd
ftoa_1:   glo      r7           ; get low bit of exponent
          shl                   ; shift into DF
          ghi      r7           ; get high 7 bits of exponent
          shlc                  ; shift in the low bit
          plo      r9           ; store it
          lbnz     ftoa_2       ; jump if exponent is not zero
          ldi      '0'          ; write 0 digit to output
          str      rd
          inc      rd
ftoa_t:   ldi      0            ; terminate output
          str      rf
          sep      sret         ; and return to caller
ftoa_2:   smi      0ffh         ; check for infinity
          lbnz     ftoa_3       ; jump if not
          ldi      'i'          ; write inf to output
          str      rd
          inc      rd
          ldi      'n'
          str      rd
          inc      rd
          ldi      'f'
          str      rd
          inc      rd
          lbr      ftoa_t       ; terminate string and return
ftoa_3:   push     rd           ; save destination pointer
          ldi      0            ; clear E
          phi      r9
          glo      r9           ; check exponent for greater than 150
          smi      151
          lbnf     ftoa_4       ; jump if <= 150
          ghi      r7           ; put number on the stack
          stxd
          glo      r7
          stxd
          ghi      r8
          stxd
          glo      r8
          stxd
ftoa_3a:  glo      r9           ; get exponent
          smi      131          ; looking for below 131
          lbnf     ftoa_3z      ; jump if done scaling
          mov      rf,r2        ; point to number
          inc      rf
          ghi      r9           ; get E
          stxd                  ; and save on stack
          mov      rd,fp_10     ; need to divide by 10
          sep      scall        ; perform the division
          dw       fpdiv
          irx                   ; recover E
          ldx
          adi      1            ; increment E
          phi      r9           ; and put it back
          glo      r2           ; point to new exponent
          adi      3
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          lda      rf           ; get low bit
          shl                   ; shift into DF
          ldn      rf           ; get high 7 bites
          shlc                  ; shift in the low bit
          plo      r9           ; and store it
          lbr      ftoa_3a      ; loop until exponent in correct range
ftoa_3z:  irx                   ; retrieve the number from the stack
          ldxa
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldx
          phi      r7
ftoa_4:   glo      r9           ; check exponent for less than 114
          smi      114
          lbdf     ftoa_5       ; jump if > 114
          ghi      r7           ; put number on the stack
          stxd
          glo      r7
          stxd
          ghi      r8
          stxd
          glo      r8
          stxd
ftoa_4a:  glo      r9           ; get exponent
          smi      127          ; looking for below 127
          lbdf     ftoa_4z      ; jump if done scaling
          mov      rf,r2        ; point to number
          inc      rf
          ghi      r9           ; get E
          stxd                  ; and save on stack
          mov      rd,fp_10     ; need to divide by 10
          sep      scall        ; perform the division
          dw       fpmul
          irx                   ; recover E
          ldx
          smi      1            ; decrement E
          phi      r9           ; and put it back
          glo      r2           ; point to new exponent
          adi      3
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          lda      rf           ; get low bit
          shl                   ; shift into DF
          ldn      rf           ; get high 7 bites
          shlc                  ; shift in the low bit
          plo      r9           ; and store it
          lbr      ftoa_4a      ; loop until exponent in correct range
ftoa_4z:  irx                   ; retrieve the number from the stack
          ldxa
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldx
          phi      r7
ftoa_5:   ldi      0            ; clear high byte of number
          phi      r7
          glo      r7           ; set implied 1
          ori      080h
          plo      r7           ; and put it back
          ldi      0            ; clear fractional
          phi      ra
          plo      ra
          phi      rb
          plo      rb
ftoa_6:   glo      r9           ; get exponent
          smi      150          ; check for less than 150
          lbdf     ftoa_7       ; jump if not
          glo      ra           ; shift fractional right
          shr
          plo      ra
          ghi      rb
          shrc
          phi      rb
          glo      rb
          shrc
          plo      rb
          glo      r8           ; get low bit of number
          shr                   ; shift it into DF
          lbnf     ftoa_6a      ; jump if bit was clear
          glo      ra           ; otherwise set high bit in fractional
          ori      080h
          plo      ra           ; put it back
ftoa_6a:  glo      r7           ; shift number right
          shr
          plo      r7
          ghi      r8
          shrc
          phi      r8
          glo      r8
          shrc
          plo      r8
          glo      r9           ; get exponent
          adi      1            ; increase it
          plo      r9           ; put it back
          lbr      ftoa_6       ; loop back until exponent >= 150
ftoa_7:   glo      r9           ; get exponent
          smi      151          ; check for greater than 150
          lbnf     ftoa_8       ; jump if not
          glo      r8           ; shift number left
          shl
          plo      r8
          ghi      r8
          shlc
          phi      r8
          glo      r7
          shlc
          plo      r7
          ghi      r7
          shlc
          phi      r7
          glo      r9           ; get exponent
          adi      1            ; increment it
          plo      r9           ; and put it back
          lbr      ftoa_7       ; loop until exponent in range
ftoa_8:   pop      rd           ; recover destination
          ghi      r7           ; place integer portion on stack
          stxd
          glo      r7
          stxd
          ghi      r8
          stxd
          glo      r8
          stxd
          mov      rf,r2        ; point source to integer number
          inc      rf
          push     ra           ; save registers consumed by itoa
          push     rb
          push     r9
          sep      scall        ; call ito a to convert integer portion of result
          dw       itoa
          pop      r9           ; recover consumed registers
          pop      rb
          pop      ra
          irx                   ; remove number from stack
          irx
          irx
          glo      ra           ; check for nonzero fractional
          lbnz     ftoa_9       ; jump if not zero
          ghi      rb
          lbnz     ftoa_9
          glo      rb
          lbnz     ftoa_9
          lbr      ftoa_e       ; no fractional digits, jump to E processing
ftoa_9:   dec      rd           ; get 2 characters back
          dec      rd
          lda      rd           ; get it
          smi      '1'          ; see if it was 1
          lbnz     ftoa_9c      ; jump if not
          ldn      rd           ; get 2nd number
          plo      re           ; save it
          ldi      '.'          ; replace it with a dot
          str      rd
          inc      rd
          glo      re           ; recover number
          str      rd           ; and store into destination
          inc      rd
          ghi      r9           ; get E
          adi      1            ; increment it
          phi      r9           ; and put it back
          lbr      ftoa_9d      ; then continue
ftoa_9c:  inc      rd           ; put RD back to original position
          ldi      '.'          ; need decimal point
          str      rd           ; store into destination
          inc      rd
ftoa_9d:  ldi      6            ; set digit count
          plo      rc
ftoa_9a:  glo      ra           ; check if fractional is still non-zero
          lbnz     ftoa_9b      ; jump if not
          ghi      rb
          lbnz     ftoa_9b
          glo      rb
          lbz      ftoa_e       ; on to E processing if no more fractional bits
ftoa_9b:  glo      rb           ; multiply fractional by 2
          shl
          plo      rb
          plo      r8           ; put copy in R7:R8 as well
          ghi      rb
          shlc
          phi      rb
          phi      r8
          glo      ra
          shlc
          plo      ra
          plo      r7
          ghi      ra
          shlc
          phi      ra
          phi      r7
          glo      r8           ; now multiply R7:R8 by 2
          shl
          plo      r8
          ghi      r8
          shlc
          phi      r8
          glo      r7
          shlc
          plo      r7
          ghi      r7
          shlc
          phi      r7
          glo      r8           ; now multiply R7:R8 by 4
          shl
          plo      r8
          ghi      r8
          shlc
          phi      r8
          glo      r7
          shlc
          plo      r7
          ghi      r7
          shlc
          phi      r7
          glo      rb           ; now add R7:R8 to RA:RB
          str      r2
          glo      r8
          add
          plo      rb
          ghi      rb
          str      r2
          ghi      r8
          adc
          phi      rb
          glo      ra
          str      r2
          glo      r7
          adc
          plo      ra
          ghi      ra
          str      r2
          ghi      r7
          adc
          phi      ra           ; D now has decimal byte
          adi      '0'          ; convert to ASCII
          str      rd           ; and write to destination
          inc      rd
          ldi      0            ; clear high byte of fractional
          phi      ra
          dec      rc           ; increment counter
          glo      rc           ; need to see if done
          lbnz     ftoa_9a      ; loop until done
ftoa_e:   ghi      r9           ; need to check for E
          lbz      ftoa_dn      ; jump if no E needed
          ldi      'E'          ; write E to output
          str      rd
          inc      rd
          ghi      r9           ; see if E was negative
          shl
          lbnf     ftoa_ep      ; jump if not
          ldi      '-'          ; write minus sign to output
          str      rd
          inc      rd
          ghi      r9           ; then 2s compliment E
          xri      0ffh
          adi      1
          phi      r9           ; and put it back
          lbr      ftoa_e1      ; then continue
ftoa_ep:  ldi      '+'          ; write plus to output
          str      rd
          inc      rd
ftoa_e1:  ldi      0            ; place E as 32-bits onto stack
          stxd
          stxd
          stxd
          ghi      r9
          stxd
          mov      rf,r2        ; point rf to number
          inc      rf
          sep      scall        ; call itoa to display E
          dw       itoa
          irx                   ; remove number from stack
          irx
          irx
          irx
ftoa_dn:  ldi      0            ; terminate string
          str      rd
          sep      sret         ; and return to caller

; *************************************************
; ***** Convert floating point to integer     *****
; ***** RF - pointer to floating point number *****
; ***** RD - destination integer              *****
; ***** Returns: DF=1 - overflow              *****
; ***** Uses:                                 *****
; *****       R9.0  - exponent                *****
; *****       R9.1  - sign                    *****
; *****       R7:R8 - number                  *****
; *****       RA:RB - fractional              *****
; *****       RC.0  - digit count             *****
; *************************************************
ftoi:     lda      rf           ; retrieve number into R7:R8
          plo      r8
          lda      rf
          phi      r8
          lda      rf
          plo      r7
          lda      rf
          phi      r7
          shl                   ; shift sign into DF
          ldi      0            ; clear D
          shlc                  ; shift sign into D
          phi      r9           ; and store it
ftoi_1:   glo      r7           ; get low bit of exponent
          shl                   ; shift into DF
          ghi      r7           ; get high 7 bits of exponent
          shlc                  ; shift in the low bit
          plo      r9           ; store it
          lbnz     ftoi_2       ; jump if exponent is not zero
          ldi      0            ; result is zero
          str      rd
          inc      rd
          str      rd
          inc      rd
          str      rd
          inc      rd
          str      rd
          adi      0            ; clear DF
          shr
          sep      sret         ; return to caller
ftoi_2:   smi      0ffh         ; check for infinity
          lbnz     ftoi_5       ; jump if not
ftoi_ov:  ldi      0ffh         ; write highest integer
          str      rd
          inc      rd
          str      rd
          inc      rd
          str      rd
          inc      rd
          ldi      07fh         ; positive number
          str      rd
          smi      0            ; set DF to signal overflow
          shr
          sep      sret         ; and return

ftoi_5:   ldi      0            ; clear high byte of number
          phi      r7
          glo      r7           ; set implied 1
          ori      080h
          plo      r7           ; and put it back
          ldi      0            ; clear fractional
          phi      ra
          plo      ra
          phi      rb
          plo      rb
ftoi_6:   glo      r9           ; get exponent
          smi      150          ; check for less than 150
          lbdf     ftoi_7       ; jump if not
          glo      ra           ; shift fractional right
          shr
          plo      ra
          ghi      rb
          shrc
          phi      rb
          glo      rb
          shrc
          plo      rb
          glo      r8           ; get low bit of number
          shr                   ; shift it into DF
          lbnf     ftoi_6a      ; jump if bit was clear
          glo      ra           ; otherwise set high bit in fractional
          ori      080h
          plo      ra           ; put it back
ftoi_6a:  glo      r7           ; shift number right
          shr
          plo      r7
          ghi      r8
          shrc
          phi      r8
          glo      r8
          shrc
          plo      r8
          glo      r9           ; get exponent
          adi      1            ; increase it
          plo      r9           ; put it back
          lbr      ftoi_6       ; loop back until exponent >= 150
ftoi_7:   glo      r9           ; get exponent
          smi      151          ; check for greater than 150
          lbnf     ftoi_8       ; jump if not
          ghi      r7           ; check for overflow
          ani      080h
          lbnz     ftoi_ov      ; jump if overflow
          glo      r8           ; shift number left
          shl
          plo      r8
          ghi      r8
          shlc
          phi      r8
          glo      r7
          shlc
          plo      r7
          ghi      r7
          shlc
          phi      r7
          glo      r9           ; get exponent
          adi      1            ; increment it
          plo      r9           ; and put it back
          lbr      ftoi_7       ; loop until exponent in range
ftoi_8:   glo      r8           ; store number into destination
          str      rd
          inc      rd
          ghi      r8
          str      rd
          inc      rd
          glo      r7
          str      rd
          inc      rd
          ghi      r7
          str      rd
          dec      rd           ; move destination pointer back
          dec      rd
          dec      rd
          adi      0            ; signal no overflow
          shr
          sep      sret         ; and return to caller


; ************************
; ***** Trig Library *****
; ************************

getargs:  lda      r6           ; get passed argument
          str      r2           ; store for add
          glo      r2           ; add stack offset
          add
          plo      rf           ; put into first argument
          ghi      r2           ; high of stack
          adci     0            ; propagate carry
          phi      rf           ; rf now has argument address
          inc      rf           ; remove last call offset
          inc      rf
          lda      r6           ; get passed argument
          str      r2           ; store for add
          glo      r2           ; add stack offset
          add
          plo      rd           ; put into second argument
          ghi      r2           ; high of stack
          adci     0            ; propagate carry
          phi      rd           ; rd now has argument address
          inc      rd           ; remove last call offset
          inc      rd
          sep      sret         ; return to caller

addtows:  irx                   ; retrieve return address
          ldxa
          phi      r7
          ldx
          plo      r7
          inc      rd           ; move to msb
          inc      rd
          inc      rd
          ldn      rd           ; retrieve
          stxd                  ; and place on stack
          dec      rd
          ldn      rd           ; retrieve next byte
          stxd                  ; and place on stack
          dec      rd
          ldn      rd           ; retrieve next byte
          stxd                  ; and place on stack
          dec      rd
          ldn      rd           ; retrieve next byte
          stxd                  ; and place on stack
          glo      r7           ; put return address back on stack
          stxd
          ghi      r7
          stxd
          sep      sret         ; return to caller

fpcopy:   lda      rd           ; copy source to destination
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          sep      sret         ; return to caller

; ******************************************************
; ***** sin                                        *****
; ***** RF - Pointer to floating point number      *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1  R7 - sum                       *****
; *****       R2+5  R8 - pwr                       *****
; *****       R2+9  R9 - last                      *****
; *****       R2+13 RA - fct                       *****
; *****       R2+17 RB - fctCount                  *****
; *****       R2+21 RC - tmp                       *****
; *****       R2+25 RD - sgn                       *****
; *****       R2+29    - angle                     *****
; ******************************************************
fpsin:    push     rd           ; save destination
          mov      rd,rf        ; angle = argument
          sep      scall        ; add to workspace
          dw       addtows
          mov      rd,fp_1      ; sgn = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          stxd                  ; make space for tmp
          stxd
          stxd
          stxd
          mov      rd,fp_2      ; fctCount = 2.0
          sep      scall        ; add to workspace
          dw       addtows
          mov      rd,fp_1      ; fct = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          stxd                  ; make space for last
          stxd
          stxd
          stxd
          mov      rd,rf        ; pwr = argument
          sep      scall        ; add to workspace
          dw       addtows
          mov      rd,rf        ; sum = argument
          sep      scall        ; add to workspace
          dw       addtows
          
sincos:   sep      scall        ; angle = angle * angle
          dw       getargs
          db       29,29
          sep      scall        ; angle = angle * angle
          dw       fpmul
sincos_l: sep      scall        ; need to see if sum == last
          dw       getargs
          db       9,1
          ldi      4            ; 4 bytes to check
          plo      rc
          ldi      0            ; clear comparison flag
          plo      re
sincos_1: ldn      rd           ; get byte from sum
          str      r2           ; save for comparison
          ldn      rf           ; get point from last
          sm                    ; compare them
          str      r2           ; store to combine with comparison flag
          glo      re           ; get comparison flag
          or                    ; combine
          plo      re           ; put back into comparison
          ldn      rd           ; get byte from sum
          str      rf           ; store into last
          inc      rd           ; increment pointers
          inc      rf
          dec      rc           ; decrement count
          glo      rc           ; see if done
          lbnz     sincos_1     ; jump if not
          glo      re           ; get comparison flag
          lbz      sincos_d     ; jump if done
          glo      r2           ; point to msb of sgn
          adi      28
          plo      r7
          ghi      r2
          adci     0
          phi      r7
          ldn      r7           ; get msb of sgn
          xri      080h         ; flip the sign
          str      r7           ; and put it back
          sep      scall        ; pwr = pwr * angle
          dw       getargs
          db       5,29
          sep      scall
          dw       fpmul
          sep      scall        ; fct = fct * fctCount
          dw       getargs
          db       13,17
          sep      scall
          dw       fpmul
          glo      r2           ; fctCount = fctCount + 1
          adi      17
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          mov      rd,fp_1
          sep      scall
          dw       fpadd
          sep      scall        ; fct = fct * fctCount
          dw       getargs
          db       13,17
          sep      scall
          dw       fpmul
          glo      r2           ; fctCount = fctCount + 1
          adi      17
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          mov      rd,fp_1
          sep      scall
          dw       fpadd
          sep      scall        ; tmp = sgn
          dw       getargs
          db       21,25
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          sep      scall        ; tmp = tmp * pwr
          dw       getargs
          db       21,5
          sep      scall
          dw       fpmul
          sep      scall        ; tmp = tmp / fct
          dw       getargs
          db       21,13
          sep      scall
          dw       fpdiv
          sep      scall        ; sum = sum + tmp
          dw       getargs
          db       1,21
          sep      scall
          dw       fpadd
          lbr      sincos_l     ; loop until done
sincos_d: irx                   ; recover answer
          ldxa
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldx
          phi      r7
          glo      r2           ; clean workspace off stack
          adi      28
          plo      r2
          ghi      r2
          adci     0
          phi      r2
          pop      rd           ; recover destination address
          glo      r8           ; store answer
          str      rd
          inc      rd
          ghi      r8
          str      rd
          inc      rd
          glo      r7
          str      rd
          inc      rd
          ghi      r7
          str      rd
          sep      sret         ; and return to caller

; ******************************************************
; ***** cos                                        *****
; ***** RF - Pointer to floating point number      *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1  R7 - sum                       *****
; *****       R2+5  R8 - pwr                       *****
; *****       R2+9  R9 - last                      *****
; *****       R2+13 RA - fct                       *****
; *****       R2+17 RB - fctCount                  *****
; *****       R2+21 RC - tmp                       *****
; *****       R2+25 RD - sgn                       *****
; *****       R2+29    - angle                     *****
; ******************************************************
fpcos:    push     rd           ; save destination
          mov      rd,rf        ; angle = argument
          sep      scall        ; add to workspace
          dw       addtows
          mov      rd,fp_1      ; sgn = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          stxd                  ; make space for tmp
          stxd
          stxd
          stxd
          mov      rd,fp_1      ; fctCount = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          mov      rd,fp_1      ; fct = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          stxd                  ; make space for last
          stxd
          stxd
          stxd
          mov      rd,fp_1      ; pwr = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          mov      rd,fp_1      ; sum = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          lbr      sincos       ; now compute

; ******************************************************
; ***** tan                                        *****
; ***** RF - Pointer to floating point number      *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1     - s                         *****
; *****       R2+5     - c                         *****
; ******************************************************
fptan:    push     rd           ; save destination
          mov      rd,rf        ; s = argument
          sep      scall
          dw       addtows
          mov      rd,rf        ; c = argument
          sep      scall
          dw       addtows
          glo      r2           ; setup for computing sin
          plo      rf
          plo      rd
          ghi      r2
          phi      rf
          phi      rd
          inc      rf
          inc      rd
          sep      scall        ; compute sin
          dw       fpsin
          glo      r2           ; setup to compute cos
          adi      5
          plo      rd
          plo      rf
          ghi      r2
          adci     0
          phi      rd
          phi      rf
          sep      scall        ; compute cos
          dw       fpcos
          sep      scall        ; get arguments for division
          dw       getargs
          db       1,5
          sep      scall        ; s = s / c
          dw       fpdiv
          irx                   ; recover answer
          ldxa
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldxa
          phi      r7
          irx                   ; move past c
          irx
          irx
          pop      rd           ; recover destination address
          glo      r8           ; store answer
          str      rd
          inc      rd
          ghi      r8
          str      rd
          inc      rd
          glo      r7
          str      rd
          inc      rd
          ghi      r7
          str      rd
          sep      sret         ; and return to caller

; ******************************************************
; ***** Natural logarithm                          *****
; ***** RF - Pointer to floating point number      *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1     - sum                       *****
; *****       R2+5     - last                      *****
; *****       R2+9     - k                         *****
; *****       R2+13    - pwr                       *****
; *****       R2+17    - tmp                       *****
; *****       R2+21    - n                         *****
; ******************************************************
fplog:    push     rd           ; save destination
          mov      rd,rf        ; n = argument
          sep      scall
          dw       addtows
          mov      rd,rf        ; tmp = argument
          sep      scall
          dw       addtows
          stxd                  ; reserve space for pwr
          stxd
          stxd
          stxd
          mov      rd,fp_1      ; k = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          mov      rd,fp_1      ; last = 1.0
          sep      scall        ; add to workspace
          dw       addtows
          ldi      0            ; sum = 0
          stxd
          stxd
          stxd
          stxd
          glo      r2           ; point to tmp
          adi      17
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          mov      rd,fp_1      ; point to 1.0
          sep      scall        ; compute n+1
          dw       fpadd
          glo      r2           ; point to n
          adi      21
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          mov      rd,fp_1      ; point to 1.0
          sep      scall        ; compute n-1
          dw       fpsub
          sep      scall        ; compute (n-1)/(n+1)
          dw       getargs
          db       21,17
          sep      scall
          dw       fpdiv
          sep      scall        ; pwr = n
          dw       getargs
          db       13,21
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          sep      scall        ; n = n * n
          dw       getargs
          db       21,21
          sep      scall
          dw       fpmul
fplog_l:  sep      scall        ; need to see if sum == last
          dw       getargs
          db       5,1
          ldi      4            ; 4 bytes to check
          plo      rc
          ldi      0            ; clear comparison flag
          plo      re
fplog_1:  ldn      rd           ; get byte from sum
          str      r2           ; save for comparison
          ldn      rf           ; get point from last
          sm                    ; compare them
          str      r2           ; store to combine with comparison flag
          glo      re           ; get comparison flag
          or                    ; combine
          plo      re           ; put back into comparison
          ldn      rd           ; get byte from sum
          str      rf           ; store into last
          inc      rd           ; increment pointers
          inc      rf
          dec      rc           ; decrement count
          glo      rc           ; see if done
          lbnz     fplog_1      ; jump if not
          glo      re           ; get comparison flag
          lbz      fplog_d      ; jump if done
          sep      scall        ; tmp = pwr
          dw       getargs
          db       17,13
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          sep      scall        ; tmp = tmp / k
          dw       getargs
          db       17,9
          sep      scall
          dw       fpdiv
          sep      scall        ; sum = sum + tmp
          dw       getargs
          db       1,17
          sep      scall
          dw       fpadd
          sep      scall        ; pwr = pwr * n
          dw       getargs
          db       13,21
          sep      scall
          dw       fpmul
          glo      r2           ; k = k + 2
          adi      9
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          mov      rd,fp_2
          sep      scall
          dw       fpadd
          lbr      fplog_l      ; loop until done
fplog_d:  sep      scall        ; sum = sum + sum
          dw       getargs
          db       1,1
          sep      scall
          dw       fpadd
          irx                   ; recover answer
          ldxa     
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldx
          phi      r7
          glo      r2           ; clean up the stack
          adi      20
          plo      r2
          ghi      r2
          adci     0
          phi      r2
          pop      rd           ; recover destination address
          glo      r8           ; store answer
          str      rd
          inc      rd
          ghi      r8
          str      rd
          inc      rd
          glo      r7
          str      rd
          inc      rd
          ghi      r7
          str      rd
          sep      sret         ; and return to caller

; ******************************************************
; ***** Natural exp                                *****
; ***** RF - Pointer to floating point number      *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1     - sum                       *****
; *****       R2+5     - last                      *****
; *****       R2+9     - fct                       *****
; *****       R2+13    - fctCount                  *****
; *****       R2+17    - pwr                       *****
; *****       R2+21    - tmp                       *****
; *****       R2+25    - n                         *****
; ******************************************************
fpexp:    push     rd           ; save destination
          mov      rd,rf        ; n = argument
          sep      scall
          dw       addtows
          stxd                  ; space for tmp
          stxd
          stxd
          stxd
          mov      rd,rf        ; pwr = argument
          sep      scall
          dw       addtows
          mov      rd,fp_2      ; fctCount = 2.0
          sep      scall
          dw       addtows
          mov      rd,fp_1      ; fct = 1.0
          sep      scall
          dw       addtows
          mov      rd,fp_0      ; last = 0
          sep      scall
          dw       addtows
          mov      rd,rf        ; sum = argument
          sep      scall
          dw       addtows
          mov      rf,r2        ; sum = sum + 1
          inc      rf
          mov      rd,fp_1
          sep      scall
          dw       fpadd
fpexp_l:  sep      scall        ; need to see if sum == last
          dw       getargs
          db       5,1
          ldi      4            ; 4 bytes to check
          plo      rc
          ldi      0            ; clear comparison flag
          plo      re
fpexp_1:  ldn      rd           ; get byte from sum
          str      r2           ; save for comparison
          ldn      rf           ; get point from last
          sm                    ; compare them
          str      r2           ; store to combine with comparison flag
          glo      re           ; get comparison flag
          or                    ; combine
          plo      re           ; put back into comparison
          ldn      rd           ; get byte from sum
          str      rf           ; store into last
          inc      rd           ; increment pointers
          inc      rf
          dec      rc           ; decrement count
          glo      rc           ; see if done
          lbnz     fpexp_1      ; jump if not
          glo      re           ; get comparison flag
          lbz      fpexp_d      ; jump if done
          sep      scall        ; pwr = pwr * n
          dw       getargs
          db       17,25
          sep      scall
          dw       fpmul
          sep      scall        ; fct = fct * fctCount
          dw       getargs
          db       9,13
          sep      scall
          dw       fpmul
          glo      r2           ; fctCount = fctCount + 1
          adi      13
          plo      rf
          ghi      r2
          adci     0
          phi      rf
          mov      rd,fp_1
          sep      scall
          dw       fpadd
          sep      scall        ; tmp = pwr
          dw       getargs
          db       21,17
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          inc      rf
          lda      rd
          str      rf
          sep      scall        ; tmp = tmp / fct
          dw       getargs
          db       21,9
          sep      scall
          dw       fpdiv
          sep      scall        ; sum = sum + tmp
          dw       getargs
          db       1,21
          sep      scall
          dw       fpadd
          lbr      fpexp_l      ; loop until done
fpexp_d:  irx                   ; recover answer
          ldxa
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldx
          phi      r7
          glo      r2           ; clean workspace off stack
          adi      24
          plo      r2
          ghi      r2
          adci     0
          phi      r2
          pop      rd           ; recover destination address
          glo      r8           ; store answer
          str      rd
          inc      rd
          ghi      r8
          str      rd
          inc      rd
          glo      r7
          str      rd
          inc      rd
          ghi      r7
          str      rd
          sep      sret         ; and return to caller

; ******************************************************
; ***** Power x^y                                  *****
; ***** RF - Pointer to floating point number x    *****
; ***** RC - Pointer to floating point number y    *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1     - x                         *****
; *****       R2+5     - y                         *****
; ******************************************************
fppow:    push     rd           ; save destination
          mov      rd,rc        ; put y in workspace
          sep      scall
          dw       addtows
          mov      rd,rf        ; put x in workspace
          sep      scall
          dw       addtows
          glo      r2           ; x = log(x)
          plo      rf
          plo      rd
          ghi      r2
          phi      rf
          phi      rd
          inc      rf
          inc      rd
          sep      scall
          dw       fplog
          sep      scall        ; now x = x * y
          dw       getargs
          db       1,5
          sep      scall
          dw       fpmul
          sep      scall        ; x = exp(x)
          dw       getargs
          db       1,1
          sep      scall
          dw       fpexp
          irx                   ; recover result
          ldxa
          plo      r8
          ldxa
          phi      r8
          ldxa
          plo      r7
          ldxa
          phi      r7
          irx                   ; clean rest of stack
          irx
          irx
          pop      rd           ; recover destination
          glo      r8           ; store answer
          str      rd
          inc      rd
          ghi      r8
          str      rd
          inc      rd
          glo      r7
          str      rd
          inc      rd
          ghi      r7
          str      rd
          sep      sret         ; and return to caller


; ******************************************************
; ***** Square root                                *****
; ***** RF - Pointer to floating point number x    *****
; ***** RD - Pointer to floating point destination *****
; ******************************************************
fpsqrt:   mov      rc,fpdot5    ; need to do x**(1/2)
          lbr      fppow


; ******************************************************
; ***** atan                                       *****
; ***** RF - Pointer to floating point number      *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1     - count                     *****
; *****       R2+3     - sum                       *****
; *****       R2+7     - sign                      *****
; *****       R2+8     - pwr                       *****
; *****       R2+12    - last                      *****
; *****       R2+16    - k                         *****
; *****       R2+20    - tmp                       *****
; *****       R2+24    - sgn                       *****
; *****       R2+28    - n                         *****
; *****       R2+32    - tmp2
; ******************************************************
fpatan:       sep       scall          ; check for 0 argument
              dw        iszero
              lbnf      fpatan_go      ; jump if not zero
fpzero:       ldi       0              ; result is zero
              str       rd
              inc       rd
              str       rd
              inc       rd
              str       rd
              inc       rd
              str       rd
              sep       sret           ; and return
fpatan_go:    push      rd             ; save destination
              stxd                     ; space for tmp2
              stxd
              stxd
              stxd
              mov       rd,rf          ; n = argument
              sep       scall
              dw        addtows
              mov       rd,fp_1        ; sgn = 1
              sep       scall
              dw        addtows
              stxd                     ; space for tmp
              stxd
              stxd
              stxd
              mov       rd,fp_3        ; k = 3
              sep       scall
              dw        addtows
              mov       rd,fp_0        ; last = 0
              sep       scall
              dw        addtows
              mov       rd,rf          ; pwr = argument
              sep       scall
              dw        addtows
              inc       rf             ; point to msb of argument
              inc       rf
              inc       rf
              ldn       rf             ; retreive it
              dec       rf             ; move pointer back
              dec       rf
              dec       rf
              ani       080h           ; keep only sign bit
              stxd                     ; sign = sign of argument
              mov       rd,rf          ; sum = argument
              sep       scall
              dw        addtows
              ldi       3              ; count = 1000
              stxd
              ldi       0e8h
              stxd
              sep       scall          ; n = n * n
              dw        getargs
              db        28,28
              sep       scall
              dw        fpmul

              glo       r2             ; point exponent of n
              adi       30
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              lda       rf             ; get low bit of exponent
              shl                      ; shift into DF
              ldn       rf             ; get high bits of exponent
              shlc                     ; shift in low bit
              shl                      ; see if high bit is set (>= 2)
              lbdf      fpatan_2       ; jump if so
              shrc                     ; shift bit back in
              smi       07fh           ; check for less than 1
              lbnz      fpatan_1       ; jump if less than 1
              dec       rf             ; back to high byte of mantissa
              ldn       rf             ; retrieve it
              ani       07fh           ; clear high byte
              lbnz      fpatan_2       ; jump if greater than 1
              dec       rf             ; middle byte of mantissa
              ldn       rf
              lbnz      fpatan_2
              dec       rf             ; low byte of mantissa
              ldn       rf
              lbnz      fpatan_2
fpatan_1:     irx                      ; recover count
              ldxa
              plo       rc
              ldx
              phi       rc
              dec       rc             ; decrement count
              ghi       rc             ; put it back
              stxd
              glo       rc
              stxd
              glo       rc             ; check for nonzero
              lbnz      fpatan_1a      ; jump if not
              ghi       rc
              lbz       fpatan_dn      ; otherwise done
fpatan_1a:    sep       scall          ; need to see if sum == last
              dw        getargs
              db        12,3
              ldi       4              ; 4 bytes to check
              plo       rc
              ldi       0              ; clear comparison flag
              plo       re
fpatan_1b:    ldn       rd             ; get byte from sum
              str       r2             ; save for comparison
              ldn       rf             ; get point from last
              sm                       ; compare them
              str       r2             ; store to combine with comparison flag
              glo       re             ; get comparison flag
              or                       ; combine
              plo       re             ; put back into comparison
              ldn       rd             ; get byte from sum
              str       rf             ; store into last
              inc       rd             ; increment pointers
              inc       rf
              dec       rc             ; decrement count
              glo       rc             ; see if done
              lbnz      fpatan_1b      ; jump if not
              glo       re             ; get comparison flag
              lbz       fpatan_dn      ; jump if done
              sep       scall          ; pwr = pwr * n
              dw        getargs
              db        8,28
              sep       scall
              dw        fpmul
              glo       r2             ; sgn = -sgn
              adi       27
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              ldn       rf
              xri       080h
              str       rf
              sep       scall          ; tmp = sgn
              dw        getargs
              db        20,24
              lda       rd
              str       rf
              inc       rf
              lda       rd
              str       rf
              inc       rf
              lda       rd
              str       rf
              inc       rf
              lda       rd
              str       rf
              sep       scall          ; tmp = tmp * pwr
              dw        getargs
              db        20,8
              sep       scall
              dw        fpmul
              sep       scall          ; tmp = tmp / k
              dw        getargs
              db        20,16
              sep       scall
              dw        fpdiv
              sep       scall          ; sum = sum + tmp
              dw        getargs
              db        3,20
              sep       scall
              dw        fpadd
              glo       r2             ; k = k + 2
              adi       16
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              mov       rd,fp_2
              sep       scall
              dw        fpadd
              lbr       fpatan_1       ; loop until done
     

fpatan_2:     glo       r2             ; tmp = 1
              adi       20
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              mov       rd,fp_1
              sep       scall
              dw        fpcopy
              sep       scall          ; tmp = tmp / sum
              dw        getargs
              db        20,3
              sep       scall
              dw        fpdiv
              sep       scall          ; sum = tmp
              dw        getargs
              db        3,20
              sep       scall
              dw        fpcopy
              glo       r2             ; tmp = pi / 2
              adi       20
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              mov       rd,fp_halfpi
              sep       scall
              dw        fpcopy
              sep       scall          ; tmp = tmp - sum
              dw        getargs
              db        20,3
              sep       scall
              dw        fpsub
              sep       scall          ; sum = tmp
              dw        getargs
              db        3,20
              sep       scall
              dw        fpcopy
              glo       r2             ; sgn = -sgn
              adi       27
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              ldn       rf
              xri       080h
              str       rf
fpatan_2lp:   irx                      ; recover count
              ldxa
              plo       rc
              ldx
              phi       rc
              dec       rc             ; decrement count
              ghi       rc             ; put it back
              stxd
              glo       rc
              stxd
              glo       rc             ; check for nonzero
              lbnz      fpatan_2a      ; jump if not
              ghi       rc
              lbz       fpatan_dn      ; otherwise done
fpatan_2a:    sep       scall          ; need to see if sum == last
              dw        getargs
              db        12,3
              ldi       4              ; 4 bytes to check
              plo       rc
              ldi       0              ; clear comparison flag
              plo       re
fpatan_2b:    ldn       rd             ; get byte from sum
              str       r2             ; save for comparison
              ldn       rf             ; get point from last
              sm                       ; compare them
              str       r2             ; store to combine with comparison flag
              glo       re             ; get comparison flag
              or                       ; combine
              plo       re             ; put back into comparison
              ldn       rd             ; get byte from sum
              str       rf             ; store into last
              inc       rd             ; increment pointers
              inc       rf
              dec       rc             ; decrement count
              glo       rc             ; see if done
              lbnz      fpatan_2b      ; jump if not
              glo       re             ; get comparison flag
              lbz       fpatan_dn      ; jump if done
              sep       scall          ; pwr = pwr * n
              dw        getargs
              db        8,28
              sep       scall
              dw        fpmul
              glo       r2             ; sgn = -sgn
              adi       27
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              ldn       rf
              xri       080h
              str       rf
              sep       scall          ; tmp = k
              dw        getargs
              db        20,16
              sep       scall
              dw        fpcopy
              sep       scall          ; tmp = tmp * pwr
              dw        getargs
              db        20,8
              sep       scall
              dw        fpmul
              sep       scall          ; tmp2 = sgn
              dw        getargs
              db        32,24
              sep       scall
              dw        fpcopy
              sep       scall          ; tmp2 = tmp2 / tmp
              dw        getargs
              db        32,20
              sep       scall
              dw        fpdiv
              sep       scall          ; sum = sum + tmp2
              dw        getargs
              db        3,32
              sep       scall
              dw        fpadd
              glo       r2             ; k = k + 2
              adi       16
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              mov       rd,fp_2
              sep       scall
              dw        fpadd
              lbr       fpatan_2lp     ; loop until done
fpatan_dn:    irx                      ; remove count from stack
              irx
              irx                      ; recover answer
              ldxa
              plo       r8
              ldxa
              phi       r8
              ldxa
              plo       r7
              ldxa
              phi       r7
              ldx                      ; get sign
              lbz       fpatan_dn1     ; jump if not negative
              ghi       r7             ; make answer negative
              xri       080h
              phi       r7
fpatan_dn1:   glo       r2             ; clean workspace off stack
              adi       28
              plo       r2
              ghi       r2
              adci      0
              phi       r2
              pop       rd             ; recover destination
              glo       r8             ; store answer
              str       rd
              inc       rd
              ghi       r8
              str       rd
              inc       rd
              glo       r7
              str       rd
              inc       rd
              ghi       r7
              str       rd
              sep       sret           ; return to caller
 

; ******************************************************
; ***** asin                                       *****
; ***** RF - Pointer to floating point number x    *****
; ***** RC - Pointer to floating point number y    *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1     - n                         *****
; *****       R2+5     - sign                      *****
; *****       R2+6     - tmp                       *****
; ******************************************************
fpasin:       sep       scall          ; check for 0 argument
              dw        iszero
              lbdf      fpzero         ; return 0
              push      rd             ; save destination
              stxd                     ; make space for n
              stxd
              stxd
              stxd
              inc       rf             ; point to sign of argument
              inc       rf
              inc       rf
              ldn       rf             ; retrieve it
              dec       rf             ; move pointer back
              dec       rf
              dec       rf
              ani       080h           ; keep only sign bit
              stxd                     ; sign = sign bit
              mov       rd,rf          ; n = argument
              sep       scall
              dw        addtows
              sep       scall          ; n = n * n
              dw        getargs
              db        1,1
              sep       scall
              dw        fpmul
              glo       r2             ; tmp = 1.0
              adi       6
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              mov       rd,fp_1
              sep       scall
              dw        fpcopy
              sep       scall          ; tmp = tmp - n;
              dw        getargs
              db        6,1
              sep       scall
              dw        fpsub
              sep       scall          ; n = n / tmp
              dw        getargs
              db        1,6
              sep       scall
              dw        fpdiv
              sep       scall          ; n = sqrt(n)
              dw        getargs
              db        1,1
              sep       scall
              dw        fpsqrt
              sep       scall          ; n = atan(n)
              dw        getargs
              db        1,1
              sep       scall
              dw        fpatan
              irx                      ; recover answer
              ldxa
              plo       r8
              ldxa
              phi       r8
              ldxa
              plo       r7
              ldxa
              phi       r7
              ldx                      ; get sign
              lbz       fpasin_dn1     ; jump if not negative
              ghi       r7             ; make answer negative
              xri       080h
              phi       r7
fpasin_dn1:   irx                      ; clean workspace off stack
              irx
              irx
              irx
              pop       rd             ; recover destination
              glo       r8             ; store answer
              str       rd
              inc       rd
              ghi       r8
              str       rd
              inc       rd
              glo       r7
              str       rd
              inc       rd
              ghi       r7
              str       rd
              sep       sret           ; return to caller


; ******************************************************
; ***** acos                                       *****
; ***** RF - Pointer to floating point number x    *****
; ***** RC - Pointer to floating point number y    *****
; ***** RD - Pointer to floating point destination *****
; ***** internal:                                  *****
; *****       R2+1     - n                         *****
; *****       R2+5     - sign                      *****
; *****       R2+6     - tmp                       *****
; ******************************************************
fpacos:       sep       scall          ; check for 0 argument
              dw        iszero
              lbdf      fpzero         ; return 0
              push      rd             ; save destination
              stxd                     ; make space for tmp
              stxd
              stxd
              stxd
              inc       rf             ; point to sign of argument
              inc       rf
              inc       rf
              ldn       rf             ; retrieve it
              dec       rf             ; move pointer back
              dec       rf
              dec       rf
              ani       080h           ; keep only sign bit
              stxd                     ; sign = sign bit
              mov       rd,rf          ; n = argument
              sep       scall
              dw        addtows
              sep       scall          ; n = n * n
              dw        getargs
              db        1,1
              sep       scall
              dw        fpmul
              glo       r2             ; tmp = 1.0
              adi       6
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              mov       rd,fp_1
              sep       scall
              dw        fpcopy
              sep       scall          ; tmp = tmp - n;
              dw        getargs
              db        6,1
              sep       scall
              dw        fpsub
              sep       scall          ; tmp = tmp / n
              dw        getargs
              db        6,1
              sep       scall
              dw        fpdiv
              sep       scall          ; n = sqrt(tmp)
              dw        getargs
              db        6,1
              sep       scall
              dw        fpsqrt
              sep       scall          ; n = atan(n)
              dw        getargs
              db        1,1
              sep       scall
              dw        fpatan

              glo       r2             ; point to sign
              adi       5
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              ldn       rf             ; get sign
              lbz       fpacos_dn      ; jump of argument was positive
              glo       r2             ; tmp = pi
              adi       6    
              plo       rf
              ghi       r2
              adci      0
              phi       rf
              mov       rd,fp_pi
              sep       scall
              dw        fpcopy
              sep       scall          ; tmp = tmp - n
              dw        getargs
              db        6,1
              sep       scall
              dw        fpsub
              sep       scall          ; n = tmp
              dw        getargs
              db        1,6
              sep       scall
              dw        fpcopy
fpacos_dn:    irx                      ; recover answer
              ldxa
              plo       r8
              ldxa
              phi       r8
              ldxa
              plo       r7
              ldxa
              phi       r7
fpacos_dn1:   irx                      ; clean workspace off stack
              irx
              irx
              irx
              pop       rd             ; recover destination
              glo       r8             ; store answer
              str       rd
              inc       rd
              ghi       r8
              str       rd
              inc       rd
              glo       r7
              str       rd
              inc       rd
              ghi       r7
              str       rd
              sep       sret           ; return to caller

