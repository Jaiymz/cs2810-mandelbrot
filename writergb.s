                .global writeRGB

		.equ color_magic, 255

                .text
@ writeRGB(buffer, rgb) -> number of bytes written
writeRGB:	
		push            {r4, r6, r7, r9, lr}
                @r0:    buffer
                @r1:    rgb

                @r4:    buffer
                @r7:    rgb

                mov     r6, #0                          @set r6 to zero
                mov     r4, r0                          @move buffer to r4
                mov     r7, r1                          @move color to r7
                ldr     r9, =color_magic                @load magic color to r9

1:
                @split the rgb into the three colors.
                @red
                mov     r1, r9                          @move magic color to r1
                and     r1, r1, r7, lsr #16             @and r1 with r7(color) and lsr 16 itimes
                                                        @red is now in r1
                add     r0, r4, r6
                bl      itoa
                add     r6, r6, r0

                @add space to buffer
                ldr     r3, =' '
                strb    r3, [r4, r6]
                add     r6, r6, #1

                @green
                mov     r1, r9                          @move magic color to r1
                and     r1, r1, r7, lsr #8              @and r1 with r7(color) and lsr 8 times to get the green

                add     r0, r4, r6
                bl      itoa
                add     r6, r6, r0

                @add space to buffer
		ldr     r3, =' '
                strb    r3, [r4, r6]
                add     r6, r6, #1

                @blue
                mov     r1, r9
                and     r1, r1, r7

                add     r0, r4, r6
                bl      itoa
                add     r6, r6, r0

                @return length of the buffer.
                mov     r0, r6
                pop     {r4, r6, r7, r9, pc}

