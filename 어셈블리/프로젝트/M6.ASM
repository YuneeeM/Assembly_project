.MODEL	SMALL
.STACK	100H
.DATA
ArrayA	DW	5 DUP (?)	;입력받을 워드 배열 ArrayA 초기화
ArrayB	DW	5 DUP (?)	;계산값 저장받을 워드 배열 ArrayB 초기화
.CODE	
MAIN	PROC	
	MOV	AX,@DATA
	MOV	DS,AX
	MOV	AH,2
	MOV	DL,'?'
	INT	21H

;5개 요소의 워드 배열 ArrayA을 입력받음
	XOR	SI,SI
	MOV	CX,5
@TOP:
	CALL	INDECM
	MOV	ArrayA[SI],AX	
	ADD	SI,2	;인덱스 주소 증가(워드 변수 +2)
	LOOP	@TOP

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH	;줄바꿈
	
	MOV	CX,5
	XOR	SI,SI	;배열 B에 계산값 저장
;ASSEM에서 ArrayA[8-SI]는 사용할 수 없기에 인덱스 조건에 따라 계산을 따로 해줌
@REPEAT:
	CMP	SI,0
	JE	@THEN_0	;인덱스 주소 0일때 @THEN_0이동	
	CMP	SI,2	
	JE	@THEN_1	;인덱스 주소 2일때 @THEN_1이동
	CMP	SI,6	
	JE	@THEN_2	;인덱스 주소 6일때 @THEN_2이동
	CMP	SI,8
	JE	@THEN_3	;인덱스 주소 8일때 @THEN_3이동
	MOV	AX,ArrayA[SI]	;인덱스 주소가 4일때는  ELSE문으로 지정
	SUB	AX,ArrayA[SI]	;ArrayA[2]-ArrayA[2]계산(워드배열임으로 주소+2)
	JMP	@RESULT
@THEN_0:
	MOV	AX,ArrayA[SI]
	SUB	AX,ArrayA[SI+8]	;ArrayA[0]+Array[4]계산(워드배열임으로 주소+2)
	JMP	@RESULT
@THEN_1:
	MOV	AX,ArrayA[SI]
	SUB	AX,ArrayA[SI+4]	;ArrayA[1]+Array[3]계산(워드배열임으로 주소+2)
	JMP	@RESULT
@THEN_2:
	MOV	AX,ArrayA[SI]
	SUB	AX,ArrayA[SI-4]	;ArrayA[3]+Array[1]계산(워드배열임으로 주소+2)
	JMP	@RESULT
@THEN_3:
	MOV	AX,ArrayA[SI]
	SUB	AX,ArrayA[SI-8]	;ArrayA[4]+Array[0]계산(워드배열임으로 주소+2)

@RESULT:	
	MOV	ArrayB[SI],AX	;계산결과 배열 ArrayB[SI]에 저장
	ADD	SI,2		;인덱스 주소 증가(워드 변수 +2)
	LOOP	@REPEAT

	MOV	CX,5
	XOR	SI,SI
@OUTPUT:
	MOV	AX,ArrayB[SI]
	CALL	OUTDECM	;배열ArrayB[SI] 출력
	MOV	AH,2
	MOV	DL,' '
	INT	21H		;공백 출력
	ADD	SI,2		;인덱스 주소 증가(워드변수 +2)
	LOOP	@OUTPUT
	MOV	AH,4CH
	INT	21H
MAIN	ENDP

INCLUDE	INDECM.ASM
INCLUDE	OUTDECM.ASM

	END	MAIN

	
	