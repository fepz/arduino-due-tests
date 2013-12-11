#include "setr_logic.h"

int RED_LED = 38;
int on = 1;

void handler()
{
    if (on == 1) {
        digitalWrite(RED_LED, LOW);
        on = 0;
    } else {
        digitalWrite(RED_LED, HIGH);
        on = 1;
    }
}


void setup_rts()
{
    pinMode(RED_LED, OUTPUT);
    digitalWrite(RED_LED, HIGH); 
    Timer3.attachInterrupt(handler).start(100000);
}

void loop_rts()
{
}

