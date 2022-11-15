; ---------------------------   
;| CALCULADORA BASICA EN ASM |
; ----------------------------
 
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
                                                                           
; -----------------------------------   
;| TITULO,AUTOR DEL PROGRAMA Y CIERRE|
; -----------------------------------                                         
TITULO  DB 13,10, '-CALCULADORA EN ENSAMBLADOR-'
        DB 13,10, '(JUAN MANUEL BARAJAS GOMEZ)$'

CIERRE  DB 13,10,13,10, 'HA SALIDO DEL SISTEMA, HASTA LUEGO'
        DB 13,10, 'AUTOR: JUAN MANUEL BARAJAS GOMEZ$'        
      
; -----------------------   
;| OPCIONES PARA EL MENU |
; -----------------------        
      
OPCIONES DB 13,10,13,10, '-CALCULADORA AVANZADA-'
         DB 13,10,       '1)SUMA'
         DB 13,10,       '2)RESTA'
         DB 13,10,       '3)MULTIPLICACION'
         DB 13,10,       '4)DIVISION'
         DB 13,10,       '0)SALIR'
         DB 13,10,       '#USUARIO: $'
 
; -------------------------------   
;| SOLICITUD DE NUMEROS A OPERAR |
; -------------------------------
TEXTO1  DB 13,10,13,10, 'DIGITE EL PRIMER NUMERO: $'
TEXTO2 DB 13,10,13,10, 'DIGITE EL SEGUNDO NUMERO: $'


; ----------------------------------------   
;| VARIABLES PARA IMPRESION DE RESULTADOS |
; ----------------------------------------
TEXTO3 DB 13,10,13,10, 'SUMA = $'
TEXTO4 DB 13,10,13,10, 'RESTA = $'
TEXTO5 DB 13,10,13,10, 'MULTIPLICACION = $'
TEXTO6 DB 13,10,13,10, 'DISION ES = $'
TEXTO7 DB 13,10,13,10, 'POTENCIA ES = $'

; ---------------------------------   
;| VARIABLES PARA NUMEROS A OPERAR |
; ---------------------------------

NUM1 DW ? ;VARIABLES DE 2 BYTES
NUM2 DW ? ;PARA LOS NUMEROS A OPERAR

;-------------------------------------------------------------------------------------------
INICIO:     
     LEA DX,TITULO    ;IMPRIMIR EL MENSAJE 
     MOV AH,9H
     INT 21H
 
MENU:
     MOV AX,@DATA     ;LLAMAR A .DATA
     MOV DS,AX        ;GUARDAR LOS DATOS EN DS
                   
     LEA DX,OPCIONES   ;IMPRIMIR OPCIONES DE MENU
     MOV AH,9H
     INT 21H                                               

     MOV AH,08              ;PAUSA Y ESPERA A QUE EL USUARIO PRECIONE UNA TECLA
     INT 21H                ;INTERRUPCION PARA CAPTURAR
     
     CMP AL,49              ;OPC 1
     JE LLAMAR_SUMA
     
     CMP AL,50              ;OPC 2
     JE LLAMAR_RESTA
     
     CMP AL,51              ;OPC 3
     JE LLAMAR_MULTIPLICACION
     
     CMP AL,52              ;OPC 4
     JE LLAMAR_DIVISION
     
     CMP AL,48              ;OPC 0
     JE LLAMAR_SALIR
        
; --------------------------   
;| LLAMADAS A PROCEDIMIENTO |
; --------------------------  
     LLAMAR_SUMA:
      CALL SUMA      
     
     LLAMAR_RESTA:
      CALL RESTA
     
     LLAMAR_MULTIPLICACION:
      CALL MULTIPLICACION
     
     LLAMAR_DIVISION:
      CALL DIVISION
      
     LLAMAR_SALIR:
      CALL SALIR

; ----------------   
;| PROCEDIMIENTOS |
; ---------------- 

;SUMA-----------------------------------------------------------------     
    SUMA PROC NEAR
        ;IMPRESION DE SOLICITUD DE NUM1
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO1           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
         
        ;PARA NUM1
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO, SE GUARDA EN CX
        MOV NUM1,CX             ;MUEVE NUMERO A VARIABLE NUM1
            
        ;IMPRESION DE SOLICITUD DE NUM2
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO2           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
        
        ;PARA NUM2
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO; EL VALOR SE GUARDA EN AX
        MOV NUM2,CX 
        
        MOV AH,09
        LEA DX,TEXTO3
        INT 21H
            
        ;OPERACION Y RESULTADO
        MOV AX,NUM1             ;MUEVE PRIMER NUMERO DIGITADO A AX
        ADD AX,NUM2             ;SUMA LOS NUMEROS DIGITADO, QUEDA ALMACENADDO EN AX
                
        CALL PRINT_NUM        
         
        CALL MENU
        RET
