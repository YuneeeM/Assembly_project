.MODEL	SMALL
.STACK	100H
.DATA
	ERROR_S		DB	'ERROR$'
.CODE
MAIN	PROC
@BEGIN:				;처음으로 다시 실행 @BEGIN레이블
	MOV	AX,@DATA
	MOV	DS,AX		;데이터 레이블로 부터 메모리 불러옴

	MOV	AH,2
	MOV	DL,'?'
	INT	21H
	
	MOV	AH,1
	INT	21H
	MOV	BL,AL		;첫번째 소문자 입력받고 BL에 옮김
	
	CMP	AL,'a'		;첫번째 소문자와 'a'를 비교해서 
	JL	@ERROR		;AL<'a'이면 소문자가 아님으로 @ERROR로 이동
	CMP	AL,'z'		
	JG	@ERROR		;AL>'z'이면 소문자가 아님으로 @ERROR로 이동
	
	INT	21H		;소문자가 맞으면 BL에 저장
	MOV	BH,AL		;두번째 소문자 입력 받고 BH에 저장
	CMP	AL,'a'		;두번째 소문자와 'a'를 비교해서 
	JL	@ERROR		;AL<'a'이면 소문자가 아님으로 @ERROR로 이동
	CMP	AL,'z'
	JG	@ERROR		;AL>'z'이면 소문자가 아님으로 @ERROR로 이동

	INT	21H		;소문자가 맞으면 BH에 저장
	MOV	CL,AL		;세번째 소문자 입력받고 CL애 저장
	CMP	AL,'a'		;세번째 소문자와 'a'를 비교해서 
	JL	@ERROR		;AL<'a'이면 소문자가 아님으로 @ERROR로 이동
	CMP	AL,'z'
	JG	@ERROR		;AL>'z'이면 소문자가 아님으로 @ERROR로 이동

	JMP	@END_CASE	;조건이 다 맞으면 @END_CASE로 이동
@ERROR:				;에러뜨는 조건 @ERROR조건
	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H		;줄바꿈

	MOV	AH,9
	LEA	DX,ERROR_S
	INT	21H		;에러 문자열 출력

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H		;줄바꿈

	JMP	@BEGIN		;다시 처음으로 이동
@END_CASE:
	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H		;줄바꿈

	MOV	DL,CL
	INT	21H		;마지막문자 출력
	MOV	DL,BH
	INT	21H		;두번째문자 출력
	MOV	DL,BL
	INT	21H		;첫번째문자 출력

	MOV	AH,4CH
	INT	21H		;도스제어권 반환
MAIN	ENDP
	END	MAIN		;프로그램 종료
	
	
