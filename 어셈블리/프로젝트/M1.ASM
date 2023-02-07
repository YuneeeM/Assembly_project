.MODEL 	SMALL
.STACK	100H
.CODE
MAIN	PROC
	MOV	AH,2
	MOV	DL,'?'
	INT	21H

	MOV	AH,1
	INT	21H
	MOV	AH,0	;AX레지스터 초기화
	SUB	AX,30H	;입력받은 배수값 2진수 변환
	MOV	BX,0	;합 계산을 할 레지스터
	MOV	DX,0	;배수값을 넣을 레지스터
	MOV	DX,AX	;배수값을 안전하게 DX로 옮김		
	MOV	AX,0	;뒷 계산을 위해 AX비움
@WHILE1:
;50보다 작은 배수의 합을 구하기 위한 반복문
	ADD	BX,AX	;AX+BX 전체합
	ADD	AX,DX	;AX에 배수를 더함(N의 배수값 저장)
	CMP	AX,50
	JL	@WHILE1	;50보다 작으면 @WHILE
	MOV	CX,BX	;50보다 작은 합을 CX에 저장

;전체 계산을 위한 레지스터 초기화
	MOV	AH,0	;AX레지스터 초기화
	SUB	AX,30H	;입력받은 배수값 2진수 변환
	MOV	BX,0	;합 계산을 할 레지스터
	MOV	DX,0	;배수값을 넣을 레지스터
	MOV	DX,AX	;배수값을 안전하게 DX로 옮김		
	MOV	AX,0	;뒷 계산을 위해 AX비움
@WHILE2:
	ADD	BX,AX	;AX+BX 전체합
	ADD	AX,DX	;AX에 배수를 더함(N의 배수값 저장)
	CMP	AX,150
	JL	@WHILE2	;150보다 작으면 @WHIL2

	SUB	BX,CX	;50보다 크고 150보다 작은 배수값을 저장하기 위해 BX=BX-CX

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH
	INT	21H	;줄바꿈

;16진수 출력코드를 위해 8비트 결과를 16진수로 출력한다!

	MOV	DH,4	;루프카운터를 4로 초기화
	MOV	CL,4	;CL을 4비트로 이동, 회전 설정
	MOV	AH,2

@OUTPUT:
	MOV	DL,BH	;BH를 DL에 저장
	SHR	DL,CL	;DL을 4비트 오른쪽이동
	CMP	DL,0AH
	JL	@NUMBER
	ADD	DL,37H	;16진수값을 문자로 바꿔준다('A')
	JMP	@NEXT
@NUMBER:
	OR	DL,30H	;16진수값을 문자로 바꿔준다('0')
@NEXT:
	INT	21H	;화면 출력
	ROL	BX,CL	;BX를 4비트 왼쪽회전
	DEC	DH	;루프카운터 1 감소
	JNZ	@OUTPUT;0이 될때까지 반복수행
@END:
	MOV	AH,4CH
	INT	21H
MAIN	ENDP
	END	MAIN
	
	