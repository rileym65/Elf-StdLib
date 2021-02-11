
; ********************************************************************
; ***** Beginning of test code, will be removed in final library *****
; ********************************************************************
include  bios.inc
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


         mov     rf,arg1+2
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
ascii2:  db      '17',0
string1: db      'abide',0
string2: db      'abade',0

; *************************************************************************
; *****                         End of test code                      *****
; *************************************************************************

           org     0c000h
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

; ************************************************
; ***** 32-bit Add.    M[R7]=M[R7]+M[R8]     *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
add32:   push     r7                ; save consumed registers
         push     r8
         sex      r8                ; point x to second number
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
         pop      r8                ; restore consumed registers
         pop      r7
         sep      sret              ; return to caller
        
    

; ************************************************
; ***** 32-bit subtract.  M[R7]=M[R7]-M[R8]  *****
; ***** Numbers in memory stored LSB first   *****
; ************************************************
sub32:   push     r7                ; save consumed registers
         push     r8
         sex      r8                ; point x to second number
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
         pop      r8                ; restore consumed registers
         pop      r7
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
         sep      sret              ; and return


; ************************************************
; ***** 32-bit cmp.  M[R7]-M[R8]             *****
; ***** Numbers in memory stored LSB first   *****
; ***** Returns: D=0 if M[R7]=M[R8]          *****
; *****          DF=1 if M[R7]<M[R8]         *****
; ************************************************
cmp32:   push     r7                ; save registers
         push     r8
         lda      r8                ; get lsb from second number
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
         lda      r8                ; get msb of second number
         str      r2                ; store for subtract
         lda      r7                ; get msb of first number
         smb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         shl                        ; shift sign bit into df
         glo      re                ; get zero test
         or                         ; or last result
         plo      re                ; save for a moment
         pop      r8                ; recover consumed registers
         pop      r7
         glo      re                ; get zero test
         sep      sret              ; return to caller

; ************************************************
; ***** 32-bit cmp.  M[R8]-M[R7]             *****
; ***** Numbers in memory stored LSB first   *****
; ***** Returns: D=0 if M[R7]=M[R8]          *****
; *****          DF=1 if M[R8]<M[R7]         *****
; ************************************************
icmp32:  push     r7                ; save registers
         push     r8
         lda      r8                ; get lsb from second number
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
         lda      r8                ; get msb of second number
         str      r2                ; store for subtract
         lda      r7                ; get msb of first number
         sdb                        ; perform subtraction
         str      r2                ; store for combining with zero test
         shl                        ; shift sign bit into df
         glo      re                ; get zero test
         or                         ; or last result
         plo      re                ; save for a moment
         pop      r8                ; recover consumed registers
         pop      r7
         glo      re                ; get zero test
         sep      sret              ; return to caller


; ***************************************
; ***** is zero check               *****
; ***** returnss: DF=1 if M[RF]=0   *****
; ***************************************
iszero:  lda      rf                ; get lsb
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
mul32:   ldi      0                 ; need to zero answer
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
div32:   ldi      0                 ; set sign flag as positive
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
scdivrt: sep      sret              ; return to caller

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

; **********************************
; ***** Convert ascii to int32 *****
; ***** RF - buffer to ascii   *****
; ***** RD - destinatin int32  *****
; ***** Returns R7:R8 result   *****
; ***** Uses: RA - digits msb  *****
; *****       R9 - counters    *****
; **********************************
atoi:      ldi     0            ; signal positive number
           str     r2           ; store on stack
           ldn     rf           ; get first byte
           smi     '-'          ; check for negative sign
           lbnz    atoip        ; jump if positive number
           ldi     1            ; indicate negative number
           str     r2           ; store onto stack
           inc     rf           ; move past negative sign
atoip:     dec     r2           ; preserve sign flag
           mov     r7,r2        ; keep the last position for moment
           ldi     10           ; need 10 work bytes on the stack
           plo     re
atoi1:     ldi     0            ; put a zero on the stack
           stxd
           dec     re           ; decrement count
           glo     re           ; see if done
           lbnz    atoi1        ; loop until done
           ldi     0            ; need to get count of characters
           plo     re
