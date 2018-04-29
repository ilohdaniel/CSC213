.data
msg1:.asciiz "\nPlease enter a value for A:"
msg2:.asciiz "\nPlease enter a value for B:"
msg3:.asciiz "\nPlease enter a value for C:"
msgerror:.asciiz "\nComplex roots. Please enter a non negative root"
msgans:.asciiz "\nAnswer\n==>("
msgand:.asciiz "\nAnd\n==>("
msggoodbye:.asciiz "\nThats the end of the program."
msgtwo: .float 2
msgfour: .float 4

.text
main:
lwc1 $f1,msgtwo                   #$f1 2.0
lwc1 $f2,msgfour                  #$f2 4.0

la $a0,msg1                      #User enter A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f4,$f0                       #$f4=A

la $a0,msg2                       #User enter B
li $v0,4
syscall
li $v0,6
syscall
mov.s $f5,$f0                       #$f5=B

la $a0,msg3                       #User enter C
li $v0,4
syscall
li $v0,6
syscall
mov.s $f6,$f0                       #$f6=C

#Calculate discriminant d=b*b-4*a*c Where 4=$f2, a=$f4, b=$f5, c=$f6

mul.s $f7,$f5,$f5                  #$f7=b*b
mul.s $f8,$f2,$f4                  
mul.s $f8,$f8,$f6                  #$f8=4*a*c
sub.s $f8,$f7,$f8                  #$f8=d

mfc1 $t1,$f8                      #$f8=$t1
blez $t1,error_label               #Check if d<=0

sqrt.s $f10,$f8                    #$f10=square root d

#roots_solver                      
neg.s $f9,$f5                      #$f9=-b
add.s $f18,$f9,$f10                #-b+sqrtd
sub.s $f20,$f9,$f10                #-b-sqrtd
mul.s $f1,$f1,$f4                  #2*a
div.s $f21,$f18,$f1                #-b+sqrtd/2*a
div.s $f22,$f20,$f1                #-b-sqrtd/2*a
la $a0,msgans
li $v0,4
syscall

#root printer
mov.s $f12,$f21                    #$f12=-b+sqrtd/2*a
li $v0,2
syscall

la $a0,msgand
li $v0,4
syscall

mov.s $f12,$f22                   #$f12=-b-sqrtd/2*a
li $v0,2
syscall

b exit

error_label:
la $a0,msgerror
li $v0,4
syscall

b exit

exit:
la $a0,msggoodbye         
li $v0,4
syscall
li $v0,10                    
syscall
