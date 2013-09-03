/* Define the supported output formats - elf32-littlearm is the default */
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

/* Define the memory layout for the board */
SECTIONS
{
    .text : { *(.text*) } > rom
    .bss : { *(.bss*) } > ram
}