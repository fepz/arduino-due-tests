#include <math.h>

// --- Definicion de una tarea de TR ---
struct task_t {
  int id;
  int c;
  int t;
  int d;
  int wcrt;
};

task_t str[10];

int num_task = 0;
unsigned long t_start, t_end;

boolean schedulable;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  handshake();
  
  // Numero de tareas
  if (Serial.available() > 0) {
    num_task = Serial.parseInt();
    //Serial.println(num_task);
    
    for (int i = 0; i < 10; i++) {
      str[i].id = i + 1;
      str[i].c = Serial.parseInt();
      str[i].t = Serial.parseInt();
      str[i].d = Serial.parseInt();
      str[i].wcrt = 0;
    }
    
    Serial.println("Hola!");
    
    /*
    Serial.println("rta2");
    t_start = micros();
    rta2_wcrt();
    t_end = micros();    
    if (schedulable) {
      Serial.println("True");
    } else {
      Serial.println("False");
    }    
    for (int i = 0; i < num_task; i++) {
      Serial.println(str[i].wcrt, DEC);
    }    
    Serial.println(t_end - t_start);

    Serial.println("rta3");    
    t_start = micros();
    rta3_wcrt();
    t_end = micros();    
    if (schedulable) {
      Serial.println("True");
    } else {
      Serial.println("False");
    }    
    for (int i = 0; i < num_task; i++) {
      Serial.println(str[i].wcrt, DEC);
    }    
    Serial.println(t_end - t_start);

    Serial.println("sjodin");
    t_start = micros();
    sjodin_wcrt();
    t_end = micros();    
    if (schedulable) {
      Serial.println("True");
    } else {
      Serial.println("False");
    }
    for (int i = 0; i < num_task; i++) {
      Serial.println(str[i].wcrt, DEC);
    }    
    Serial.println(t_end - t_start);
    */
  }    
}

void handshake() {
  while (Serial.available() <= 0) {
    Serial.write('A');
    delay(300);
  }
}

void rta3_wcrt() {
  int aes[num_task];
  int bes[num_task];
  int tr;
  int w;
  int j;
  int min_b;
  
  for (int i = 0; i < num_task; i++) {
    aes[i] = 0;
    bes[i] = 0;
  }
  
  schedulable = true;
  
  int t = str[0].c;
  str[0].wcrt = str[0].c;
  
  for (int i = 1; i < num_task; i++) {
    t = t + str[i].c;
    tr = t;
    
    aes[i] = str[i].c;
    bes[i] = str[i].t;
    
    while (true) {
      w = 0;
      j = i - 1;
      
      min_b = str[i].t;
      
      while (j >= 0) {
        if (bes[j] < min_b) {
          min_b = bes[j];
        }
        
        // no calculamos el termino A si no salta
        if (tr <= bes[j]) {
          w = w + aes[j];
          j = j - 1;
          continue;
        }
        
        // calculamos A
        int c_j = str[j].c;
        int t_j = str[j].t;        
        int a_t = (int)ceil( ((double)tr) / ((double)t_j) );
        int a = a_t * c_j;
        
        // ya sabemos que A salta, computamos la diferencia
        tr = tr + a - aes[j];
        if (tr > str[i].d) {
          schedulable = false;
          return;
        }
        
        aes[j] = a;
        bes[j] = a_t * str[j].t;
        
        if (bes[j] < min_b) {
          min_b = bes[j];
        }
        
        // vuelve para atras si el nuevo t es mayor que el
        // limite de salto del termino a previo
        if ((j < i) && (tr > bes[j + 1])) {
          j = j + 1;
          w = w - aes[j];
          continue;
        }
        
        w = w + a;
        j = j - 1;
      }
      
      w = w + str[i].c;
      
      if (t == w) {
        aes[i] = str[i].c;
        bes[i] = str[i].t;
        break;
      }
      
      if (tr > w) {
        t = tr;
      } else {
        t = w;
      }
      
      if (t <= min_b) {
        aes[i] = str[i].c;
        bes[i] = str[i].t;
        break;
      }
      
      tr = t;
    }
    
    str[i].wcrt = t;
  }
}   

void rta2_wcrt() {
  int aes[num_task];
  int tr = 0;
  int w = 0;
  
  for (int i = 0; i < num_task; i++) {
    aes[i] = 0;
  }  
  
  schedulable = true;
  
  int t = str[0].c;
  str[0].wcrt = str[0].c;
  
  for (int i = 1; i < num_task; i++) {
    t = t + str[i].c;
    tr = t;
    
    while (true) {
      w = 0;
      
      for (int j = 0; j < i; j++) {
        int c_j = str[j].c;
        int t_j = str[j].t;        
        int a = (int)ceil( ((double)tr) / ((double)t_j) );
        a = a * c_j;
        if (aes[j] > 0) {
          tr = tr + a - aes[j];
        }
        if (tr > str[i].d) {
          t = tr;
          schedulable = false;
          return;
        }
        aes[j] = a;
        w = w + a;
      }
      
      w = w + str[i].c;
      
      if (t == w) {
        aes[i] = str[i].c;
        break;
      }
      
      if (tr > w) {
        t = tr;
      } else {
        t = w;
      }
      
      tr = t;
    }
    
    str[i].wcrt = t;
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
      break;
    }
    
    str[i].wcrt = r;     
  }  
}
