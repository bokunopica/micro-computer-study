STACK SEGMENT STACK
    DB 256 DUP(?)
    S_TOP LABEL WORD
STACK ENDS
DATA SEGMENT
    BUF DB 'TestCase'
    BUF_LEN DW $-BUF
DATA ENDS

ASSUME CS:CODESG, DS:DATA, ES:DATA, SS:STACK

CODESG SEGMENT
MAIN:
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX

    ; 校验位修改
    CALL SETEVEN
    CALL EXIT
    JMP LAST
    SETEVEN PROC
        ; PROC:SETEVEN 
        ; FUNCTION: ascii码奇偶修复
        ; INPUT PARAMS
        ;   BUF - 字符串
        ;   BUF_LEN - 字符串长度
        ; OUTPUT PARAMS 
        ;   
        ; USED REGISTER: AX, BX, CX, SI
        ; EXAMPLE:
        ; DATA SEGMENT
        ;    BUF DB 'TestCase'
        ;    BUF_LEN DW $-BUF
        ; DATA ENDS
        ; ....
        ; CODE SEGMENT
        ;    CALL SETEVEN
        ; ...
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH SI
        LEA SI, BUF
        MOV CX, BUF_LEN
        L1:
            MOV AL, [SI]
            ADD AL, 0
            JP SETEVEN_1
            JNP SETEVEN_0
        SETEVEN_1:
            OR AL, 80H
            MOV [SI], AL
        SETEVEN_0:
            INC BX
            LOOP L1
        POP CX
        POP BX
        POP AX
        POP SI
        RET
    SETEVEN ENDP
    EXIT PROC
        MOV AH, 4CH
        INT 21H
    EXIT ENDP
    LAST: XOR AX, AX
CODESG ENDS
END MAIN
