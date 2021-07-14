.586
.model flat,C

SumThreeArrays PROTO,
	array1:PTR DWORD, array2:PTR DWORD, 
	array3:PTR DWORD, arraySize:DWORD

AsmMultArray PROTO,
	srchVal:DWORD, arrayPtr:PTR DWORD, arraySize:DWORD

.code
;-----------------------------------------------
SumThreeArrays PROC USES eax ebx esi,
	array1:PTR DWORD, array2:PTR DWORD, 
	array3:PTR DWORD, arraySize:DWORD
;-----------------------------------------------
	LOCAL sz:BYTE		; local sz for jump
	mov sz, 4					; size of each iteration jump
	mov ecx, arraySize			; set ecx to size of arrays for loop
	
L1:
	mov eax, arraySize			; move array size into eax
	sub eax, ecx				; subtract whats left
	mul sz						; multiply by 4 to know how much to jump
	
	mov esi, array1				; set esi to start of array 1
	mov ebx, [esi+eax]			; move value of esi+jump into ebx
	
	mov esi, array2				; set esi to start of array 2
	add ebx, [esi+eax]			; add value of esi+jump to ebx

	mov esi, array3				; set esi to start of array 3
	add ebx, [esi+eax]			; add value of esi+jump to ebx

	mov esi, array1				; set esi to start of array 1
	mov [esi+eax], ebx			; move value of ebx into esi+jump

	LOOP L1

	ret  
SumThreeArrays ENDP

AsmMultArray PROC USES edi,
	mval:DWORD, arrayPtr:PTR DWORD, arraySize:DWORD
;
; Multiplies each element of an array by mval.
;-----------------------------------------------
	pushad				; save registers

	mov esi, arrayPtr	; set esi to address of array
	mov ecx, arraySize	; set ecx to size of array for loop

L1:
	mov eax, [esi]		; move value into eax of current array element
	mul mval			; multiply by value
	;mov [esi], eax		; not requirement, but would move lower half of result back into memory
	add esi, 4			; move esi

	LOOP L1				; loop

	popad				; return registers
	ret   
AsmMultArray ENDP

END
