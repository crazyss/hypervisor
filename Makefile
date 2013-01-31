all: helloos.s
	as helloos.s -o helloos.o
	ld helloos.o -Tdata 0x7c00 -o helloos -e 0
	objcopy -O binary helloos hypervisor
run.x86:
	kvm -d cpu -fda hypervisor -net none -no-kvm
