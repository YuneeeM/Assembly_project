OUTDECM	PROC
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX

	CMP	AX,0
	JGE	@END_IF	;AX가 양수이면 @END_IF로 이동
	PUSH	AX	;'-'출력을 위해 스택에 임시 저장
	MOV	DL,'-'
	MOV	AH,2
	INT	21H	;'-'를 출력
	POP	AX
	NEG	AX	;2의 보수화하여 양수로 만듬
@END_IF:
	XOR	CX,CX	;루프카운터 0으로 설정
	MOV	BX,10	;제수 10을 BX에 저장
@FIND_DEC:
	XOR	DX,DX	;워드 나눗셈을 위해 DX에 0을 저장
	DIV	BX	;부호 없는 워드 나눗셈을 실행
	PUSH	DX	;나머지를 스택에 저장
	INC	CX	;루프카운터 1증가
	CMP	AX,0
	JNE	@FIND_DEC	;몫이 0이 아니면 계속 수행
	MOV	AH,2
@OUT_LOOP:
	POP	DX	;스택에서 10진 값을 꺼냄
	OR	DL,30H	;10진 문자로 변환
	INT	21H	;10진 문자를 출력
	LOOP	@OUT_LOOP

	POP	DX
	POP	CX
	POP	BX
	POP	AX
	RET
OUTDECM	ENDP

