.MODEL	SMALL
.STACK	100H
.DATA
C	DW	?	;섭씨온도를 입력받을 워드변수 C
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX
	MOV	AH,2
	MOV	DL,'?'
	INT	21H

	CALL	INDECM
	MOV	C,AX	;워드변수 C를 저장한다.

;(9/5)는 1.8이다. 어셈블리에서는 소수계산법을 배우지 않아서 18*C/10의 계산방법을 택했다.

	MOV	AX,18	;18을 피제수로 지정
	IMUL	C	;18*C 계산해준다.
	CWD		;부호확장
	MOV	BX,10
	IDIV	BX	;(18*C)/10를 계산해준다.
	MOV	BX,32
	ADD	BX,AX	;(18*C/10)+32를 계산해준다.

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH		;줄바꿈

	MOV	AX,BX		;(18*C/10)+32를 AX에 저장
	CALL	OUTDECM	;연산결과를 10진수로 출력

	MOV	AH,4CH
	INT	21H
MAIN	ENDP

INCLUDE	INDECM.ASM
INCLUDE	OUTDECM.ASM

	END	MAIN