SUMA ENDP

;RESTA-----------------------------------------------------------------     
    RESTA PROC NEAR
        ;IMPRESION DE SOLICITUD DE NUM1
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO1           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
         
        ;PARA NUM1
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO, SE GUARDA EN CX
        MOV NUM1,CX             ;MUEVE NUMERO A VARIABLE NUM1
            
        ;IMPRESION DE SOLICITUD DE NUM2
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO2           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
        
        ;PARA NUM2
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO; EL VALOR SE GUARDA EN AX
        MOV NUM2,CX
        
        MOV AH,09
        LEA DX,TEXTO4
        INT 21H
        
        ;OPERACION Y RESULTADO
        MOV AX,NUM1             ;MUEVE PRIMER NUMERO DIGITADO A AX
        SUB AX,NUM2             ;RESTA EL 2DO DEL 1ER NUMERO, QUEDA ALMACENADDO EN AX
        
        CALL PRINT_NUM        
         
        CALL MENU
        RET
RESTA ENDP

;MULTIPLICACION-----------------------------------------------------------------     
    MULTIPLICACION PROC NEAR
        ;IMPRESION DE SOLICITUD DE NUM1
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO1           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
         
        ;PARA NUM1
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO, SE GUARDA EN CX
        MOV NUM1,CX             ;MUEVE NUMERO A VARIABLE NUM1
            
        ;IMPRESION DE SOLICITUD DE NUM2
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO2           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
        
        ;PARA NUM2
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO; EL VALOR SE GUARDA EN AX
        MOV NUM2,CX 
        
        MOV AH,09
        LEA DX,TEXTO5
        INT 21H
        
        ;OPERACION Y RESULTADO
        MOV AX,NUM1             ;MUEVE PRIMER NUMERO DIGITADO A AX
        MOV BX,NUM2             ;MUEVE SEGUNDO NUMERO DIGITADO A BX
        MUL BX                  ;AX = AX*BX
        CALL PRINT_NUM        
         
        CALL MENU
        RET
MULTIPLICACION ENDP
    
;DIVISION-----------------------------------------------------------------     
    DIVISION PROC NEAR
        ;IMPRESION DE SOLICITUD DE NUM1
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO1           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
         
        ;PARA NUM1
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO, SE GUARDA EN CX
        MOV NUM1,CX             ;MUEVE NUMERO A VARIABLE NUM1
            
        ;IMPRESION DE SOLICITUD DE NUM2
        MOV AH,09               ;INTERRUPCION PARA IMPRIMIR EN PANTALLA
        LEA DX,TEXTO2           ;CARGA CADENA DE TEXTO 2 EN DX
        INT 21H
        
        ;PARA NUM2
        CALL SCAN_NUM           ;LLAMA FUNCION SCAN_NUM QUE TOMA NUMERO DE TECLADO; EL VALOR SE GUARDA EN AX
        MOV NUM2,CX 
        
        MOV AH,09
        LEA DX,TEXTO6
        INT 21H
        XOR DX,DX               ;DEJA EN CERO DX; SI NO LO HAGO SE DESBORDA LA DIVISION
        
        ;OPERACION Y RESULTADO
        MOV AX,NUM1             ;DX ALMACENA EL MODULO DE LA DIVISION, POR ESO HAY Q DEJARLO EN CERO
        MOV BX,NUM2             ;MUEVE PRIMER NUMERO DIGITADO A AX
        DIV BX                  ;MUEVE SEGUNDO NUMERO DIGITADO A BX
        CALL PRINT_NUM          ;AX = AX*BX        
         
        CALL MENU
        RET
DIVISION ENDP

;SALIR-----------------------------------------------------------------     
SALIR PROC NEAR
      LEA DX, CIERRE   ;IMPRIMIR OPCIONES DE MENU
      MOV AH,9H
      INT 21H
      
      
      MOV AX,4C00H       
      INT 21H
SALIR ENDP

END MENU  
