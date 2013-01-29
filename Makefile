all: helloos.s
	as helloos.s -o helloos.o
	objcopy -O binary helloos.o
run.x86:
	kvm -fda helloos.o -net none -no-kvm
