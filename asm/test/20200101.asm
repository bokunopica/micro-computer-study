STACK SEGMENT STACK
    DB 256 DUP(?)
STACK ENDS
DATA SEGMENT
    VAR1 DB ?, '$'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA, ES:DATA, SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX
    MOV AL, -20
    MOV AL, 96H
    MOV BL, 12H
    MUL BL
FINISH:
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START