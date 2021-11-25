.intel_syntax noprefix
.text

.global mymul

mymul:
	push rbp

	mov r9, 0 #i
	mov r10, 0 #j



	mov r11, 0
	for:		     #c[i] = 0
		cmp r11,21
		jge for2
		movq [rdi+r11*8], 0
		inc r11
		jmp for


	for2:
		cmp r9, rdx
		jge end

		push rdx	# save alen
		mov rdx, 0  #u = 0
		mov r10, 0
		for3:
			cmp r10, r8
			jge for2Continue
			mov r12, rdx
			movq rax, [rsi+r9*8]   # a[i]
			mulq [rcx+r10*8]       # a[i]*b[j]
			add  rax, r12		   #  v =  a[i]*b[j] + u
			adc  rdx, 0  		   # u = carry

			push r10

			add  r10, r9			# i+j
			add  rax, [rdi+r10*8]   # v = c[i+j] + a[i]*b[j] + u
			adc  rdx, 0 			# u = carry

			movq [rdi+r10*8], rax    # c[i+j] = v

			pop r10

			inc r10
			jmp for3



	   for2Continue:

	   		push r9
	   		add r9, r8  # i +t
	   		movq  [rdi+r9*8], rdx     #c[i+t] = u
	   		pop r9

	   		inc r9
	   		pop rdx
	   		jmp for2

end:
	pop rbp
	ret
