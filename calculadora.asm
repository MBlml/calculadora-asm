; ---------------------------   
;| CALCULADORA BASICA EN ASM |
; ----------------------------
PAGE 60,132 
TITLE CALCULADORA (EXE)  ;SELECCION DE UNA OPCION DEL MENU 
      .MODEL SMALL
      ORG 100H ;INICIO DE PROGRAMA

; ---------------------------------------   
;| INCLUIR FUNCIONES DE LIBRERIA EMU8086 |
; ---------------------------------------
INCLUDE 'EMU8086.INC'
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

; -------------------------------   
;| SALTAR A LA FUNCION PRINCIPAL |
; -------------------------------
JMP PRINCIPAL                                        

; -----------------------------   
;| TITULO Y AUTOR DEL PROGRAMA |
; -----------------------------                                         
TEXTO  DB 13,10, '---CALCULADORA AVANZADA---'
       DB 13,10, '(JUAN MANUEL BARAJAS GOMEZ)'
 
; -------------------------------   
;| SOLICITUD DE NUMEROS A OPERAR |
; -------------------------------
       DB 13,10,13,10, 'DIGITE EL PRIMER NUMERO: $'
TEXTO2 DB 13,10,13,10, 'DIGITE EL SEGUNDO NUMERO: $'


; ----------------------------------------   
;| VARIABLES PARA IMPRESION DE RESULTADOS |
; ----------------------------------------
TEXTO3 DB 13,10,13,10, 'LA SUMA ES: $'
TEXTO4 DB 13,10,       'LA RESTA ES: $'
TEXTO5 DB 13,10,       'LA MULTIPLICACION ES: $'
TEXTO6 DB 13,10,       'LA DISION ES: $'

NUM1 DW ? ;VARIABLES DE 2 BYTES
NUM2 DW ? ;PARA LOS NUMEROS A OPERAR

; -------------------------------------   
;| FUNCION PRINCIPAL DE LA CALCULADORA |
; -------------------------------------
PRINCIPAL:
    ; ------------------------------------------   
    ;| IMPRESION DE TITULO Y AUTOR DEL PROGRAMA |
    ; ------------------------------------------
    MOV AH,09               ;INSTRUCCION PARA IMPRIMIR EN PANTALLA
    LEA DX,TEXTO            ;CARGA CADENA DE TEXTO 1 EN DX (TITULO,AUTOR Y SOLICITUD DE NUM1)
    INT 21H                 ;INTERRUPCION PANTALLA
        
    ; -------------------------------   
    ;| SOLICITUD DE NUMEROS A OPERAR |
    ; -------------------------------
    
    ;PARA NUM1
    CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO, SE GUARDA EN CX
    MOV NUM1,CX             ;MUEVE NUMERO A VARIABLE NUM1
    
    ;---------------------------
        
    ;IMPRESION DE SOLICITUD DE NUM2
    MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
    LEA DX,TEXTO2           ;CARGA CADENA DE TEXTO 2 EN DX
    INT 21H
    
    ;PARA NUM2
    CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO; EL VALOR SE GUARDA EN AX
    MOV NUM2,CX             ;MUEVE NUMERO A VARIABLE NUM2
    
    ; -------------------------   
    ;| IMPRESION DE RESULTADOS |
    ; -------------------------
    ;SUMA
    MOV AH,09
    LEA DX,TEXTO3
    INT 21H
    
    ;OPERACION Y RESULTADO
    MOV AX,NUM1             ;MUEVE PRIMER NUMERO DIGITADO A AX
    ADD AX,NUM2             ;SUMA LOS NUMEROS DIGITADO, QUEDA ALMACENADDO EN AX
    CALL PRINT_NUM
    
    ;---------------------------
    
    ;RESTA
    MOV AH,09
    LEA DX,TEXTO4
    INT 21H
    
    ;OPERACION Y RESULTADO
    MOV AX,NUM1             ;MUEVE PRIMER NUMERO DIGITADO A AX
    SUB AX,NUM2             ;RESTA EL 2DO DEL 1ER NUMERO, QUEDA ALMACENADDO EN AX
    CALL PRINT_NUM
    
    ;---------------------------
        
    ;MULTIPLICACION
    MOV AH,09
    LEA DX,TEXTO5
    INT 21H
    
    ;OPERACION Y RESULTADO
    MOV AX,NUM1             ;MUEVE PRIMER NUMERO DIGITADO A AX
    MOV BX,NUM2             ;MUEVE SEGUNDO NUMERO DIGITADO A BX
    MUL BX                  ;AX = AX*BX
    CALL PRINT_NUM
    
    ;---------------------------
        
    ;DIVISION
    MOV AH,09
    LEA DX,TEXTO6
    INT 21H
    XOR DX,DX               ;DEJA EN CERO DX; SI NO LO HAGO SE DESBORDA LA DIVISION
    
    ;OPERACION Y RESULTADO
    MOV AX,NUM1             ;DX ALMACENA EL MODULO DE LA DIVISION, POR ESO HAY Q DEJARLO EN CERO
    MOV BX,NUM2             ;MUEVE PRIMER NUMERO DIGITADO A AX
    DIV BX                  ;MUEVE SEGUNDO NUMERO DIGITADO A BX
    CALL PRINT_NUM          ;AX = AX*BX
    
