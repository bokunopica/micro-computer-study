STACK SEGMENT STACK
    DW 256 DUP(?)
    TOP LABEL WORD
STACK ENDS
DATA SEGMENT
    DAT DW 10
        X = 17
        REPT 10
        X = (X+17) MOD 13
        DW X
        ENDM
    GREATZ DW 0
        DW 10 DUP(?)
    ZERO DW 0 
        DW 10 DUP(?)
    LITTLEZ DW 0
        DW 10 DUP(?)
DATA ENDS
ASSUME CS:CODE, SS:STACK, DS:DATA, ES:DATA
CODE SEGMENT
START:
    ; 初始化
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX
    MOV AX, STACK
    MOV SS, AX
    LEA SP, TOP
    ; 外层循环初始化
    MOV CX, DAT
    LEA SI, DAT
    ADD SI, 2
    ; 比较大小并赋SI对应变量位置
L1: MOV AX, [SI]
    CMP AX, 0
    PUSH SI
    PUSH CX
    JZ EZ
    JL LZ
    JG GZ
EZ: LEA SI, ZERO
    JMP NEXT
LZ: LEA SI, LITTLEZ
    JMP NEXT
GZ: LEA SI, GREATZ
    JMP NEXT
NEXT:
    ; 存储变量
    MOV CX, [SI]
    ADD WORD PTR [SI],1
    MOV BX, [SI]
    SHL BX, 1 ;BX*2
    ADD SI, BX
    MOV [SI], AX
    POP CX
    POP SI
    LOOP L1
    MOV AL, 4CH
    INT 21H
CODE ENDS
END START