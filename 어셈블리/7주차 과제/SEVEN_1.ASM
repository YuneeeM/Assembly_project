.MODEL	SMALL
.STACK	100H
.DATA
	ERROR_S		DB	'ERROR$'	 ;에러뜰때 사용할 문자열 저장
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX
	
	MOV	AH,2
	MOV	DL,'?'
	INT	21H		;'?'출력받기
	
	MOV	AH,1
	INT	21H
	MOV	BL,AL		;문자하나입력받아 저장하고 AL에서 BL로 옮겨서 저장

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H		;줄바꿈
	CMP	BL,'0'		;숫자0보다 작으면 에러 출력
	JL	@ERROR
	CMP	BL,'9'		;숫자0보다 크고 9보다 작으면 숫자
	JLE	@NUM
	CMP	BL,'A'		;'A'보다 작으면 대소문자가 아님
	JL	@ERROR
	CMP	BL,'Z'		;'A'보다 크고 'Z'보다 작으면 대문자
	JLE	@UP
	CMP	BL,'a'		;'a'보다 작으면 대소문자가 아님
	JL	@ERROR
	CMP	BL,'z'		;'a'보다 크고 'z'보다 작으면 소문자
	JLE	@DOWN
	JMP	@ERROR		;'z'보다 크면 에러 출력
@ERROR:				
	MOV	AH,9
	LEA	DX,ERROR_S
	INT	21H		;에러 문자열을 출력받음
	JMP	@END_CASE
@NUM:
	MOV	DL,BL
	INT	21H		;숫자는 그대로 숫자출력
	JMP	@END_CASE
@UP:
	ADD	BL,20H
	MOV	DL,BL
	INT	21H		;대문자라면 소문자로 바꿔서 출력
	JMP	@END_CASE
@DOWN:
	SUB	BL,20H
	MOV	DL,BL
	INT	21H		;소문자라면 대문자로 바꿔서 출력
	JMP	@END_CASE
@END_CASE:

	MOV 	AH,4CH
	INT	21H		;도스제어권 반환
MAIN	ENDP
	END	MAIN		;프로그램 종료