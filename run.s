                .global run

                .equ    flags, 577
                .equ    mode, 0644

                .equ    sys_write, 4
                .equ    sys_open, 5
                .equ    sys_close, 6

                .equ    fail_open, 1
                .equ    fail_writeheader, 2
                .equ    fail_writerow, 3
                .equ    fail_close, 4

                .text

@ run() -> exit code
run:

@ your code goes here

		push            {r4, r5, r6, r7, r8, lr}


1:              @open file
                ldr     r0, =filename            @fd = open(filename, flags, mode)
                ldr     r1, =flags
                ldr     r2, =mode
                mov     r7, #sys_open
                svc     #0
                cmp     r0, #0                  @if fd < 0: return fail_open
                mov     r4, r0
                bgt     2f                      @go to next step if value is greater than 0
                mov     r5, #fail_open          @load fail open to a register
                mov     r0, r5                  @return fail open
                pop     {r4, r5, r6, r7, r8, pc}

2:              @write the header
                ldr     r0, =buffer
                ldr     r1, =xsize
                ldr     r2, =ysize
                ldr     r1, [r1]
                ldr     r2, [r2]
                bl      writeHeader             @length = writeHeader(buffer, xsize, ysize)
                mov     r2, r0
                ldr     r1, =buffer
                mov     r0, r4
                mov     r7, #sys_write
                svc     #0                      @status = write(fd, buffer, length)
                cmp     r0, #0                  @if status < 0: return fail_writeheader
                bgt     3f
                mov     r5, #fail_writeheader
                mov     r0, r5
		pop     {r4, r5, r6, r7, r8, pc}

3:              @close the file
                mov     r0, r4
                mov     r7, #sys_close                  @status = close(fd)
                svc     #0
                cmp     r0, #0                          @if status < 0: return fail_close
                bge     4f                              @return 0
                mov     r5, #fail_close
                mov     r0, r5
                pop     {r4, r5, r6, r7, r8, pc}

4:
                mov     r0, #0
                pop     {r4, r5, r6, r7, r8, pc}

         	.bss
buffer:         .space 64*1024
