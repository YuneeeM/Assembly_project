.MODEL	SMALL
.STACK	100H
.CODE
MAIN	PROC
@BEGIN:
	MOV	AH,2
	MOV	DL,'?'
	INT	21H
	
	MOV	BL,0		;합을 저장할 BL에 0초기화
	MOV	AH,1
	INT	21H
@WHILE:
	CMP	AL,0DH
	JE	@END_WHILE	;ENTER입력시 @END_WHILE로 이동
	
	CMP	AL,'0'
	JB	@ERROR	
	CMP	AL,'9'
	JA	@ERROR		;숫자가 아니면 @ERROR로 이동
	
	SUB	AL,30H		;이진수변환
	ADD	BL,AL		;BL=BL+AL
	INT	21H		;BL 저장
	JMP	@WHILE		
@END_WHILE:
	MOV	AH,2	
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	
	MOV	DH,2		;반복을 위해 루프카운터를 2로 설정
	MOV	CL,4		;SHIFT카운터 4로 설정
@OUTPUT:	
;16진수 출력코드		
	MOV	DL,BL		;출력할 값을 얻기 위해 BL을 DL에 저장
	SHR	DL,CL		;DL을 4비트 오른쪽 회전
	CMP	DL,0AH
	JL	@NUMBER
	ADD	DL,37H		;16진값-> 'A-F'변환
	JMP	@NEXT
@NUMBER:
	OR	DL,30H		;16진값-> '0-9'변환
@NEXT:
	INT	21H
	ROL	BL,CL		;BL를 4비트 왼쪽 회전을 통해 다음 연산을 위한 BL재설정
	DEC	DH		;루프카운터 1감소
	JNZ	@OUTPUT	;DH가 0이 아니면 @OUTPUT이동
	JMP	@EXIT
@ERROR:
	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H		;줄바꿈
	JMP	@BEGIN		;처음으로 돌아감
@EXIT:
	MOV	AH,4CH
	INT	21H
MAIN	ENDP
	END	MAIN
	


