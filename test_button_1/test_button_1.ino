// 
#define portPIOC06     ( 1UL << 6UL )
#define portPIOC07     ( 1UL << 7UL )
#define portPIOC08     ( 1UL << 8UL )

// boton rojo
#define portPIOA19     ( 1UL << 19UL )

// Mediante volatile podemos especificar que usamos el puntero para acceder a 
// dispositivos mapeados en la memoria.
#define portPIOC_PER   ( * ( ( volatile uint32_t * ) 0x400E1200 ) )
#define portPIOC_OER   ( * ( ( volatile uint32_t * ) 0x400E1210 ) )
#define portPIOC_SODR  ( * ( ( volatile uint32_t * ) 0x400E1230 ) )
#define portPIOC_CODR  ( * ( ( volatile uint32_t * ) 0x400E1234 ) )
#define portPIOC_ODSR  ( * ( ( volatile uint32_t * ) 0x400E1238 ) )

#define portPIOA_PER   ( * ( ( volatile uint32_t * ) 0x400E0E00 ) )
#define portPIOA_IFER  ( * ( ( volatile uint32_t * ) 0x400E0E20 ) )
#define portPIOA_PDSR  ( * ( ( volatile uint32_t * ) 0x400E0E3C ) )
#define portPIOA_DIFSR ( * ( ( volatile uint32_t * ) 0x400E0E84 ) )

#define portPMC_PCER0  ( * ( ( volatile uint32_t * ) 0x400E0610 ) )
#define portPMC_PCSR0  ( * ( ( volatile uint32_t * ) 0x400E0618 ) )

void setup() {  
  portPIOC_PER = portPIOC06 | portPIOC07 | portPIOC08;
  portPIOC_OER = portPIOC06 | portPIOC07 | portPIOC08;
  
  portPIOA_PER = portPIOA19;
  portPIOA_IFER = portPIOA19;
  portPIOA_DIFSR = portPIOA19;
  
  portPMC_PCER0 = ( 1UL << 11UL );
  
  Serial.begin(9600);
}

void loop() {
  if (portPIOA_PDSR & ( 1UL << 11UL )) {
    portPIOC_SODR = portPIOC06 | portPIOC07 | portPIOC08;    
  } else {
    portPIOC_CODR = portPIOC06 | portPIOC07 | portPIOC08;
  }
  /*
  delay(1000);
  Serial.println(portPIOA_PDSR, DEC);
  Serial.println(portPIOC_ODSR, DEC);
  Serial.println(portPMC_PCSR0, DEC);
  Serial.println(portPIOA_PDSR & ( 1UL << 11UL ), DEC);
  */
}
