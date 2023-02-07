.MODEL	SMALL
.STACK	100H
.CODE
MAIN	PROC
	MOV	CX,10	;루프카운터를 10으로 초기화
	MOV	DL,'0'	;첫숫자 DL에 저장
@WHILE:
	CMP	CX,0		;조건
	JLE	@END_WHILE	;CX가 0보다 작거나 같으면 @END_WHILE로 이동
	MOV	AH,2		;문자 출력기능 설정
	INT	21H		;첫숫자 출력
	INC 	DL		;다음 숫자 DL에 저장
	DEC	CX		;루프카운터 1감소
	JMP	@WHILE		;초기 위치인 @WHILE로 이동

@END_WHILE:
	MOV	AH,2		
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H		;줄바꿈
	
	MOV	CX,10		;루프카운터를 10으로 초기화
	MOV	DL,'9'		;첫숫자 DL에 저장
@WHILE1:
	CMP	CX,0		;조건
	JLE	@END_WHILE1	;CX가 0보다 작거나 같으면 @END_WHILE1로 이동
	MOV	AH,2		;문자 출력기능 설정
	INT	21H		;첫숫자 출력
	DEC	DL		;앞 숫자 DL에 저장
	DEC	CX		;루프카운터 1감소
	JMP	@WHILE1		;초기 위치인 @WHILE1로 이동

@END_WHILE1:
	MOV	AH,4CH
	INT	21H		;도스제어권 반환
MAIN	ENDP
	END	MAIN		;프로그램 종료
	
	