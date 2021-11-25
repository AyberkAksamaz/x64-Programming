.intel_syntax noprefix

.section .data
digits:
	.asciz "Enter number of digits:"
nums:
	.asciz "Enter %d. digit:"
rotate1:
	.asciz "\nEnter number of bits to rotate:"
rotate2:
	.asciz "\nAfter the rotations\n"
format1:
	.asciz "\nA :="
format2:
	.asciz "\nC :="
format3:
	.asciz " + (0x%lX * (2^64)^%d)"
format4:
	.asciz ";\n"
input1:
	.asciz "%d"
input2:
	.asciz "%lX"
arr:
	.skip 100
tmp:
	.quad 0
save:
	.skip 100		# for save the last bits

.section .text
.global main
main:
	push rbx
	push r12
	push r13
	push r14
	push r15

###################### Enter  number of Digit ##############################


	push rax			# Enter number of digit
	push rcx
	lea rdi, [digits]
	xor rax, rax
	call printf
	pop rcx
	pop rax

	push rax			# Get number of digit
	push rcx
	lea rdi, [input1]
	lea rsi, [tmp]
	xor rax, rax
	call scanf
	pop rax
	pop rcx

	mov rax, [tmp]		# Number of digits
	mov r15, rax		# number of digits
	mov r13, 0			# arr index, i

###################### Enter  number of Digit ##############################

###################### Enter Digits ##############################

digit_loop:
	cmp rax, 0
	je A_print


	dec rax

	push rax			# Enter  digit
	push rcx
	lea rdi, [nums]
	mov rsi, rax
	xor rax, rax
	call printf
	pop rax
	pop rcx

	push rax			# get digits
	push rcx
	lea rdi, [input2]
	lea rsi, [tmp]
	xor rax, rax
	call scanf
	pop rax
	pop rcx

	
	mov r12, [tmp]			# digit
	mov [arr+8*r13], r12	# arr[i] = digit
	mov rbx, 0
	mov [tmp], rbx
	inc r13					# i++

	
	jmp digit_loop
###################### Enter Digits ##############################

###################### Print A:= ##################################
A_print:
	mov r12, 0

	push rax			# Print format1
	push rcx
	lea rdi, [format1]
	xor rax, rax
	call printf
	pop rcx
	pop rax
	

format3_print:

	cmp r13, 0
	je printN

	
	mov rax, [arr+8*r12]	# rax = arr[i]
	dec r13
	
	push rax			# Print format3
	push rcx
	lea rdi, [format3]
	mov rsi, rax
	mov rdx, r13
	xor rax, rax
	call printf
	pop rcx
	pop rax

	inc r12

	jmp format3_print
	
printN:
	push rax			# Print format1
	push rcx
	lea rdi, [format4]
	xor rax, rax
	call printf
	pop rcx
	pop rax

###################### Print A:= ##################################

###################### Enter Number of Bits Rotate ################

	push rax			# Print rorate1
	push rcx
	lea rdi, [rotate1]
	xor rax, rax
	call printf
	pop rcx
	pop rax

	push rax			# get number of rotate
	push rcx
	lea rdi, [input1]
	lea rsi, [tmp]
	xor rax, rax
	call scanf
	pop rax
	pop rcx
		
	mov rax, [tmp]		# Number of bits rotate

###################### Enter Number of Bits Rotate ################

###################### Rotation ################
	
	
	mov rsi, 0			# rotate number = 0
rotateLoop:
	mov r8, 0			# array index
	cmp rsi, rax		# rotate number <= number of rotate
	jge afterRotation
	
shiftLoop:				# saved last bit and right shift

	cmp r8, r15			# array index <= number of digits
	mov r10, 0			# array index for transfer loop
	mov r11, 0			# save index for transfer loop
	je transferLoop
	
	mov rdx, [arr+8*r8]		# rdx = arr[i]
	mov r9, 1				# for last bit
	and r9, rdx				# for last bit
	mov [save+8*r8], r9		# saved last bit
	
	shr rdx, 1				# right shift
	mov [arr+8*r8], rdx		# arr[i] = shifted rdx
	
	inc r8					# array index++
	jmp shiftLoop
		
transferLoop:
	
	cmp r10, r15			# r10 <= number of bits
	je ContinueRotateLoop
	
if:
	cmp r10, 0				# control first digit in array because transfer bit last digit
	jne else
	
	mov rdx, [arr+8*r10]		# rdx = arr[0]
	mov r9, [save+8*(r15-1)]	# r9 = last bit of last digit
	jmp bitControl
	
else:
	
	mov rdx, [arr+8*r10]		# rdx = arr[r10]
	mov r9,	[save+8*(r11-1)]	# transfer bit
	
bitControl:						# for last bit 0 or 1 ?
	
	cmp r9, 0		# last bit 0 or 1
	je labelAND
	
	shl r9, 63
	or rdx, r9
	mov [arr+8*r10], rdx
	
	inc r10
	inc r11
	jmp transferLoop

labelAND:
	
	shl r9, 63
	mov r9, 0x7fffffffffffffff
	and rdx, r9
	mov [arr+8*r10], rdx
	
	inc r10
	inc r11
	jmp transferLoop
		
ContinueRotateLoop:
	inc rsi				# rotate number
	jmp rotateLoop
	
	

###################### Rotation ################

###################### After Rotation ################
afterRotation:
	mov r13, r15
C_print:
	mov r12, 0

	push rax			# Print format1
	push rcx
	lea rdi, [format2]
	xor rax, rax
	call printf
	pop rcx
	pop rax
	

format3_print_C:

	cmp r13, 0
	je printN2

	
	mov rax, [arr+8*r12]	# rax = arr[i]
	dec r13
	
	push rax			# Print format3
	push rcx
	lea rdi, [format3]
	mov rsi, rax
	mov rdx, r13
	xor rax, rax
	call printf
	pop rcx
	pop rax

	inc r12

	jmp format3_print_C
	
printN2:
	push rax			# Print format1
	push rcx
	lea rdi, [format4]
	xor rax, rax
	call printf
	pop rcx
	pop rax



###################### After Rotation ################

exit:


	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	ret
