.cpu cortex-m3
.thumb

/* Vector table definition */
.word 0x20088000 /* stack top address */
.word _start /* 1 Reset */
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
    /* El LED rojo de la placa de desarrollo se encuentra conectado
        al PIN digital 38 de Arduino. Este corresponde al PIN PC6 de
        el SAM3X */
    mov     r2, #1
    lsl     r2, #6

    movw    r3, #0x1200
    movt    r3, #0x400E

    /* Habilito el GPIO PIOC06 (LED rojo de la placa de deasarrollo) */
    /* PIO_PER para PIOC en 0x400E1200 */
    /* Habilitar PIOC06: 0x00000040 */
    str     r2, [r3, #0]
    
    /* Seteo el GPIO PIOC06 como output */
    /* PIO_OER para PIOC en 0x400E1210 */
    /* Habilitar PIOB27: 0x00000040 */
    str     r2, [r3, #0x10]

    bx      lr
 
.thumb_func
set_leds:
    mov     r2, #1
    lsl     r2, #6
    /* Sets the data to be driven on the I/O line */
    /* PIO_SODR para PIOC en 0x400E1230 */
    movw    r3, #0x1230
    movt    r3, #0x400E
    /* Habilitar PIOC06: 0x00000040 */
    str     r2, [r3, #0]

    bx      lr 
 
.thumb_func
clear_leds:
    mov     r2, #1
    lsl     r2, #6
    /* Clears the data to be driven on the I/O line */
    /* PIO_CODR para PIOC en 0x400E1234 */
    movw    r3, #0x1234
    movt    r3, #0x400E
    /* Habilitar PIOC06: 0x00000040 */
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
