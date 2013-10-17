int base = 22;
int offset = 7;
char numero = 0;

char numbers[10] = { 63, 6, 91, 79, 102, 109, 125, 39, 127, 103 };

void setup() {
  for (int i = 0; i < offset; i++) {
    pinMode(base + i, OUTPUT);
  }
  pinMode(29, INPUT);
  attachInterrupt(29, cambiar_numero, RISING);
  set_display(numero);
}

void loop() {  
  /*
  for (int i = 0; i <= 9; i++) {
    set_display(i);
    delay(1000);
  }
  */
}

void cambiar_numero() {
  detachInterrupt(29);
  numero = numero + 1;
  if (numero > 9) {
    numero = 0;
  }
  set_display(numero);
  
  for (unsigned long i = 20000000; i > 0; i--)
    asm("");

  attachInterrupt(29, cambiar_numero, RISING);
}

void set_display(int n) {
  for (int i = 0; i < 7; i++) {
    int bit = bitRead(numbers[n], i);
    if (bit == 0) {
      digitalWrite(base + i, HIGH);
    } else {
      digitalWrite(base + i, LOW);
    }
  }
}
