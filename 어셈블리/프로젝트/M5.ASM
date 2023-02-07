.MODEL	SMALL
.STACK	100H
.DATA
ArrayB	DW	5 DUP (?)		;5개의 워드배열 초기화
SUM_1	DW	?		;평균을 구할때 사용하는 총합 변수
SUM_2	DW	?		;절대치 총합을 구할때 사용하는 절대치총합 변수
.CODE
MAIN	PROC
	MOV	AX,@DATA
	MOV	DS,AX
	MOV	AH,2
	MOV	DL,'?'
	INT	21H

	MOV	CX,5		;5개의 배열 인덱스 카운터 5
	XOR	SI,SI		;SI를 0으로 초기화(인덱스 주소지정모드 사용)
@INPUT:	
	CALL	INDECM
	MOV	ArrayB[SI],AX	;배열저장
	ADD	SUM_1,AX		;평균을 구하기 위해 배열 합을 SUM_1변수에 저장
	CMP	AX,0		;절대값 구하기
	JGE	@NEXT		;음수가 아니면 @NEXT이동
	NEG	AX		;보수화해줌
@NEXT:
	ADD	SUM_2,AX		;절대치 총합을 SUM_2변수에 저장
	ADD	SI,2		;인덱스 주소 증가(워드변수 +2)
	LOOP	@INPUT	

	MOV	AX,SUM_1		;계산을 위해 총합을 AX로 불러옴
	MOV	BX,5		;나눗셈을 위해 BX에 5를 저장
	CWD			;부호 확장
	IDIV	BX		;SUM_1/5
	MOV	SUM_1,AX

	MOV	AH,2
	MOV	DL,0DH
	INT	21H
	MOV	DL,0AH		;줄바꿈

	MOV	AX,SUM_1
	CALL	OUTDECM	;평균출력
	MOV	AH,2
	MOV	DL,' '
	INT	21H		;공백출력
	MOV	AX,SUM_2
	CALL	OUTDECM	;절대치 총합 출력
	MOV	AH,4CH
	INT	21H
MAIN	ENDP

INCLUDE	INDECM.ASM
INCLUDE	OUTDECM.ASM

	END	MAIN
	