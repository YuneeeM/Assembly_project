.MODEL	SMALL
.STACK	100H
.CODE	
MAIN	PROC
	MOV	AH,2
	MOV	BX,10	;루프 카운터 BX를 10으로 초기화함
@TOP:			;반복문
	MOV	DL,'*'	;문자'*'를 DL에 저장
	INT	21H
	DEC	BX	;루프 카운터를 1 감소시킨다.
	JNZ	@TOP	;BX가 0이 아니면 @TOP이동
	
	MOV	AH,4CH
	INT	21H	;도스 제어권 반환
MAIN	ENDP
	END	MAIN	;프로그램 종료