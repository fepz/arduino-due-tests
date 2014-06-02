#include "test_blink.h"

#define portPIOC06     ( 1UL << 6UL )
#define portPIOC07     ( 1UL << 7UL )
#define portPIOC08     ( 1UL << 8UL )

// Mediante volatile especifica que usamos el puntero para acceder a
// dispositivos mapeados en la memoria.
#define portPIOC_PER   ( * ( ( volatile int * ) 0x400E1200 ) )
#define portPIOC_OER   ( * ( ( volatile int * ) 0x400E1210 ) )
#define portPIOC_SODR  ( * ( ( volatile int * ) 0x400E1230 ) )
#define portPIOC_CODR  ( * ( ( volatile int * ) 0x400E1234 ) )

// Prototipos
void busy_wait(void);

void my_setup() {
    portPIOC_PER = portPIOC06 | portPIOC07 | portPIOC08;
    portPIOC_OER = portPIOC06 | portPIOC07 | portPIOC08;
}

void my_loop() {
    // Apaga los LEDs
    portPIOC_SODR = portPIOC06 | portPIOC07 | portPIOC08;
    busy_wait();

    // Prende los LEDs
    portPIOC_CODR = portPIOC06 | portPIOC07 | portPIOC08;
    busy_wait();
}

void busy_wait() {
    int i;
    for(i=0;i<0x1FFFFF;i++){
        asm("nop");
    }
}


