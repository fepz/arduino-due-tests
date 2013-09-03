ARMGNU?=arm-none-eabi

all : blink.bin

blink.bin : blink.s start.s flash.ld
	$(ARMGNU)-as -mcpu=cortex-m3 blink.s -o blink.o
	$(ARMGNU)-as -mcpu=cortex-m3 start.s -o start.o
	$(ARMGNU)-ld -o blink.elf blink.o start.o -T flash.ld
	$(ARMGNU)-objdump -D blink.elf > blink.list
	$(ARMGNU)-objcopy blink.elf blink.bin -O binary

clean:
	rm -f *.bin
	rm -f *.o
	rm -f *.elf
	rm -f *.list
	