#include <stdio.h>
#include "setr_logic.h"

#define READY 1
#define RUNNING 2

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

portTickType tasks_periods[] = {3000 / portTICK_RATE_MS, 4000 / portTICK_RATE_MS, 6000 / portTICK_RATE_MS};
xTaskHandle xTasks[3];
xSemaphoreHandle mutex;

void eat_cpu(int ms)
{
    portTickType tick_end = xTaskGetTickCount() + (ms / portTICK_RATE_MS);
    int i;
    while (1) {
        if (xTaskGetTickCount() >= tick_end) {
            break;
        }
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

void workload(int task_id, int ms, int led) {
    //xSemaphoreTake(mutex, portMAX_DELAY);
    digitalWrite(led, HIGH); 
    eat_cpu(ms);
    digitalWrite(led, LOW); 
    //xSemaphoreGive(mutex);
}

/*
 * Tarea periodica
 */
void task1(void* args)
{
    for (;;) {
        workload(1, 500, RED_LED);
        vTaskSuspend(NULL);
    }
}

/*
 * Tarea periodica
 */
void task2(void* args)
{
    for (;;) {
        workload(2, 500, YELLOW_LED);
        vTaskSuspend(NULL);
    }
}

/*
 * Tarea periodica
 */
void task3(void* args)
{
    for (;;) {
        workload(3, 1000, GREEN_LED);
        vTaskSuspend(NULL);
    }
}

void task_sched(void* args)
{
    const portTickType freq = 1 / portTICK_RATE_MS;
    portTickType lastWakeTime;
    portTickType nextActivation[3] = {0, 0, 0};
    int task_state[3] = {READY, READY, READY};

    xTaskCreate(task1, NULL, configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, &xTasks[0]);
    xTaskCreate(task2, NULL, configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, &xTasks[1]);
    xTaskCreate(task3, NULL, configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY, &xTasks[2]);

    vTaskSuspend(xTasks[0]);
    vTaskSuspend(xTasks[1]);
    vTaskSuspend(xTasks[2]);

    lastWakeTime = xTaskGetTickCount();

    int task_to_run = 0;

    for (;;) {
        if (lastWakeTime >= nextActivation[0]) {
            if (eTaskGetState(xTasks[0]) == eSuspended || eTaskGetState(xTasks[0]) == eBlocked) {
                task_to_run = 1;
                nextActivation[0] = nextActivation[0] + tasks_periods[0];
                vTaskResume(xTasks[0]);
            }
        } else if (lastWakeTime >= nextActivation[1]) {
            if (eTaskGetState(xTasks[1]) == eSuspended) {
                task_to_run = 2;
                nextActivation[1] = nextActivation[1] + tasks_periods[1];
                vTaskResume(xTasks[1]);
            }
        } else if (lastWakeTime >= nextActivation[2]) {
            if (eTaskGetState(xTasks[2]) == eSuspended) {
                task_to_run = 3;
                nextActivation[2] = nextActivation[2] + tasks_periods[2];
                vTaskResume(xTasks[2]);
            }
        } else {
            task_to_run = 0;
        }

        mostrar_numero(task_to_run);
        vTaskDelayUntil(&lastWakeTime, freq);
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

    mutex = xSemaphoreCreateMutex();

    // Tareas
    xTaskCreate(task_sched, NULL, configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    // Inicia el planificador
    vTaskStartScheduler();

    // No tendriamos que llegar nunca aca
    while(1) {
        ;
    }
}

