.MODEL	SMALL
.STACK	100H
.CODE
MAIN	PROC
	MOV	AH,2
	MOV	CX,10	;루프 카운터를 10으로 초기화함
@TOP:			;반복문
	MOV	DL,'*'	;문자'*'를 DL에 저장
	INT	21H	
	LOOP	@TOP	;CX를 1감소, 0이 아니면 @TOP으로 이동
	
	MOV	AH,4CH
	INT	21H	;도스 제어권 반환
MAIN	ENDP
	END	MAIN	;프로그램 종료