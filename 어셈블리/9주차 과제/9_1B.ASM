.MODEL	SMALL
.STACK	100H
.CODE
MAIN	PROC
	MOV	BX,10	;루프카운터 BX를 10으로 초기화
	MOV	DL,'0'	;첫 숫자를 DL에 저장
@TOP:	
	MOV	AH,2	;문자 출력기능 설정
	INT	21H	;첫숫자 출력
	INC	DL	;다음 숫자 DL에 저장
	DEC	BX	;루프 카운터 1감소
	JNZ	@TOP	;BX가 0이 아니면 @TOP으로 이돌

	MOV	AH,2	
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H	;줄바꿈

	MOV	BX,0	;루프카운터 BX를 0으로 초기화
	MOV	DL,'9'	;첫 숫자를 DL에 저장
@TOP1:
	MOV	AH,2	;문자 출력기능 설정
	INT	21H	;첫숫자 출력
	DEC	DL	;앞 숫자 DL에 저장
	INC	BX	;루프카운터 1증가
	CMP	BX,10	;BX와 반복횟수를 비교
	JL	@TOP1	;BX가 10보다 작으면 @TOP 이동

	MOV	AH,4CH
	INT	21H	;도스 제어권 반환
MAIN	ENDP
	END	MAIN	;프로그램 종료