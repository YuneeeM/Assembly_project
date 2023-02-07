.MODEL	SMALL
.STACK	100H
.CODE
MAIN	PROC		;MAIN 생성
	MOV	CX,10	;루프카운터를 10으로 초기화
	MOV	BL,'0'	;출력할 첫 숫자 DL에 저장
@TOP:
	MOV	AH,2	;문자출력기능 설정
	MOV	DL,BL
	INT	21H	;숫자 출력
	INC	BL	;다음 숫자 DL에 저장
	LOOP	@TOP	;CX가 0이 아니면 @TOP로 이동
	
	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H	;줄바꿈

	MOV	CX,10	;루프카운터를 10으로 초기화
	MOV	BL,'9'	;출력할 첫 숫자 DL에 저장
@TOP1:
	MOV	AH,2	;문자출력기능 설정
	MOV	DL,BL
	INT	21H	;숫자출력
	DEC	BL	;앞 문자 DL에 저장
	LOOP	@TOP1	;CX가 0이 아니면 @TOP1로 이동

	MOV	AH,4CH
	INT	21H	;도스 제어권 반환
MAIN	ENDP
	END	MAIN	;프로그램 종료