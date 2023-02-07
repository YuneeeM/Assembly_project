.MODEL	SMALL
.STACK	100H
.DATA
A	DW	?	;워드변수 A
B	DW	?	;워드 변수 B
C	DW	?	;워드 변수 C
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX
	MOV	AH,2
	MOV	DL,'?'
	INT	21H

	CALL	INDECM
	MOV	A,AX	;워드변수 A를 A에저장
	CALL	INDECM	
	MOV	B,AX	;워드변수 B를 B에저장
	CALL	INDECM
	MOV	C,AX	;워드변수 C를 C에저장
	
	MOV	AX,A
	IMUL	B	;A*B계산
	MOV	BX,AX	;BX에 A*B저장
	
	MOV	AX,B
	CMP	AX,0
	JGE	@NEXT
	NEG	AX	;|B|를 구한다.
@NEXT:
	IMUL	C
	SUB	BX,AX	;(A*B-|B|*C)를 계산

	MOV	AX,C
	IMUL	A	;C*A 계산
	MOV	CX,AX
	CMP	CX,0
	JGE	@NEXT1
	NEG	CX	;|C*A|를 구한다.
@NEXT1:
	ADD	BX,CX	;(A*B-|B|*C+|C*A|)를 계산
	
	MOV	AX,BX
	CWD		;부호를 확장시켜준다.
	MOV	BX,5	
	IDIV	BX	;(A*B-|B|*C+|C*A|)/5를 계산
	MOV	BX,AX

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	MOV	AX,BX		;연산결과 AX에 저장
	CALL	OUTDECM	;연산결과 10진수로 출력
	MOV	AH,4CH
	INT	21H
MAIN	ENDP

INCLUDE	INDECM.ASM
INCLUDE	OUTDECM.ASM
	END	MAIN
