/*
 * Blinky program for MCB1768 - ARM Cortex-M3
 *
 * The LEDs are at these pins:
 * - P1.28, P1.29, P1.31
 * - P2.2, P2.3, P2.4, P2.5, P2.6
 *
 */
 /* Thumb-2 instructions are only supported in unified syntax mode */
 .syntax unified
 /* Put these codes into .text section */
 .section ".text"
 /* Declare as thumb function..Otherwise it may not linked correctly */
 .thumb_func
 /* Declare main() as global so the linker can find it */
 .global main
main:
 /* Set the pins direction as output */
 bl     set_gpio_dir
loop:
 bl     clear_leds
 bl     delay
 bl     set_leds
 bl     delay
 b      loop
 
 .thumb_func
set_gpio_dir:
 /* Habilito el GPIO PIOB27 (pin13 en el ArduinoDue) */
 /* PIO_PER para PIOB en 0x400E1000 */
 MOVW    R3, #0x1000
 MOVT    R3, #0x400E
 /* Habilitar PIOB27: 0x08000000 */
 MOVW    R2, #0x0000
 MOVT    R2, #0x0800
 STR     R2, [R3, #0]

 /* Seteo el GPIO PIOB27 como output */
 /* PIO_OER para PIOB en 0x400E1010 */
 MOVW   R3, #0x1010
 MOVT   R3, #0x400E
 /* Habilitar PIOB27: 0x08000000 */
 MOVW    R2, #0x0000
 MOVT    R2, #0x0800
 STR     R2, [R3, #0]

 /* Disable the pull up resistor */
 /* PIO_PUDR para PIOB en 0x400E1060 */
 MOVW   R3, #0x1060
 MOVT   R3, #0x400E
 /* Habilitar PIOB27: 0x08000000 */
 MOVW    R2, #0x0000
 MOVT    R2, #0x0800
 STR     R2, [R3, #0] 
  
 BX      LR
 
 .thumb_func
set_leds:
 /* Sets the data to be driven on the IO line */
 /* PIO_SODR para PIOB en 0x400E1030 */
 MOVW   R3, #0x1030
 MOVT   R3, #0x400E
 /* Habilitar PIOB27: 0x08000000 */
 MOVW    R2, #0x0000
 MOVT    R2, #0x0800
 STR     R2, [R3, #0]
 BX      LR
 
 .thumb_func
clear_leds:
 /* Clears the data to be driven on the I/O line */
 /* PIO_SODR para PIOB en 0x400E1034 */
 MOVW   R3, #0x1034
 MOVT   R3, #0x400E
 /* Habilitar PIOB27: 0x08000000 */
 MOVW    R2, #0x0000
 MOVT    R2, #0x0800
 STR     R2, [R3, #0]
 BX      LR
 
 .thumb_func
delay:
 MOVW    R3, #0xFFFF
 MOVT    R3, #0x000F
__delay_loop:
 CBZ     R3, __delay_exit
 SUB     R3, R3, #1
 B       __delay_loop
__delay_exit:
 BX      LR
