; File: lcd_display.asm
; Target: 8051 MCU (Virtual Hardware - MCU 8051 IDE)
; Description: Interfacing a 2x16 LCD to display "IIT BBSR"
; 
; Hardware Pinout:
; Port 1 (P1.0 - P1.7) : LCD Data Bus (D0 - D7)
; P2.0                 : RS (Register Select: 0 = Command, 1 = Data)
; P2.1                 : R/W (Read/Write: 0 = Write, 1 = Read)
; P2.2                 : E (Enable Signal, latches data on falling edge)

ORG 0000H

; --- Initialization Sequence ---
; Standard HD44780 initialization commands
MOV A, #38H         ; Function Set: 8-bit mode, 2 lines, 5x7 font
ACALL COMWD
MOV A, #0EH         ; Display ON, Cursor ON
ACALL COMWD
MOV A, #01H         ; Clear Display
ACALL COMWD
MOV A, #06H         ; Entry Mode Set: Increment cursor after each character
ACALL COMWD
MOV A, #80H         ; Set DDRAM Address: Force cursor to beginning of 1st line
ACALL COMWD

; --- Send Data ("IIT BBSR") ---
MOV A, #'I'
ACALL DATAWRT
MOV A, #'I'
ACALL DATAWRT
MOV A, #'T'
ACALL DATAWRT
MOV A, #' '
ACALL DATAWRT
MOV A, #'B'
ACALL DATAWRT
MOV A, #'B'
ACALL DATAWRT
MOV A, #'S'
ACALL DATAWRT
MOV A, #'R'
ACALL DATAWRT

END_LOOP: 
SJMP END_LOOP       ; Halt program execution

; --- Subroutines ---

COMWD:              ; Send Command to LCD
ACALL READY         ; Poll busy flag before sending new command
MOV P1, A           ; Place command on data bus
CLR P2.0            ; RS = 0 (Select Command Register)
CLR P2.1            ; R/W = 0 (Write Operation)
SETB P2.2           ; E = 1 (Start Enable pulse)
CLR P2.2            ; E = 0 (Complete Enable pulse - data latched)
RET

DATAWRT:            ; Send Data to LCD
ACALL READY         ; Poll busy flag before sending new data
MOV P1, A           ; Place data on data bus
SETB P2.0           ; RS = 1 (Select Data Register)
CLR P2.1            ; R/W = 0 (Write Operation)
SETB P2.2           ; E = 1
CLR P2.2            ; E = 0
RET

READY:              ; Check Busy Flag (Crucial for hardware synchronization)
SETB P1.7           ; Configure P1.7 as input to read busy flag
CLR P2.0            ; RS = 0 (Select Command Register)
SETB P2.1           ; R/W = 1 (Read Operation)
BACK: 
SETB P2.2           ; E = 1
CLR P2.2            ; E = 0
JB P1.7, BACK       ; Jump back if Busy Flag (P1.7) is still high (1)
RET

END
