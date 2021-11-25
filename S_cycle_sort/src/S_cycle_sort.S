.intel_syntax noprefix

.data

arr:
	.quad 0x1CD8726F306555F4,0x791E6CA8EB3C997F,0x22D33AD70F35B282,0x18485C8D8DABF636,0x67CBD6489907A4E9,0x6B79956A225ADA4C,0x5A7C91B7AE926E23,0x247CEA3D06AE45C9,0x390532B48F92B6C,0x4CE03CE7CA1A09BD,0x1FEF0362B7A4ABE4,0x24954151006CF0F0,0x3398BF419BE99ED2,0x76E7B2EA866EB495,0x730F0AAA51B89A29,0x5BBD4442B559BB28,0x4118F7E4F140D9A7,0x351FAE2F5C744EBD,0x645F4194C74F8C15,0x5673F5E2EF111714,0x4B7C57414C7F8FF4,0x42BE19E11DCC030,0x68C3E7E95CC82C1B,0x478FD6E421AC86D3,0x3CDB7D1ABBEDE623,0x7C174A4202CC6CD1,0x49DA229522257B4E,0x7BFD48038197D7D9,0x405034B4D5F4BA9B,0x76AFDCB8BB881FA8,0x4F547CEC45E46E9A,0x48112325D5072661,0x2CE93E8BDF67109E,0x713ADFC1BBB87ECD,0x527EEFBDA2593785
format:
	.asciz "\n%p\n"
format2:
	.asciz "\n%d\n"
.text

.global main

main:
	mov rax, 0  # writes
	mov rsi, 0  # cycle_start
	mov rdx, 0  # tmp
	mov rbx, 0  # item
	mov rcx, 0  # pos
	mov r8, 280  # n 35*8
	mov r9, r8
	sub r9, 8  # n-8
	mov r10, 0




for:
	cmp rsi, r9
	je print
	mov rbx, arr[rsi]  # item = arr[cycle_start]
	mov rcx, rsi  	   # pos = cycle_start

	mov rdi, rsi

for2:
	add rdi, 8  # cycle_start + 8 and i++
	cmp rdi, r8
	jge if

	cmp arr[rdi], rbx
	jge for2

	add rcx, 8
	jmp for2

if: #if(pos == cycle_start)
	 cmp rcx, rsi
	 je continue

while:  # (item == arr[pos])
	cmp rbx, arr[rcx]
	jne label1

	add rcx, 8 # pos +8
	jmp while
label1:
	mov rdx, arr[rcx] # tmp = arr[pos]
	mov arr[rcx], rbx # arr[pos] = item
	mov rbx, rdx      # item = tmp
	inc rax           # writes++

while2: #(pos != cycle_start)

	cmp rcx, rsi
	je isa

	mov rcx, rsi # pos = cycle_start

	mov rdi, rsi
	add rdi, 8  # i=cycle_start+8

for3:
	cmp rdi, r8  # i<n
	jge while3

	cmp arr[rdi], rbx # arr[i]<item
	jge label2

	add rcx, 8
label2:
	add rdi, 8
	jmp for3

while3: #(item == arr[pos])
	cmp rbx, arr[rcx]
	jne label4

	add rcx, 8

label4:
	mov rdx, arr[rcx] # tmp = arr[pos]
	mov arr[rcx], rbx # arr[pos] = item
	mov rbx, rdx      # item = tmp
	inc rax           # writes++


	jmp while2



 print:

	push rax
	push rcx
	lea rdi, [format2]
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	pop rax

	mov rbx, 0
print2:
	mov rax, arr[rbx]
	add rbx, 8
	cmp rbx, 288
	je exit

	push rax
	push rcx
	lea rdi, [format]
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	pop rax

	jmp print2

continue:
	 add rsi, 8
	 jmp for
isa:
	add rsi, 8
	jmp for

exit:
	ret

