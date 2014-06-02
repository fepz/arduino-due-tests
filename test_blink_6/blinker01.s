.cpu cortex-m3
.thumb

/* Vector de interrupciones */
.word 0x20088000    /* Dirección base de la pila */
.word _start        /* 1 Entry point */
.word hang          /* 2 NMI */
.word hang          /* 3 HardFault */
.word hang          /* 4 MemManage */
.word hang          /* 5 BusFault */
.word hang          /* 6 UsageFault */
.word hang          /* 7 reservado */
.word hang          /* 8 reservado */
.word hang          /* 9 reservado */
.word hang          /* 10 RESERVED */
.word hang          /* 11 SVCall */
.word hang          /* 12 Debug Monitor */
.word hang          /* 13 reservado */
.word hang          /* 14 PendSV */
.word hang          /* 15 SysTick */

/* Ciclo infinito */
.thumb_func
hang:
    b .

/* Funcion principal */
.thumb_func
.global main
_start:
    /* El LED rojo de la placa de desarrollo se encuentra conectado
        al PIN digital 38 de Arduino. Este corresponde al PIN PC6 de
        el SAM3X */
    mov     r2, #1
    lsl     r2, #6

    movw    r3, #0x1200
    movt    r3, #0x400E

    bl      set_gpio_dir    // Configura los PINs a utilizar

    __loop:
        bl      clear_leds  // Apaga los LEDs
        bl      delay       // Espera activa
        bl      set_leds    // Prende los LEDs
        bl      delay       // Espera activa
        b       __loop      // Repetir

    b .
 
/* Configura los PINs de salida a utilizar */
.thumb_func
set_gpio_dir:
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
    /* Sets the data to be driven on the I/O line */
    /* PIO_SODR para PIOC en 0x400E1230 */
    /* Habilitar PIOC06: 0x00000040 */
    str     r2, [r3, #0x30]
    bx      lr 
 
.thumb_func
clear_leds:
    /* Clears the data to be driven on the I/O line */
    /* PIO_CODR para PIOC en 0x400E1234 */
    /* Habilitar PIOC06: 0x00000040 */
    str     r2, [r3, #0x34]
    bx      lr 
 
.thumb_func
delay:
    movw    r4, #0xFFFF
    movt    r4, #0x000F
    __delay_loop:
        cbz     r4, __delay_exit
        sub     r4, r4, #1
        b       __delay_loop
    __delay_exit:
        bx      lr
