int base = 22;
int offset = 7;

char numbers[10] = { 63, 6, 91, 79, 102, 109, 125, 39, 127, 103 };

void setup() {
  for (int i = 0; i < offset; i++) {
    pinMode(base + i, OUTPUT);
  }
}

void loop() {  
  for (int i = 0; i <= 9; i++) {
    set_display(i);
    delay(1000);
  }
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
