#include <FreeRTOS_ARM.h>

#define BASE_PIN_DISPLAY_1 31
#define BASE_PIN_DISPLAY_2 22
#define DISPLAY_SEGS 7

void display_number(int number);
void init_display(void);
