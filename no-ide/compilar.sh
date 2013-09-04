arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. sketch.cpp -o sketch.cpp.o

arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. cortex_handlers.c -o cortex_handlers.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. hooks.c -o hooks.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. iar_calls_sam3.c -o iar_calls_sam3.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. itoa.c -o itoa.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. syscalls_sam3.c -o syscalls_sam3.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. WInterrupts.c -o WInterrupts.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. wiring.c -o wiring.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. wiring_analog.c -o wiring_analog.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. wiring_digital.c -o wiring_digital.c.o
arm-none-eabi-gcc -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. wiring_shift.c -o wiring_shift.c.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I.

arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. cxxabi-compat.cpp -o cxxabi-compat.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. IPAddress.cpp -o IPAddress.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. main.cpp -o main.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. Print.cpp -o Print.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. Reset.cpp -o Reset.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. RingBuffer.cpp -o RingBuffer.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. sketch.cpp -o sketch.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. Stream.cpp -o Stream.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. UARTClass.cpp -o UARTClass.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. USARTClass.cpp -o USARTClass.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. variant.cpp -o variant.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. wiring_pulse.cpp -o wiring_pulse.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. WMath.cpp -o WMath.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. WString.cpp -o WString.cpp.o
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. USB/CDC.cpp -o CDC.cpp
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. USB/HID.cpp -o HID.cpp
arm-none-eabi-g++ -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=840000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -I. USB/USBCore.cpp -o USBCore.cpp

arm-none-eabi-ar rcs core.a cortex_handlers.c.o
arm-none-eabi-ar rcs core.a hooks.c.o
arm-none-eabi-ar rcs core.a iar_calls_sam3.c.o
arm-none-eabi-ar rcs core.a itoa.c.o
arm-none-eabi-ar rcs core.a syscalls_sam3.c.o
arm-none-eabi-ar rcs core.a WInterrupts.c.o
arm-none-eabi-ar rcs core.a wiring.c.o
arm-none-eabi-ar rcs core.a wiring_analog.c.o
arm-none-eabi-ar rcs core.a wiring_digital.c.o
arm-none-eabi-ar rcs core.a wiring_shift.c.o
arm-none-eabi-ar rcs core.a cxxabi-compat.cpp.o
arm-none-eabi-ar rcs core.a IPAddress.cpp.o
arm-none-eabi-ar rcs core.a main.cpp.o
arm-none-eabi-ar rcs core.a Print.cpp.o
arm-none-eabi-ar rcs core.a Reset.cpp.o
arm-none-eabi-ar rcs core.a RingBuffer.cpp.o
arm-none-eabi-ar rcs core.a Stream.cpp.o
arm-none-eabi-ar rcs core.a UARTClass.cpp.o
arm-none-eabi-ar rcs core.a USARTClass.cpp.o
arm-none-eabi-ar rcs core.a CDC.cpp.o
arm-none-eabi-ar rcs core.a HID.cpp.o
arm-none-eabi-ar rcs core.a USBCore.cpp.o
arm-none-eabi-ar rcs core.a wiring_pulse.cpp.o
arm-none-eabi-ar rcs core.a WMath.cpp.o
arm-none-eabi-ar rcs core.a WString.cpp.o
arm-none-eabi-ar rcs core.a variant.cpp.o

arm-none-eabi-g++ -Os -Wl,--gc-sections -mcpu=cortex-m3 -Tflash.ld -Wl,-Map,sketch.cpp.map -o sketch.cpp.elf -L. -lm -lgcc -mthumb -Wl,--cref -Wl,--check-sections -Wl,--gc-sections -Wl,--entry=Reset_Handler -Wl,--unresolved-symbols=report-all -Wl,--warn-common -Wl,--warn-section-align -Wl,--warn-unresolved-symbols -Wl,--start-group syscalls_sam3.c.o sketch.cpp.o libsam_sam3x8e_gcc_rel.a core.a -Wl,--end-group

arm-none-eabi-objcopy -O binary sketch.cpp.elf sketch.cpp.bin
