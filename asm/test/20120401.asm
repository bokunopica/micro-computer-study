STACK SEGMENT STACK
    DB 256 DUP(?)
STACK ENDS
DATA SEGMENT

DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA, ES:DATA, SS:STACK
START:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX
    MOV AH,0
    MOV AL,06H
    MOV BL,09H
    MUL BL
    AAM
FINISH:
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START