SECTIONS
{
        . = 0x7c00;
        .data : { helloos.o(.data) }

        .text :
        {
            lowlevel_init.o(.text*)    
            
        }

}

