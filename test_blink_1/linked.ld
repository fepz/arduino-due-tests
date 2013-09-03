/*
 * Define the supported output formats - elf32-littlearm is the
 *  default
 */
OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 
/* Define the target architecture */
OUTPUT_ARCH(arm)
 
/* Define the system entry point */
ENTRY(Reset_Handler)
 
/* Define the memory layout for the board */
SECTIONS
{
 /* LPC1766 flash is at 0x0000_0000 */
 /* .flash 0x00000000 : */
 /* En el arduino due, flash tmb es 0x0000_0000 */
 .flash 0x00000000 :
 {
 /* Tell the linker to collect any .cs3.interrupt_vector section to this
 address */
 KEEP(*(.cs3.interrupt_vector));
 
 /* Collect the executable parts here */
 *(.text .text.*);
 /* Collect the const variables here */
 *(.rodata .rodata.*);
 
 __sidata = .;
 }
 
 /*
 * This section refers to variables with init value. The init values are
 * stored on ROM, but addressed on RAM (otherwise the variables cannot be
 * manipulated).
 *
 * This section will be loaded at 0x10000000, the start of LPC1766 RAM
 * En el Arduino Due, esta seccion parece ser 0x20000000
 */
 .data_at_ram 0x20000000: AT (LOADADDR(.flash) + SIZEOF(.flash))
 {
 __sdata = .;
 *(.data .data.*);
 __edata = .;
 }
 
 .ram :
 {
 __sbss = .;
 /* Collect the global / static variables, without init value here */
 *(.bss .bss.*);
 __ebss = .;
 }
 
 /* Set __cs3_stack to point the end of memory
 * This one depends on your MCU. I'm using LPC1766 with 256kB flash and
 * 32kB RAM
 * El ArduinoDue tiene 96 KBytes de SRAM. 
 */
 
 __cs3_stack = 0x20000000 + (96 * 1024);
}
