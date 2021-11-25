	.intel_syntax noprefix
	.data
arr:
	.quad 5, 10, 20, 40, 45, 55, 70, 75, 90, 95
format_1:
	.asciz "Item found at location: %lu\n"
format_2:
	.asciz "Item is not found in the list."
	.text
########################## CALLER  ######################################
	.global main
main:

	push 55				# item
	push 10				# size
	
	lea rdi, arr		# get starting address of array

	call jumpSearch
	add rsp, 16			# deallocation of 10, 55

	cmp rax, -1			# rax == -1 not found
	je mainexit

exit:		# found

	
	push rax
	push rcx
	lea rdi, [format_1]
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	pop rax


	ret

mainexit:	# not found

	push rax
	push rcx
	lea rdi, [format_2]
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	pop rax


	ret


########################## CALLEE  ######################################
	.global isqrt
isqrt:

	mov rax, [rbp + 16]   		# get num, size
	mov r8, 2					# 2
	mov rdx, 0
	div r8						# num / 2
	mov r9, rax					# x0 = num / 2

	mov rax, [rbp + 16]			# get num
	mov rdx, 0
	div r9						# num / x0
	add rax, r9					# x0 + num / x0
	mov rdx, 0
	div r8						# (x0 + num / x0) / 2

	mov r10, rax				# x1 = (x0 + num / x0) / 2

isqrtwhile:
	cmp r10, r9					# x1 < x0
	jge isqrtexit

	mov r9, r10					# x0 = x1

	mov rax, [rbp + 16]			# get num
	mov rdx, 0
	div r9						# num / x0
	add rax, r9					# x0 + num / x0
	mov rdx, 0
	div r8						# (x0 + num / x0) / 2

	mov r10, rax				# x1 = (x0 + num / x0) / 2

	jmp isqrtwhile


isqrtexit:
	ret



########################## CALLEE  ######################################
	.global jumpSearch
jumpSearch:
	
	push rbp
	mov rbp, rsp

	mov r8, [rbp + 16]			# get size
	mov r9, [rbp + 24]			# get item

	push r8
	push r9
	
	call isqrt
	
	pop r9
	pop r8
	

	push r12
	push r13
	push r14

	mov r12, rax				# m
	mov rdx, r12				# t = m
	mov r10, 0					# i

while:
	mov r11, [rdi+8*r12]		# a[m]
	cmp r11, r9					# a[m] <= item
	jg for
	cmp r12, r8					# m < size
	jge	for

	mov r10, r12				# i = m
	add r12, rdx				# m += t
	if:
		mov r13, r8				#
		dec r13					# size - 1
		cmp r10, r13			# i > size - 1
		jle while
		jmp return_1

	mov r14, r10				# x = i
for:
	cmp r14, r12				# x < m
	jge return_1
	
	if2:
		mov r11, [rdi+8*r14]	# a[x]
		inc r14
		cmp r11, r9				# a[x] == item
		jne for
		dec r14
		jmp return_X
		

return_1:

	pop r14
	pop r13
	pop r12
	pop rbp
	mov rax, -1
	ret

return_X:

	mov rax, r14		# return X
	pop r14
	pop r13
	pop r12
	pop rbp
	
	ret 











