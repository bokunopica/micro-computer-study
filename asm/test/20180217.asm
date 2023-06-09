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
    MOV AX, 1000H
    MOV BX, 2000H
    SUB AX, BX
    JC CF1
    JNC CF0
CF1:
    MOV DL, 1
    JMP SHOW
CF0:
    MOV DL, 0
    JMP SHOW
SHOW:    
    ADD DL, '0'
    MOV BYTE PTR VAR1, DL
    MOV DX, OFFSET VAR1
    MOV AH, 9
    INT 21H

FINISH:
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START