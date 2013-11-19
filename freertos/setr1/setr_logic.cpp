#include "setr_logic.h"
#include "display.h"

int RED_LED = 38;
int GREEN_LED = 40;
int YELLOW_LED = 39;

int pot = 0;

void eat_cpu()
{
    int i;
    for (i = 0; i < 0xFFFFF; i++) {
        asm("nop");
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
        int value = analogRead(pot) / 10.24;
        display_number(value);
    }
}


void setup_rts()
{
    init_display();

    pinMode(RED_LED, OUTPUT);
    pinMode(GREEN_LED, OUTPUT);
    pinMode(YELLOW_LED, OUTPUT);

    // los LEDs comienzan apagados
    digitalWrite(RED_LED, LOW); 
    digitalWrite(GREEN_LED, LOW); 
    digitalWrite(YELLOW_LED, LOW); 

    // Crea la tarea periodica
    xTaskCreate(task1, NULL, configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    xTaskCreate(task2, NULL, configMINIMAL_STACK_SIZE, NULL, 2, NULL);
    xTaskCreate(task3, NULL, configMINIMAL_STACK_SIZE, NULL, 3, NULL);

    // Inicia el planificador
    vTaskStartScheduler();

    // No tendriamos que llegar nunca aca
    while(1) {
        ;
    }
}

