#include "setr_logic.h"

int RED_LED = 38;
int GREEN_LED = 40;
int YELLOW_LED = 39;

int pot = 0;

extern volatile long unsigned int ulHighFrequencyTimerTicks = 0L;

int base_display1 = 31;
int base_display2 = 22;
int offset = 7;

char numbers[10] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111};
char display1_pins[8] = {32, 33, 36, 35, 34, 31, 30, 37};
char display2_pins[8] = {24, 25, 28, 27, 26, 23, 22, 29};

void handler()
{
    ulHighFrequencyTimerTicks += 1L;
}

void vTaskGetRunTimeStats()
{
    xTaskStatusType *pxTaskStatusArray;
    volatile unsigned portBASE_TYPE uxArraySize, x;
    unsigned long ulTotalRuntime, ulStatsAsPercentage;

    uxArraySize = uxTaskGetNumberOfTasks();
    pxTaskStatusArray = (xTaskStatusType*) pvPortMalloc(uxArraySize * sizeof(xTaskStatusType));

    uxArraySize = uxTaskGetSystemState(pxTaskStatusArray, uxArraySize, &ulTotalRuntime);

    Serial.println("Tarea 1");
    Serial.println(pxTaskStatusArray[0].ulRunTimeCounter, DEC);
    Serial.println("Tarea 2");
    Serial.println(pxTaskStatusArray[1].ulRunTimeCounter, DEC);
    Serial.println("Tarea 3");
    Serial.println(pxTaskStatusArray[2].ulRunTimeCounter, DEC);

    vPortFree(pxTaskStatusArray);
}

void eat_cpu()
{
    int i;
    for (i = 0; i < 0xFFFFF; i++) {
        asm("nop");
    }
}

void mostrar_numero(int n) {
    int firstDigit = 0;
    int secondDigit = 0;

    if (n > 9) {
        firstDigit = n / 10;
        secondDigit = n - (firstDigit * 10);
    } else {
        firstDigit = 0;
        secondDigit = n;
    }

    for (int i = 0; i < 7; i++) {
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

/*
 * Tarea periodica
 */
void task1(void* args)
{
    const portTickType freq = 3000;
    portTickType lastWakeTime;
        
    lastWakeTime = xTaskGetTickCount();

    for(;;) {
        vTaskDelayUntil(&lastWakeTime, freq);
        digitalWrite(RED_LED, HIGH); 
        eat_cpu();
        digitalWrite(RED_LED, LOW); 
    }
}

/*
 * Tarea periodica
 */
void task2(void* args)
{
    const portTickType freq = 4000;
    portTickType lastWakeTime;
        
    lastWakeTime = xTaskGetTickCount();

    for(;;) {
        vTaskDelayUntil(&lastWakeTime, freq);
        digitalWrite(GREEN_LED, HIGH); 
        eat_cpu();
        digitalWrite(GREEN_LED, LOW); 
    }
}

/*
 * Tarea periodica
 */
void task3(void* args)
{
    const portTickType freq = 6000;
    portTickType lastWakeTime;
        
    lastWakeTime = xTaskGetTickCount();

    for(;;) {
        vTaskDelayUntil(&lastWakeTime, freq);
        digitalWrite(YELLOW_LED, HIGH); 
        int value = analogRead(pot);
        mostrar_numero((double) (value / 10.24));
        eat_cpu();
        vTaskGetRunTimeStats();
        digitalWrite(YELLOW_LED, LOW); 
    }
}


void setup_rts()
{
    Serial.begin(9600);

    for (int i = 0; i <= offset; i++) {
        pinMode(display1_pins[i], OUTPUT);
        pinMode(display2_pins[i], OUTPUT);
        digitalWrite(display1_pins[i], HIGH);
        digitalWrite(display2_pins[i], HIGH);
    }

    pinMode(RED_LED, OUTPUT);
    pinMode(YELLOW_LED, OUTPUT);
    pinMode(GREEN_LED, OUTPUT);

    // los LEDs comienzan apagados
    digitalWrite(RED_LED, LOW); 
    digitalWrite(YELLOW_LED, LOW); 
    digitalWrite(GREEN_LED, LOW); 

    // Crea la tarea periodica
    xTaskCreate(task1, NULL, configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    xTaskCreate(task2, NULL, configMINIMAL_STACK_SIZE, NULL, 2, NULL);
    xTaskCreate(task3, NULL, configMINIMAL_STACK_SIZE, NULL, 3, NULL);

    // Timer -- frecuencia: 10^6 Hz
    Timer1.attachInterrupt(handler);
    Timer1.setFrequency(10000);
    Timer1.start();
    
    // Inicia el planificador
    vTaskStartScheduler();

    // No tendriamos que llegar nunca aca
    while(1) {
        ;
    }
}

