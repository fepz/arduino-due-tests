/* Formato de salida del binario */
OUTPUT_FORMAT("elf32-littlearm")
 
/* Arquitectura de la plataforma */
OUTPUT_ARCH(arm)
 
/* Como esta organizada la memoria */
MEMORY
{
    rom (rx)    : ORIGIN = 0x00080000, LENGTH = 0x00080000 /* Flash, 512K */
    sram0 (rwx) : ORIGIN = 0x20000000, LENGTH = 0x00010000 /* sram0, 64K */
    sram1 (rwx) : ORIGIN = 0x20080000, LENGTH = 0x00008000 /* sram1, 32K */
    ram (rwx)   : ORIGIN = 0x20070000, LENGTH = 0x00018000 /* sram, 96K */
}

/* Secciones del programa según la distribución de la memoria */
SECTIONS
{
    .text : { *(.text .text.*) } > rom
    .data : { *(.data .data.*) } > ram
}
