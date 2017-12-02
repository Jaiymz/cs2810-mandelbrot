                .global writeHeader
		
		.equ color_magic, 255

                .text
@ writeHeader(buffer, x, y) -> number of bytes written
writeHeader:
		push		{r4, r5, r6, r7, lr}
		@r0:	buffer
		@r1:	xsize
		@r2:	ysize

		@r4:	buffer
		@r5:	ysize
		@r6:	buffer length = 0
		mov	r6, #0
		mov	r4, r0
		mov	r5, r2
		ldr	r7, =color_magic
1:
		@write header into buffer and count bytes
		ldr	r3, ='P'
		strb	r3, [r4, r6]		@store value to buffer at length
		add	r6, r6, #1

		ldr	r3, ='3'
		strb	r3, [r4, r6]
		add	r6, r6, #1
		
		ldr	r3, ='\n'
		strb	r3, [r4, r6]
		add	r6, r6, #1
		
		add	r0, r4, r6
		bl 	itoa
		add	r6, r6, r0
		
		ldr	r3, =' '
		strb	r3, [r4, r6]
		add	r6, r6, #1
	
		mov	r1, r5
		add	r0, r4, r6	
		bl	itoa
		add	r6, r6, r0		

		ldr	r3, ='\n'
		strb	r3, [r4, r6]
		add	r6, r6, #1

		mov	r1, r7
		add	r0, r4, r6
		bl	itoa
		add	r6, r6, r0
		
		ldr	r3, ='\n'
		strb	r3, [r4, r6]
		add	r6, r6, #1	
		
		mov	r0, r6
		pop	{r4, r5, r6, r7, pc}	
