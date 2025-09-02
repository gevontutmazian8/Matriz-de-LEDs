.include "m328pdef.inc"

.org 0x00
    rjmp inicio

; ---------------------------
; Carita feliz - patrón 8x8
; Cada byte representa una fila (de arriba a abajo)
; Bit 0 = columna 1 (izquierda), bit 7 = columna 8 (derecha)
; ---------------------------
carita:
    .db 0b00111100
    .db 0b01000010
    .db 0b10100101
    .db 0b10000001
    .db 0b10100101
    .db 0b10011001
    .db 0b01000010
    .db 0b00111100

; ---------------------------
; Configuración de puertos
; ---------------------------
inicio:
    ; Configurar columnas (Y1–Y8) como salida
    sbi DDRB, 1 ; D9  = Y1
    sbi DDRB, 2 ; D10 = Y2
    sbi DDRB, 3 ; D11 = Y3
    sbi DDRB, 4 ; D12 = Y4
    sbi DDRB, 5 ; D13 = Y5
    sbi DDRC, 0 ; A0  = Y6
    sbi DDRC, 1 ; A1  = Y7
    sbi DDRC, 2 ; A2  = Y8

    ; Configurar filas (X1–X8) como salida
    sbi DDRD, 5 ; D5  = X1
    sbi DDRD, 2 ; D2  = X2
    sbi DDRD, 3 ; D3  = X3
    sbi DDRD, 4 ; D4  = X4
    sbi DDRD, 6 ; D6  = X5
    sbi DDRD, 7 ; D7  = X6
    sbi DDRC, 3 ; A3  = X7
    sbi DDRB, 0 ; D8  = X8

; ---------------------------
; Bucle principal
; ---------------------------
loop_principal:
    ldi r16, 0 ; índice de columna

bucle_matriz:
    ; Cargar dirección del patrón en Z
    ldi ZH, high(carita << 1)
    ldi ZL, low(carita << 1)
    add ZL, r16 ; avanzar al byte de fila correspondiente

    lpm r17, Z ; leer byte desde flash a r17

    rcall mostrar_fila
    rcall activar_columna
    rcall retardo

    inc r16
    cpi r16, 8
    brne bucle_matriz

    rjmp loop_principal

; ---------------------------
; Mostrar patrón en las filas
; ---------------------------
mostrar_fila:
    ; Apagar todas las filas (poner en HIGH)
    sbi PORTD, 2
    sbi PORTD, 3
    sbi PORTD, 4
    sbi PORTD, 5
    sbi PORTD, 6
    sbi PORTD, 7
    sbi PORTB, 0
    sbi PORTC, 3

    ldi r18, 0 ; índice de bit/fila

siguiente_fila:
    bst r17, 0 ; copiar bit 0 de r17 a T flag
    brts ignorar ; si es 1, no hacer nada (LED apagado)

    ; Si el bit es 0, activar la fila (poner LOW correspondiente)
    ldi r19, 0
    cp r18, r19
    breq fx1
    ldi r19, 1
    cp r18, r19
    breq fx2
    ldi r19, 2
    cp r18, r19
    breq fx3
    ldi r19, 3
    cp r18, r19
    breq fx4
    ldi r19, 4
    cp r18, r19
    breq fx5
    ldi r19, 5
    cp r18, r19
    breq fx6
    ldi r19, 6
    cp r18, r19
    breq fx7
    ldi r19, 7
    cp r18, r19
    breq fx8
    rjmp continuar

fx1: cbi PORTD, 5 ; X1
     rjmp continuar
fx2: cbi PORTD, 2 ; X2
     rjmp continuar
fx3: cbi PORTD, 3 ; X3
     rjmp continuar
fx4: cbi PORTD, 4 ; X4
     rjmp continuar
fx5: cbi PORTD, 6 ; X5
     rjmp continuar
fx6: cbi PORTD, 7 ; X6
     rjmp continuar
fx7: cbi PORTC, 3 ; X7
     rjmp continuar
fx8: cbi PORTB, 0 ; X8
     rjmp continuar

ignorar:
continuar:
    lsr r17       ; correr r17 una posición a la derecha
    inc r18
    cpi r18, 8
    brne siguiente_fila
    ret

; ---------------------------
; Activar columna actual
; ---------------------------
activar_columna:
    ; Apagar todas las columnas (LOW = OFF)
    cbi PORTB, 1
    cbi PORTB, 2
    cbi PORTB, 3
    cbi PORTB, 4
    cbi PORTB, 5
    cbi PORTC, 0
    cbi PORTC, 1
    cbi PORTC, 2

    ; Activar columna correspondiente (HIGH = ON)
    ldi r30, 0
    cp r16, r30
    breq col0
    ldi r30, 1
    cp r16, r30
    breq col1
    ldi r30, 2
    cp r16, r30
    breq col2
    ldi r30, 3
    cp r16, r30
    breq col3
    ldi r30, 4
    cp r16, r30
    breq col4
    ldi r30, 5
    cp r16, r30
    breq col5
    ldi r30, 6
    cp r16, r30
    breq col6
    ldi r30, 7
    cp r16, r30
    breq col7
    ret

col0: sbi PORTB, 1 ; Y1
      ret
col1: sbi PORTB, 2 ; Y2
      ret
col2: sbi PORTB, 3 ; Y3
      ret
col3: sbi PORTB, 4 ; Y4
      ret
col4: sbi PORTB, 5 ; Y5
      ret
col5: sbi PORTC, 0 ; Y6
      ret
col6: sbi PORTC, 1 ; Y7
      ret
col7: sbi PORTC, 2 ; Y8
      ret

; ---------------------------
; Retardo simple
; ---------------------------
retardo:
    ldi r20, 50
r1: ldi r21, 255
r2: dec r21
    brne r2
    dec r20
    brne r1
    ret
