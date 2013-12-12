#include "setr_logic.h"

int RED_LED = 38;
int GREEN_LED = 40;
int YELLOW_LED = 39;

int pot = 0;

int base_display1 = 31;
int base_display2 = 22;
int offset = 7;

char numbers[10] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111};
char display1_pins[8] = {32, 33, 36, 35, 34, 31, 30, 37};
char display2_pins[8] = {24, 25, 28, 27, 26, 23, 22, 29};

int tasks_periods[] = {1000, 3000, 6000};
xTaskHandle xTasks[3];

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
    for (;;) {
        digitalWrite(RED_LED, HIGH); 
        eat_cpu();
    }
}

/*
 * Tarea periodica
 */
void task2(void* args)
{
    for (;;) {
        digitalWrite(GREEN_LED, HIGH); 
        eat_cpu();
    }
}

/*
 * Tarea periodica
 */
void task3(void* args)
{
    for (;;) {
        digitalWrite(YELLOW_LED, HIGH); 
        eat_cpu();
    }
}

void task_sched(void* args)
{
    const portTickType freq = 100;
    portTickType lastWakeTime;

    xTaskCreate(task1, NULL, configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, &xTasks[0]);
    xTaskCreate(task2, NULL, configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, &xTasks[1]);
    xTaskCreate(task3, NULL, configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, &xTasks[2]);

    vTaskSuspend(xTasks[0]);
    vTaskSuspend(xTasks[1]);
    vTaskSuspend(xTasks[2]);

    lastWakeTime = xTaskGetTickCount();

    int task_to_run = -1;

    for (;;) {
        vTaskSuspend(xTasks[0]);
        vTaskSuspend(xTasks[1]);
        vTaskSuspend(xTasks[2]);

        digitalWrite(RED_LED, LOW); 
        digitalWrite(GREEN_LED, LOW); 
        digitalWrite(YELLOW_LED, LOW); 

        if (task_to_run >= 0) {
            vTaskResume(xTasks[task_to_run]);
        }

        mostrar_numero(task_to_run);
        vTaskDelayUntil(&lastWakeTime, freq);
    }
}

void setup_rts()
{
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

    // Tareas
    xTaskCreate(task_sched, NULL, configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    // Inicia el planificador
    vTaskStartScheduler();

    // No tendriamos que llegar nunca aca
    while(1) {
        ;
    }
}

