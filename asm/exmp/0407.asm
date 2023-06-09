PUSH_DATA_REG MACRO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
ENDM
POP_DATA_REG MACRO
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

STACK SEGMENT STACK
    DB 256 DUP(?)
STACK ENDS
DATA SEGMENT
    DAT1    DW 10
            DB 10 10H,25H,67H,68H,73H,83H,95H,0A8H,0C2H,0E6H
    DAT2    DW 13 
            DB 13 05H,12H,26H,45H,58H,65H,67H,70H,76H,88H,92H,0CDH,0DEH
    DAT     DW ?
            DB 256 DUP(?)
    PRINT_LEN DB ?
    PRINT_PTR DW ?
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA, ES:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX
    MOV AX, WORD PTR DAT1
    ADD AX, WORD PTR DAT2
    LEA DI, DAT
    MOV WORD PTR DS:[DI], AX; DI指向dat整体头
    ADD WORD PTR DS:[DI], 2; DI指向dat数据头

    CLD
    LEA SI, DAT1
    ADD SI, 2 
    MOV CX, WORD PTR DAT1
    REP MOVSB

    LEA SI, DAT2
    ADD SI, 2
    MOV CX, WORD PTR DAT2
    REP MOVSB
    JMP EXIT
    
    PRINT_BYTE PROC
        PUSH_DATA_REG

        POP_DATA_REG
    PRINT_BYTE ENDP

    CRLF PROC
        PUSH AX
        PUSH DX
        MOV DL, 0DH
        MOV AH, 02H
        INT 21H
        MOV DL, 0AH
        MOV AH, 02H
        INT 21H
        POP DX
        POP AX
        RET
    CRLF ENDP
    
    EXIT:
        MOV AH, 4CH
        INT 21H

CODE ENDS
END START