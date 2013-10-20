#include <FreeRTOS_ARM.h>

// --- Definicion de una tarea de TR ---
struct task_t {
  uint16_t id;
  uint16_t c;
  uint16_t t;
};

// --- Definicion del STR ---
// STR = {(1,3,3),(1,4,4),(1,6,6)}
task_t str[] = {{1,1000,3000}, {2,1000,4000}, {3,1000,6000}};

int base = 22;
int offset = 7;
char numbers[11] = { 63, 6, 91, 79, 102, 109, 125, 39, 127, 103, 121 };

portTickType initWakeTime;

// --- ???? ---
const unsigned int CAL_GUESS = 17000;
const float TICK_USEC = 1000;

// --- Funciones para simular proceso de la CPU ---
static unsigned  int cal = CAL_GUESS;

void burn_cpu(uint16_t ticks) {
    while (ticks--) {
        for (unsigned int i = 0; i < cal; i++) {
            asm("nop");
        }
    }
}

void calibrate() {
    uint32_t t = micros();
    burn_cpu(1000);
    t = micros() - t;
    cal = (TICK_USEC * 1000 * cal) / t;
}

// --- Codigo que ejecuta cada tarea ---
void task(void* arg) {
    int id = (int) ((task_t*)arg)->id;
    uint16_t t = ((task_t*)arg)->t;
    uint16_t c = ((task_t*)arg)->c;

    portTickType lastWakeTime = initWakeTime;
    while(1) {
        //vTaskDelayUntil(&lastWakeTime, t);
        set_display(id);
        burn_cpu(c);
        //delay(1000);
        //reset_display();
        set_display(10);
        vTaskDelayUntil(&lastWakeTime, t);
    }
}

void setup() {
    for (int i = 0; i < offset; i++) {
        pinMode(base + i, OUTPUT);
    }
    portBASE_TYPE s;
    calibrate();
    initWakeTime = xTaskGetTickCount();
    for (int i = 0; i < 3; i++) {
        s = xTaskCreate(task, NULL, 200, (void*)&str[i], tskIDLE_PRIORITY + (4-str[i].id), NULL);
    }
    vTaskStartScheduler();
    while(1);
}

void loop() {
  // put your main code here, to run repeatedly: 
  
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

void reset_display() {
    for (int i = 0; i < 7; i++) {
        digitalWrite(base + i, HIGH);
    }
}
