extern void dummy(unsigned int);
extern void put8(unsigned int, unsigned int);
extern unsigned int get8(unsigned int);

void dowait(void) {
    unsigned int ra;
    for (ra = 0x20000; ra; ra--) {
        dummy(ra);
    }
}

void notmain(void) {
    
}