atoi2:     ldn     rf           ; get character from RF
           smi     '0'          ; see if below digits
           lbnf    atoi3        ; jump if not valid digit
           ldn     rf           ; recover byte
           smi     '9'+1        ; check if above digits
           lbdf    atoi3        ; jump if not valid digit
           inc     rf           ; point to next character
           inc     re           ; increment count
           lbr     atoi2        ; loop until non character found
atoi3:     glo     re           ; were any valid digits found
           lbnz    atoi4        ; jump if so
           ldi     0            ; otherwise result is zero
           plo     r7
           phi     r7
           plo     r8
           phi     r8
atoidn:    glo     r2           ; clear work bytes off stack
           adi     10
           plo     r2
           ghi     r2
           adci    0
           phi     r2
           irx                  ; now point to sign flag
           ldx                  ; and retrieve it
           shr                  ; shift into df
           lbnf    atoidn2      ; jump if positive number
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
atoidn2:   glo     r8           ; write answer to destination
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
           sep     sret         ; and return to caller
atoi4:     dec     rf           ; move back to last valid character
           ldn     rf           ; get digit
           smi     030h         ; convert to binary
           str     r7           ; store into work space
           dec     r7
           dec     re           ; decrement count
           glo     re           ; see if done
           lbnz    atoi4        ; loop until all digits copied
           ldi     0            ; need to clear result
           plo     r7
           phi     r7
           plo     r8
           phi     r8
           ldi     32           ; 32 bits to process
           plo     r9
atoi5:     ldi     10           ; need to shift 10 cells
           plo     re
           mov     ra,r2        ; point to msb
           inc     ra
           ldi     0            ; clear carry bit
           shr
atoi6:     ldn     ra           ; get next cell
           lbnf    atoi6a       ; Jump if no need to set a bit
           ori     16           ; set the incoming bit
atoi6a:    shr                  ; shift cell right
           str     ra           ; store new cell value
           inc     ra           ; move to next cell
           dec     re           ; decrement cell count
           glo     re           ; see if done
           lbnz    atoi6        ; loop until all cells shifted
           ghi     r7           ; shift remaining bit into answer
           shrc
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
           ldi     10           ; need to check 10 cells
           plo     re
           mov     ra,r2        ; point ra to msb
           inc     ra
atoi7:     ldn     ra           ; get cell value
           ani     8            ; see if bit 3 is set
           lbz     atoi7a       ; jump if not
           ldn     ra           ; recover value
           smi     3            ; minus 3
           str     ra           ; put it back
atoi7a:    inc     ra           ; point to next cell
           dec     re           ; decrement cell count
           glo     re           ; see if done
           lbnz    atoi7        ; loop back if not
           dec     r9           ; decrement bit count
           glo     r9           ; see if done
           lbnz    atoi5        ; loop back if more bits
           lbr     atoidn       ; otherwise done
           

; **************************
; ***** String library *****
; **************************

; ***********************************
; ***** Copy string             *****
; ***** RD - destination string *****
; ***** RF - source string      *****
; ***********************************
strcpy:    lda     rf           ; get byte from source string
           str     rd           ; store into destination
           inc     rd
           lbnz    strcpy       ; loop back until terminator copied
           sep     sret         ; return to caller
           
; ***********************************
; ***** Concatenate string      *****
; ***** RD - destination string *****
; ***** RF - source string      *****
; ***********************************
strcat:    lda     rd           ; look for terminator
           lbnz    strcat       ; loop back until terminator found
           dec     rd           ; move back to terminator
           lbr     strcpy       ; and then copy source string to end

; **********************************
; ***** String length          *****
; ***** RF - pointer to string *****
; ***** Returns: RC - length   *****
; **********************************
strlen:    ldi     0            ; set count to zero
           plo     rc
           phi     rc
strlen_1:  lda     rf           ; get byte from string
           lbz     strlen_2     ; jump if terminator found
           inc     rc           ; otherwise increment count
           lbr     strlen_1     ; and keep looking
strlen_2:  sep     sret         ; return to caller

