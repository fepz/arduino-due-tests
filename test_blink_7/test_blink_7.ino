// 
#define portPIOC06     ( 1UL << 6UL )
#define portPIOC07     ( 1UL << 7UL )
#define portPIOC08     ( 1UL << 8UL )

// Mediante volatile podemos especificar que usamos el puntero para acceder a 
// dispositivos mapeados en la memoria.
#define portPIOC_PER   ( * ( ( volatile uint32_t * ) 0x400E1200 ) )
#define portPIOC_OER   ( * ( ( volatile uint32_t * ) 0x400E1210 ) )
#define portPIOC_SODR  ( * ( ( volatile uint32_t * ) 0x400E1230 ) )
#define portPIOC_CODR  ( * ( ( volatile uint32_t * ) 0x400E1234 ) )

void setup() {  
  portPIOC_PER = portPIOC06 | portPIOC07 | portPIOC08;
  portPIOC_OER = portPIOC06 | portPIOC07 | portPIOC08;
}

void loop() {
  // put your main code here, to run repeatedly:
  portPIOC_SODR = portPIOC06 | portPIOC07 | portPIOC08;
  for(int i=0;i<0x1FFFFF;i++){
    asm("nop");
  }
 
  portPIOC_CODR = portPIOC06 | portPIOC07 | portPIOC08;
  for(int i=0;i<0x1FFFFF;i++){
    asm("nop");
  }

}
