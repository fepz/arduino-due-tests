.cpu cortex-m3
.thumb

.word 0x20088000    /* stack top address */
.word _start        /* 1 Reset */
.word hang /* 2 NMI */
.word hang /* 3 HardFault */
.word hang /* 4 MemManage */
.word hang /* 5 BusFault */
.word hang /* 6 UsageFault */
.word hang /* 7 RESERVED */
.word hang /* 8 RESERVED */
.word hang /* 9 RESERVED*/
.word hang /* 10 RESERVED */
.word hang /* 11 SVCall */
.word hang /* 12 Debug Monitor */
.word hang /* 13 RESERVED */
.word hang /* 14 PendSV */
.word hang /* 15 SysTick */
.word hang /* 16 External Interrupt(0) */
.word hang /* 17 External Interrupt(1) */
.word hang /* 18 External Interrupt(2) */
.word hang /* 19 ... */

.thumb_func
hang:
    b .

.thumb_func
.global main
_start:
    /* Set the pins direction as output */
    bl      set_gpio_dir

    __loop:
        bl      clear_leds
        bl      delay
        bl      set_leds
        bl      delay
        b       __loop
 
.thumb_func
set_gpio_dir:
    movw    r2, #0x0000
    movt    r2, #0x0800

    /* Habilito el GPIO PIOB27 (pin13 del ArduinoDue) */
    /* PIO_PER para PIOB en 0x400E1000 */
    movw    r3, #0x1000
    movt    r3, #0x400E
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]

    /* Seteo el GPIO PIOB27 como output */
    /* PIO_OER para PIOB en 0x400E1010 */
    movw    r3, #0x1010
    movt    r3, #0x400E
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]

    /* Disable the pull up resistor */
    /* PIO_PUDR para PIOB en 0x400E1060 */
    movw    r3, #0x1060
    movt    r3, #0x400E
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0] 

    bx      lr
 
.thumb_func
set_leds:
    movw    r2, #0x0000
    movt    r2, #0x0800
    
    /* Sets the data to be driven on the I/O line */
    /* PIO_SODR para PIOB en 0x400E1030 */
    movw    r3, #0x1030
    movt    r3, #0x400E
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]
    bx      lr
 
.thumb_func
clear_leds:
    movw    r2, #0x0000
    movt    r2, #0x0800
    
    /* Clears the data to be driven on the I/O line */
    /* PIO_SODR para PIOB en 0x400E1034 */
    movw    r3, #0x1034
    movt    r3, #0x400E
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]
    bx      lr
 
.thumb_func
delay:
    movw    r3, #0xFFFF
    movt    r3, #0x000F
    __delay_loop:
        cbz     r3, __delay_exit
        sub     r3, r3, #1
        b       __delay_loop
    __delay_exit:
        bx      lr
