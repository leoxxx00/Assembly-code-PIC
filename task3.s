#include <xc.inc>  
; Set the configuration
CONFIG  FEXTOSC = OFF, RSTOSC = HFINT32, CLKOUTEN = OFF, CSWEN = ON, FCMEN = ON 
CONFIG  MCLRE = ON, PWRTE = OFF, LPBOREN = ON, BOREN = ON, BORV = LO, ZCD = OFF, PPS1WAY = OFF, STVREN = ON 
CONFIG  WDTCPS = WDTCPS_31, WDTE = OFF, WDTCWS = WDTCWS_7, WDTCCS = SC 
CONFIG  WRT = OFF, SCANE = available, LVP = OFF 
CONFIG  CP = OFF, CPD = OFF 

PSECT code
;Define memory
temp1   EQU     70h       ; Assign memory location for a 8-bit variable temp1 
temp2   EQU     71h       ; Assign memory location for a 8-bit variable temp2 
temp3   EQU     72h	  ; Assign memory location for a 8-bit variable temp3 
org 0x00 ; Start of program
BANKSEL ANSELA		; Select bank A to configure individual pins of PORTA as analog or digital
CLRF    ANSELA          ; Digital I/O for PORTA
BANKSEL PORTA		; Selects the bank for the PORTA(general purpose IO) register and clears its contents
CLRF    PORTA           ; Init PORTA
MOVLW   0xFF		; loads the literal value 0xFF into the working register (WREG)
MOVWF   TRISA           ; Load W register with 0xFF and move it to TRISA register
BANKSEL PORTB		; Selects the bank for the PORTB register 
CLRF    TRISB           ; clears its corresponding TRISB register

LOOP:
; subroutine loop to command led display on switch input
    BTFSC PORTA, 0        ; Test the least significant bit of PORTA (RA0)
    CALL  MoveRightToLeft ; If bit 0 is set, call the MoveRightToLeft subroutine
    BTFSC PORTA, 1        ; Test the next bit of PORTA (RA1)
    CALL  MoveLeftToRight ; If bit 1 is set, call the MoveLeftToRight subroutine
    BTFSC PORTA, 2        ; Test the third bit of PORTA (RA2)
    CALL  MoveRightToLeftAndBack ; If bit 2 is set, call the MoveRightToLeftAndBack subroutine
GOTO LOOP                 ; Go back to the LOOP label and repeat the process
    
MoveRightToLeft:
    CLRF     LATB
    movlw    0b00000001	  ; move binary value to working register to light specified LED
    movwf    LATB         ; Turn on led 
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second ; Call delay 
    movlw    0b00000010	  ; move binary value to working register
    movwf    LATB         ; Turn on led
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second ; Call delay
    movlw    0b00000100	  ; move binary value to working register to light specified LED
    movwf    LATB         ; Turn on led
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second ; Call delay
    movlw    0b00001000	  ; move binary value to working register to light specified LED
    movwf    LATB           ; Turn on led
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second   ; Call delay 
    movlw    0b00010000	  ; move binary value to working register to light specified LED
    movwf    LATB           ; Turn on led
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second   ; Call delay 
    movlw    0b00100000	  ; move binary value to working register to light specified LED
    movwf    LATB           ; Turn on led
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second   ; Call delay
    movlw    0b01000000	  ; move binary value to working register to light specified LED
    movwf    LATB           ; Turn on led
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second   ; Call delay
    movlw    0b10000000	  ; move binary value to working register to light specified LED
    movwf    LATB           ; Turn on led
    CALL CheckButtonState0 ; Check button state for port A, 0 switch
    call     Delay1Second   ; Call delay
    ;goto     LOOP	  ; Go back to LOOP 
    ; Continue this pattern for all 8 LEDs, adjusting delays as needed
    RETURN
MoveLeftToRight:
    CLRF     LATB	; Turn on led 
    movlw    0b10000000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call delay
    movlw    0b01000000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led 
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call delay	
    movlw    0b00100000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led 
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call delay
    movlw    0b00010000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call delay
    movlw    0b00001000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call delay
    movlw    0b00000100 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call delay
    movlw    0b00000010 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call delay
    movlw    0b00000001 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState1 ; Check button state for port A, 1 switch
    call     Delay1Second ; Call 1s delay 
    ; Continue this pattern for all 8 LEDs, adjusting delays as needed
    RETURN
MoveRightToLeftAndBack:
    movlw    0b00000001 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00000010 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay	
    movlw    0b00000100 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00001000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00010000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00100000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b01000000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b10000000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b10000000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b01000000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay	
    movlw    0b00100000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00010000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00001000 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00000100 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay
    movlw    0b00000010 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call 1s delay
    movlw    0b00000001 ; move binary value to working register to light specified LED
    movwf    LATB       ; Turn on led
    CALL CheckButtonState2 ; Check button state for port A, 2 switch
    call     Delay1Second ; Call delay 
    ; Continue this pattern for all 8 LEDs, adjusting delays as needed
    RETURN

Delay1Second:
    ; Set the number of iterations for a 1-second delay
    movlw 0x01   ; Initialize temp1
    movwf temp1	 ; Move the 0x01 to temp1 memory location
    movlw 0x01   ; Initialize temp2 
    movwf temp2	 ; Move the 0x01 to temp1 memory location
    movlw 0x05   ; Initialize temp3 
    movwf temp3	 ; Move the 0x20 to temp1 memory location
del1:
    decfsz temp1, f ;Values in specific file(f) register (temp1) will be decfsz(decerment) 
    goto del1	    ;Go back to del1 
    decfsz temp2, f ;Values in specific file(f) register (temp2) will be decfsz(decerment) 
    goto del1	    ;Go back to del1
    decfsz temp3, f ;Values in specific file(f) register (temp3) will be decfsz(decerment) 
    goto del1	    ;Go back to del1
    RETURN	    ;Return from subroutine
CheckButtonState0:
    BTFSS PORTA, 0         ; Test if the button is not pressed
    GOTO StopLED           ; If button is not pressed, stop the LED
    RETURN
CheckButtonState1:
    BTFSS PORTA, 1         ; Test if the button is not pressed
    GOTO StopLED           ; If button is not pressed, stop the LED
    RETURN
CheckButtonState2:
    BTFSS PORTA, 2         ; Test if the button is not pressed
    GOTO StopLED           ; If button is not pressed, stop the LED
    RETURN
StopLED:
    movlw    0x00 ; move binary value to working register to turn off all LEDs
    movwf    LATB ; Turn off all LEDs
    GOTO LOOP    ; Go back to the main loop