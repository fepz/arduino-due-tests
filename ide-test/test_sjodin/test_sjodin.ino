#include <math.h>

// --- Definicion de una tarea de TR ---
struct task_t {
  int id;
  int c;
  int t;
  int d;
  int wcrt;
};

task_t str[] = {{1,1,132,132,0}, 
                {2,1,139,139,0}, 
                {3,1,145,145,0},
                {4,1,194,194,0},
                {5,3,320,320,0},
                {6,1,521,521,0},
                {7,7,639,639,0},
                {8,10,730,730,0},
                {9,13,851,851,0},
                {10,24,910,910,0}
            };
int num_task = 0;

boolean schedulable;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while (!Serial)
    ;
}

void loop() {
  while (Serial.available() <= 0)
    ;
  
  // Numero de tareas
  if (Serial.available() > 0) {
    num_task = Serial.parseInt();
  }
  
  Serial.print("Nro. tareas: ");
  Serial.println(num_task, DEC);
  
  for (int i = 0; i < num_task; i++) {
    str[i].id = i + 1;
    while (Serial.available() <= 0)
      ;
    str[i].c = Serial.parseInt();
    while (Serial.available() <= 0)
      ;
    str[i].t = Serial.parseInt();
    while (Serial.available() <= 0)
      ;
    str[i].d = Serial.parseInt();
    str[i].wcrt = 0;
    Serial.println("Tarea 1: ");
    Serial.println(str[i].c, DEC);
    Serial.println(str[i].t, DEC);
    Serial.println(str[i].d, DEC);    
  }
  
  Serial.println("Calculando por Sjodin...");
  sjodin_wcrt();
  
  if (schedulable) {
    Serial.println("Planificable!");
  } else {
    Serial.println("No planificable!");
  }
  
  for (int i = 0; i < num_task; i++) {
    Serial.print("Tarea ");
    Serial.print(i, DEC);
    Serial.print(": ");
    Serial.println(str[i].wcrt, DEC);
  }
}

void sjodin_wcrt() {
  int r = 0;
  
  schedulable = true;
  
  for (int i = 0; i < num_task; i++) {
    int c = str[i].c;
    int t = str[i].t;
    int d = str[i].d;
    
    r = r + c;
    
    while (true) {
      int w = 0;
      
      for (int j = 0; j < i; j++) {
        int c_j = str[j].c;
        int t_j = str[j].t;        
        int a = (int)ceil( ((double)r) / ((double)t_j) );        
        w = w + (a * c_j);
      }
      
      w = w + c;
      
      if (r == w) {
        break;
      }
      
      r = w;
      
      if (r > d) {
        schedulable = false;
        break;    
      }        
    }
    
    if (!schedulable) {
      //break;
    }
    
    str[i].wcrt = r;     
  }  
}
