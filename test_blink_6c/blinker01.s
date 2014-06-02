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
    El primero punto del display de la placa de desarrollo se encuentra conectado
    al PIN digital 29 de Arduino. Este corresponde al PIN PIOD06.
    */
    mov     r2, #1          // r2 <- 1
    lsl     r2, #6          // r2 << 6 = 0x40.

    /* Dirección base de interfaz del controlador PIOD: 0x400E1400 */
    movw    r3, #0x1400
    movt    r3, #0x400E

    /* PIO_PER para PIOD en 0x400E1400 */
    str     r2, [r3, #0]

    /* PIO_OER para PIOD en 0x400E1410 */
    str     r2, [r3, #0x10]

    __loop:
        /* PIO_SODR para PIOD en 0x400E1430 */
        str     r2, [r3, #0x30]
        bl      delay       // Espera activa

        /* PIO_CODR para PIOD en 0x400E1434 */
        str     r2, [r3, #0x34]
        bl      delay       // Espera activa

        b       __loop      // Repetir

    b .
 
 
/* Espera activa */
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
