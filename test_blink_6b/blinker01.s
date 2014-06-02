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
    /* 
    El LED rojo de la placa de desarrollo se encuentra conectado
    al PIN digital 38 de Arduino. Este corresponde al PIN PIOC06.
    */
    mov     r2, #1          // r2 <- 1
    lsl     r2, #6          // r2 << 6 = 0x40.

    /* Dirección base de interfaz del controlador PIOC */
    movt    r3, #0x400E
    movw    r3, #0x1200

    /* Habilito el GPIO PIOC06 */ 
    /* PIO_PER para PIOC en 0x400E1200 */
    str     r2, [r3, #0]

    /* Seteo el GPIO PIOC06 como output */
    /* PIO_OER para PIOC en 0x400E1210 */
    str     r2, [r3, #0x10]

    __loop:
        /* PIO_SODR para PIOC en 0x400E1230 */
        str     r2, [r3, #0x30]
        bl      delay       // Espera activa

        /* PIO_CODR para PIOC en 0x400E1234 */
        str     r2, [r3, #0x34]
        bl      delay       // Espera activa

        b       __loop      // Repetir

    b .
 
 
/* Espera activa */
.thumb_func
delay:
    movt    r4, #0x000F
    movw    r4, #0xFFFF
    __delay_loop:
        cbz     r4, __delay_exit
        sub     r4, r4, #1
        b       __delay_loop
    __delay_exit:
        bx      lr
