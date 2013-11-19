#include "display.h"

char numbers[10] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111};
char display1_pins[8] = {32, 33, 36, 35, 34, 31, 30, 37};
char display2_pins[8] = {24, 25, 28, 27, 26, 23, 22, 29};

void display_number(int number) 
{
    int firstDigit = 0;
    int secondDigit = 0;

    if (number > 9) {
        firstDigit = number / 10;
        secondDigit = number - (firstDigit * 10);
    } else {
        firstDigit = 0;
        secondDigit = number;
    }

    for (int i = 0; i < DISPLAY_SEGS; i++) {
        // escribir primer digito
        int bit = bitRead(numbers[firstDigit], i);
        if (bit == 0) {
            digitalWrite(display2_pins[i], HIGH);
        } else {
            digitalWrite(display2_pins[i], LOW);
        }
        // escribir segundo digito
        bit = bitRead(numbers[secondDigit], i);
        if (bit == 0) {
            digitalWrite(display1_pins[i], HIGH);
        } else {
            digitalWrite(display1_pins[i], LOW);
        }
    }
}

void init_display()
{
    for (int i = 0; i <= DISPLAY_SEGS; i++) {
        pinMode(display1_pins[i], OUTPUT);
        pinMode(display2_pins[i], OUTPUT);
        digitalWrite(display1_pins[i], HIGH);
        digitalWrite(display2_pins[i], HIGH);
    }
}

