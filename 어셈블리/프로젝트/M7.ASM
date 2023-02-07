.MODEL	SMALL
.STACK	100H
.DATA
ArrayA	DW	5 DUP (?)		;워드변수 ArrayA지정
ArrayB	DW	5 DUP (?)		;워드변수 ArrayB지정
ArrayC	DW	5 DUP (?)		;워드변수 ArrayC지정
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX
	MOV	AH,2
	MOV	DL,'?'
	INT	21H
	
	MOV	CX,5		;입력받을 배열A 5개 배열의 카운터
	XOR	SI,SI		;SI를 0으로 초기화(인덱스 주소지정모드 사용)
@INPUT_A:
	CALL	INDECM
	MOV	ArrayA[SI],AX	;배열A저장
	ADD	SI,2		;인덱스주소 증가(워드변수 +2)
	LOOP	@INPUT_A

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH		;줄바꿈

	MOV	AH,2
	MOV	DL,'?'
	INT	21H		
	MOV	CX,5		;입력받을 배열B 5개 배열의 카운터
	XOR	SI,SI		;SI를 0으로 초기화(인덱스 주소지정모드 사용)
@INPUT_B:
	CALL	INDECM
	MOV	ArrayB[SI],AX	;배열B저장
	ADD	SI,2		;인덱스주소 증가(워드변수 +2)
	LOOP	@INPUT_B

	MOV	AH,2
	MOV	DL,0DH
	INT	2H
	MOV	DL,0AH		;줄바꿈

	MOV	CX,5		;계산을 위한 배열카운터
	XOR	SI,SI		
@REPEAT: 
;워드변수인 만큼 주소 +2해준다.	
	CMP	SI,8		;IF(I<4), 워드변수임으로 SI<8
	JL	@THEN		;SI<8일때 @THEN 이동
	MOV	AX,ArrayA[SI-8]	;ELSE문
	ADD	AX,ArrayA[SI]	;괄호안에 있는 계산을 먼저함 ArrayA[i-4]+ArrayA[i]
	JMP	@NEXT
@THEN:
	MOV	AX,ArrayA[SI+2]	;ArrayA[i+1]+ArrayA[i] 계산
	ADD	AX,ArrayA[SI]	
@NEXT:
	MOV	BX,5		;계산우선순위에 따라 괄호뒤에 있는 나눗셈 먼저해준다.
	CWD			;부호확장
	IDIV	BX		;괄호안 식/5
	MOV	BX,AX		
	MOV	AX,ArrayB[SI]
	IMUL	BX		;ArrayB[i]*BX(앞에서 수행했던 계산결과)
	MOV	ArrayC[SI],AX	;결과값을 배열C에 저장
	ADD	SI,2
	LOOP	@REPEAT

	MOV	CX,5
	XOR	SI,SI
@OUTPUTC:
	MOV	AX,ArrayC[SI]
	CALL	OUTDECM	;배열C 출력
	MOV	AH,2
	MOV	DL,' '
	INT	21H		;공백 출력
	ADD	SI,2		
	LOOP	@OUTPUTC
	MOV	AH,4CH
	INT	21H
MAIN	ENDP

INCLUDE	INDECM.ASM
INCLUDE	OUTDECM.ASM

	END	MAIN

