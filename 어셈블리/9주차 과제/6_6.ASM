.MODEL	SMALL
.STACK	100H
.DATA
NO	DB	'NO CAPITAL LETTERS$'
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX

	MOV	AH,2
	MOV	DL,'?'
	INT	21H	;'?'를 출력한다.

	MOV	BL,'['	;FIRST 문자를 '['으로 초기화한다.
	MOV	AH,1
@WHILE:
	INT	21H	;한 문자를 입력 받는다.
	CMP	AL,'A'
	JB	@END_IF	;A보다 작으면 대문자 아님
	CMP	AL,'Z'
	JA	@END_IF	;Z보다 크면 대문자 아님

	CMP	AL,BL	;입력받은 문자가 FIRST문자보다 작으면 AL을 BL에 저장
	JAE	@END_IF
	MOV	BL,AL
@END_IF:
	CMP	AL,0DH	;입력문자가 ENTER면 DOWHILE문 종료
	JNE	@WHILE

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H	;줄바꿈

	CMP	BL,'['	;FIRST가 초기 '['와 같으면 NO문자열 출력
	JNE	@CAPS
	MOV	AH,9
	LEA 	DX,NO
	JMP	@OUTPUT
@CAPS:
	MOV	DL,BL
@OUTPUT:
	INT	21H	;BL출력
	MOV	AH,4CH
	INT	21H	;도스제어권 반환
MAIN	ENDP
	END 	MAIN	;프로그램 종료
	