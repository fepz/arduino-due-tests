
.cpu cortex-m3
.thumb

.thumb_func
.globl PUT8
PUT8:
    strb r1,[r0]
    bx lr

.thumb_func
.globl GET8
GET8:
    ldrb r0,[r0]
    bx lr

.thumb_func
.globl dummy
dummy:
    bx lr

