
BOOTSEG = 0x0

.section .data
start:
#.byte 0xeb,0x4e,0x90
jmp main_start
.ascii "HELLOIPL"
.word 512
.byte 1
.word 1
.byte 2
.word 224
.word 2880
.byte 0xf0
.word 9
.word 18
.word 2
.word 0 
.word 0 
.word 2880
.word 0 
.byte 0,0,0x29
.word 0xffff
.word 0xffff
.ascii "HELLO-OS   "
.ascii "FAT12   "

myvar:
.skip 18
main_start:
#int $0x19

#    movb $2,%ah
#    movb $10,%dh
#    movb $20,%dl
#    movb $0,bh
#    int $0x10
#

#    movl 0xe820,%eax
#    int $0x15


#    movl $msg,%esi
#  this statments not normal work.


    movl $0,%eax
    movl $0x7c00,%esp
    mov %ax,%ss
    mov %ax,%ds
    mov %ax,%es
#
#    je fin
#
loadmsg:
#    mov $msg,%si
#
##    movb $10,%cl
#putloop:
#    movb 0x7c99,%al
##   add $1,%si
##    cmp $0,%al
##    je fin
##
##    movb %ds:(%si),%al
#    movb $0x0e, %ah
##    movw $15,%bx
#    int $0x10
##   jmp putloop
#
##
##    

#    movb 0x7cb3,%al
#    movb $0x0e, %ah
#    int $0x10
#    movb 0x7cb4,%al
#    movb $0x0e, %ah
#    int $0x10
#    movb 0x7cb5,%al
#    movb $0x0e, %ah
#    int $0x10
#    movb 0x7cb6,%al
#    movb $0x0e, %ah
#    int $0x10
#    movb 0x7cb7,%al
#    movb $0x0e, %ah
#    int $0x10

##    movb $0x0e, %ah
##    movb (%esi),%al
##    int $0x10
##    movb 1(%esi),%al
##    int $0x10
##    movb 2(%esi),%al
##    int $0x10
##    #movb (%si),%al
#    int $0x10

    movl $msg,%esi
putloop:
    lodsb
    cmp $0,%al
    je fin
    movb $0x0e, %ah
    int $0x10
    jmp putloop
    

fin:
    hlt
    jmp fin


.byte 0,2,31,23,21,312,31,23
msg:
.ascii "Hypervisor"
.byte 0xa
.byte 0

here:
.set length2, here - start
.skip 0x1fe - length2
.byte 0x55,0xaa

.byte 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
.skip 4600
.byte 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00

.skip 1469433
