INDECM	PROC
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	SI
@BEGIN:
	XOR	BX,BX	;BX를 0으로 초기화
	XOR	CX,CX	;CX(부호)를 0으로 초기화
	MOV	AH,1
	INT	21H	;한 문자를 입력받음
	CMP	AL,'-'
	JE	@MINUS
	CMP	AL,'+'
	JE	@PLUS
	JMP	@DO_WHILE
@MINUS:
	MOV	CX,1	;음수이면 CX에 1을 저장
@PLUS:
	INT	21H
@DO_WHILE:
	CMP	AL,'0'
	JB	@ERROR		;10진 문자가 아니면 @ERROR로 이동
	CMP	AL,'9'
	JA	@ERROR		;10진 문자가 아니면 @ERROR로 이동
	AND	AX,000FH		;10진 값으로 변환
	MOV	SI,AX		;곱셈을 위해 SI에 임시저장
	MOV	AX,10		;피승수를 10으로 설정
	IMUL	BX		;DEC(i)을 승수로 워드 곱셈함
	JO	@OVERFLOW	;OF가 1이면 @ERROR로 이동
	MOV	BX,SI		;10진 값을 BX에 다시 저장
	ADD	BX,AX		;10진 값을 더하여 DEC(i+1)을 계산
	JO	@OVERFLOW	;OF가 1이면 @ERROR로 이동	
	MOV	AH,1
	INT	21H

	CMP	AL,0DH	;입력문자가 ENTER이거나 ' '이면 WHILE문 수행종료
	JE	@END_WHILE
	CMP	AL,' '
	JE	@END_WHILE
	JMP	@DO_WHILE
@END_WHILE:
	MOV	AX,BX	;최종값을 AX에 저장
	CMP	CX,0
	JE	@EXIT
	NEG	AX	;CX가 1이면 음수로 만든다.
@EXIT:
	POP	SI
	POP	DX
	POP	CX
	POP	BX
	RET
@OVERFLOW:
;입력 -32768은 오버플로우가 아니므로 @END_WHILE로 이동  
	CMP	BX,32768
	JNE	@ERROR	;32758보다 크면 @END_WHILE로 이동
	CMP	CX,1
	JNE	@ERROR	;+32768이면 @END_WHILE로 이동
	JMP	@END_WHILE
@ERROR:
	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H
	JMP	@BEGIN	;처음부터 다시시작
INDECM	ENDP

