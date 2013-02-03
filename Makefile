#COBJS := main.c
SOBJS = helloos.o lowlevel_init.o
LDSCRITP = helloos.lds
#SRCS := $(SOBJS:.o=.s) $(COBJS:.o=.c)



helloos: $(SOBJS) $(LDSCRITP)
	ld --oformat binary -N -T $(LDSCRITP) $(SOBJS) -o $@
boot.img: helloos
	dd if=helloos of=boot.img bs=512 count=1024
run.x86: boot.img
	kvm -d cpu -fda $< -net none -no-kvm

clean:
	rm -rf boot.img helloos $(SOBJS)
