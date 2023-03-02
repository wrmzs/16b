boot.bin:
	nasm -f bin src/boot.asm -o boot.bin

kernel.bin: boot.bin
	nasm -f bin src/kernel.asm -o kernel.bin

programs.bin: kernel.bin
	python scripts/build-programs.py
	
16b.bin: programs.bin
	cat boot.bin filetable.bin kernel.bin programs.bin > 16b.bin

16b.flp: 16b.bin
	mkdosfs -C 16b.flp 1440
	dd status=noxfer conv=notrunc if=16b.bin of=16b.flp

16b.iso: 16b.flp
	mkdir iso
	cp 16b.flp iso/
	mkisofs -quiet -V '16b' -input-charset iso8859-1 -o 16b.iso -b 16b.flp iso
	
qemu: 16b.flp
	qemu-system-i386 -fda 16b.flp

clean:
	rm *.bin
	rm 16b.flp
	rm 16b.iso