; *****************************************
; ***** Left portion of string        *****
; ***** RF - pointer to source string *****
; ***** RD - pointer to destination   *****
; ***** RC - Count of characters      *****
; *****************************************
left:      glo     rc           ; see if characters left
           str     r2
           ghi     rc
           or
           lbz     left_dn      ; jump if not
           dec     rc           ; decrement count
           lda     rf           ; get byte from source
           str     rd           ; write into destination
           inc     rd
           lbnz    left         ; jump if terminator not found
           sep     sret         ; otherwise return to caller
left_dn:   ldi     0            ; write terminator to destination
           str     rd
           sep     sret         ; and return
           end     start

; *****************************************
; ***** Middle portion of string      *****
; ***** RF - pointer to source string *****
; ***** RD - pointer to destination   *****
; ***** RB - Starting point           *****
; ***** RC - Count of characters      *****
; *****************************************
mid:       glo     rb           ; see if starting position found
           str     r2
           ghi     rc
           or
           lbz     left         ; use left to copy characters
           dec     rb           ; decrement count
           lda     rf           ; get byte from source string
           lbz     left_dn      ; jump if terminator found, will be empty destination
           lbr     mid          ; keep looping until start point 

right:     ldi     0            ; zero counter
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
           lbz     strcpy       ; start found, so now just copy
           glo     rc           ; check rc counter
           str     r2
           ghi     rc
           or
           lbz     strcpy       ; start found, so now just copy
           dec     rb           ; decrement counters
           dec     rc
           lbr     right_2      ; keep looking for start point

; ***************************************
; ***** Convert string to lowercase *****
; ***** RF - Pointer to string      *****
; ***************************************
lower:     ldn     rf           ; get byte from buffer
           lbz     return       ; jump if terminator found
           smi     'A'          ; Check for lower range
           lbnf    lowernxt     ; jump if below range
           smi     26           ; check for above range
           lbdf    lowernxt     ; jump if above range
           ldn     rf           ; get character
           adi     32           ; convert to lowercvase
           str     rf           ; and put it back
lowernxt:  inc     rf           ; point to next character
           lbr     lower        ; process rest of string
return:    sep     sret         ; return to caller

; ***************************************
; ***** Convert string to uppercase *****
; ***** RF - Pointer to string      *****
; ***************************************
upper:     ldn     rf           ; get byte from buffer
           lbz     return       ; jump if terminator found
           smi     'a'          ; Check for lower range
           lbnf    uppernxt     ; jump if below range
           smi     26           ; check for above range
           lbdf    uppernxt     ; jump if above range
           ldn     rf           ; get character
           smi     32           ; convert to lowercvase
           str     rf           ; and put it back
uppernxt:  inc     rf           ; point to next character
           lbr     upper        ; process rest of string

; *********************************************
; ***** String compare                    *****
; ***** RF - string1                      *****
; ***** RD - string2                      *****
; ***** Returns: DF=0 - strings unequal   *****
; *****          DF=1 - strings equal     *****
; *****          D=1  - string1 > string2 *****
; *****          D=0  - string1 < string2 *****
; *********************************************
strcmp:    lda     rf           ; get byte from string1
           str     r2
           lbnz    strcmp_1     ; jump if terminator not found
           lda     rd           ; get byte from second string
           lbz     strcmp_eq    ; jump if strings are equal
           lbr     strcmp_lt    ; jump if string1 is smaller
strcmp_1:  lda     rd           ; get byte from second string
           lbz     strcmp_gt    ; jump if string2 is lower
           sd                   ; subtract from first string
           lbz     strcmp       ; loop to check remaining bytes
           lbdf    strcmp_gt    ; jump if 
strcmp_lt: ldi     0            ; signal string 1 is lower
           shr                  ; mark as not equal
           sep     sret         ; and return
strcmp_eq: ldi     1            ; signal strings equal
           shr
           sep     sret         ; and return
strcmp_gt: ldi     2            ; signal string 2 is lower
           shr
           sep     sret


; **********************************
; ***** Floating point library *****
; **********************************

fp10:      db      00,00,020h,041h

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

