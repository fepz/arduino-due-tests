.cpu cortex-m3
.thumb

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
    mov     r2, #1
    lsl     r2, #27

    movw    r3, #0x1000
    movt    r3, #0x400E

    /* Habilito el GPIO PIOB27 (pin13 del ArduinoDue) */
    /* PIO_PER para PIOB en 0x400E1000 */
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]
    /* Seteo el GPIO PIOB27 como output */
    /* PIO_OER para PIOB en 0x400E1010 */
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0x10]

    mov     r2, #1
    lsl     r2, #30

    movw    r3, #0x1200
    movt    r3, #0x400E

    /* Habilito el GPIO PIOB27 (pin13 del ArduinoDue) */
    /* PIO_PER para PIOB en 0x400E1000 */
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]
    /* Seteo el GPIO PIOB27 como output */
    /* PIO_OER para PIOB en 0x400E1010 */
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0x10]

    mov     r2, #1
    lsl     r2, #21

    movw    r3, #0x0E00
    movt    r3, #0x400E

    /* Habilito el GPIO PIOA21 (led TX del ArduinoDue) */
    /* PIO_PER para PIOA en 0x400E0E00 */
    /* Habilitar PIOA21: 0x08000000 */
    str     r2, [r3, #0]
    /* Seteo el GPIO PIOA21 como output */
    /* PIO_OER para PIOA en 0x400E0E10 */
    /* Habilitar PIOA21: 0x08000000 */
    str     r2, [r3, #0x10]
    bx      lr
 
.thumb_func
set_leds:
    mov     r2, #1
    lsl     r2, #27
    /* Sets the data to be driven on the I/O line */
    /* PIO_SODR para PIOB en 0x400E1030 */
    movw    r3, #0x1030
    movt    r3, #0x400E
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]

    mov     r2, #1
    lsl     r2, #30
    /* Sets the data to be driven on the I/O line */
    /* PIO_SODR para PIOC en 0x400E1230 */
    movw    r3, #0x1230
    movt    r3, #0x400E
    /* Habilitar PIOB30: 0x08000000 */
    str     r2, [r3, #0]

    mov     r2, #1
    lsl     r2, #21
    /* Sets the data to be driven on the I/O line */
    /* PIO_SODR para PIOA en 0x400E0E30 */
    movw    r3, #0x0E30
    movt    r3, #0x400E
    /* Habilitar PIOB30: 0x08000000 */
    str     r2, [r3, #0]

    bx      lr 
 
.thumb_func
clear_leds:
    mov     r2, #1
    lsl     r2, #27
    /* Clears the data to be driven on the I/O line */
    /* PIO_CODR para PIOB en 0x400E1034 */
    movw    r3, #0x1034
    movt    r3, #0x400E
    /* Habilitar PIOB27: 0x08000000 */
    str     r2, [r3, #0]

    mov     r2, #1
    lsl     r2, #30
    /* Clears the data to be driven on the I/O line */
    /* PIO_CODR para PIOC en 0x400E1234 */
    movw    r3, #0x1234
    movt    r3, #0x400E
    /* Habilitar PIOC30: 0x08000000 */
    str     r2, [r3, #0]

    mov     r2, #1
    lsl     r2, #21
    /* Clears the data to be driven on the I/O line */
    /* PIO_CODR para PIOA en 0x400E0E34 */
    movw    r3, #0x0E34
    movt    r3, #0x400E
    /* Habilitar PIOA21: 0x08000000 */
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
