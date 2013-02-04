#the first code be calling from boot.s

VIDEO_PALLETE_PORT = 0x03c8
BG_INDEX_COLOR     = 0
COLOR_SELECTION_PORT = 0x03c9


color:
.byte 0x00,0x00,0x00 #black
.byte 0xff,0x00,0x00
.byte 0x00,0xff,0x00
.byte 0xff,0xff,0x00
.byte 0x00,0x00,0xff
.byte 0xff,0x00,0xff
.byte 0x00,0xff,0xff
.byte 0xff,0xff,0xff
.byte 0xc6,0xc6,0xc6
.byte 0x84,0x00,0x00
.byte 0x00,0x84,0x00
.byte 0x84,0x84,0x00
.byte 0x00,0x00,0x84
.byte 0x84,0x00,0x84
.byte 0x00,0x84,0x84
.byte 0x00,0x84,0x84
.byte 0x84,0x84,0x84


.code16
.global lowlevel_init
.global io_hlt
set_bg_color:
    movw    $VIDEO_PALLETE_PORT,    %dx
    movb    $BG_INDEX_COLOR,           %al
    outb    %al,                    %dx
    
    movw    $COLOR_SELECTION_PORT,  %dx
    movb    $0,                     %al
    outb    %al,                    %dx
    movb    $0,                     %al
    outb    %al,                    %dx
    movb    $18,                     %al
    outb    %al,                    %dx
    ret
    
io_hlt:
    hlt
    ret

clear_screen:
    movb    $0x6, %ah
    movb    $0,   %al
    movb    $0,   %ch
    movb    $0,   %cl
    movb    $24,  %dh
    movb    $79,  %dl
    movb    $0x07,  %bh
    int     $0x10
    ret

lowlevel_init:

    call clear_screen
#setting video mode
    mov $0x6a,%al
    mov $0x00,%ah
    int $0x10

    call set_bg_color

    movb $0x0, %bh
    movw $300, %dx
    movw $0, %cx
    movb $0x0c, %ah
    movb $9,    %al

1:
    int $0x10
    incw    %cx
    cmpw    $200,   %cx
    jne 1b

    jmp fin
############################################




    movw $0xa000,%ax
    movw %ax,   %es
    movw $-1,    %bx
2:
    incw %bx
    movw $0x3234,%es:(%bx)
    cmpw $0xFFFF, %bx
    jb 2b

#entry
#    jmp main

fin:
    hlt
    jmp fin
