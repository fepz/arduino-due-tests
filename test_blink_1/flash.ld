/*
 * Define the supported output formats - elf32-littlearm is the
 *  default
 */
OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 
/* Define the target architecture */
OUTPUT_ARCH(arm)
 
/* Memory Spaces Definitions */
/* The MEMORY command describes the location and size of blocks of memory in the target. */
/* Del manual del Atmel SAM3X: "The user can see the SRAM as contiguous thanks 
   to mirror effect, giving 0x2007 0000 - 0x2008 7FFF for SAM3X/A8" */
MEMORY
{
    rom (rx)    : ORIGIN = 0x00080000, LENGTH = 0x00080000 /* Flash, 512K */
    sram0 (rwx) : ORIGIN = 0x20000000, LENGTH = 0x00010000 /* sram0, 64K */
    sram1 (rwx) : ORIGIN = 0x20080000, LENGTH = 0x00008000 /* sram1, 32K */
    ram (rwx)   : ORIGIN = 0x20070000, LENGTH = 0x00018000 /* sram, 96K */
}

/* Define the system entry point */
ENTRY(Reset_Handler)
 
/* Define the memory layout for the board */
SECTIONS
{
    .text :
    {
        . = ALIGN(4);

        /* collect any .cs3.interrupt_vector section to this address */
        KEEP(*(.cs3.interrupt_vector));
 
        /* Collect the executable parts here */
        *(.text .text.*);
        /* Collect the const variables here */
        *(.rodata .rodata.*);
 
        __sidata = .;
    } > rom
 
    /*
    * This section refers to variables with init value. The init values are
    * stored on ROM, but addressed on RAM (otherwise the variables cannot be
    * manipulated).
    *
    * This section will be loaded at 0x10000000, the start of LPC1766 RAM
    * En el Arduino Due, esta seccion parece ser 0x20000000
    */
    .data_at_ram : AT (LOADADDR(.text) + SIZEOF(.text))
    {
        __sdata = .;
        *(.data .data.*);
        __edata = .;
    } > ram
 
    .static_ram :
    {
        __sbss = .;
        /* Collect the global / static variables, without init value here */
        *(.bss .bss.*);
        __ebss = .;
    } > ram
 
    /* Set __cs3_stack to point the end of memory
    * This one depends on your MCU. I'm using LPC1766 with 256kB flash and
    * 32kB RAM
    * El ArduinoDue tiene 96 KBytes de SRAM. 
    */
    __cs3_stack = ORIGIN(ram) + LENGTH(ram);
}
