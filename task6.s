 #include <xc.inc>
; Set the configuration word
 CONFIG FEXTOSC=OFF, RSTOSC=HFINT32, CLKOUTEN=OFF, CSWEN=ON, FCMEN=ON
 CONFIG MCLRE = ON, PWRTE = OFF, LPBOREN = ON, BOREN = ON, BORV = LO, ZCD = OFF,PPS1WAY = OFF, STVREN = ON
 CONFIG WDTCPS = WDTCPS_31, WDTE = OFF, WDTCWS = WDTCWS_7, WDTCCS = SC
 CONFIG WRT = OFF, SCANE = available, LVP = OFF
 CONFIG CP = OFF, CPD = OFF
 PSECT code
;Define meomry
 temp1 EQU 70h
 temp2 EQU 71h
 temp3 EQU 72h
 LOOP EQU 74h ;loop counter 1 - general
 LOOPA EQU 75h ;loop counter 2 - LCD use only
 CLKCNT EQU 76h ;125 secs counter
 STORE EQU 77h ;general store
 RSLINE EQU 78h ;bit 4 RS line flag for LCD
 temp01 EQU 79h
 org 00h ; coding begins here
 ; ----Main program starts Here----
START:
 BANKSEL TRISB
 CLRF TRISB ;Port B0-B7 as output
 CALL LCDSET ;Configure the LCD display
 MOVLW 0X80 ;set cursor location at 0x00 of the LCD
 CALL LCDCMD
 CALL LCDMSG ;display message on LCD
 MOVLW 0Xc0 ;set cursor location at 0xc0 of the LCD
 ;line 2 fix....................................................................
 CALL LCDCMD
 CALL LCDMSG1 ;display message on LCD
MAIN:
 GOTO MAIN ;----Assembly language program for interfacing LCD module----
;sub-routine to send a string of LCD command to LCD module
LCDSET:
 call delay2
 CLRF LOOP ;clr LCD set-up loop
 CLRF RSLINE ;clear RS line for instruction send
LCDST2: MOVF LOOP,W ;get table address
 CALL TABLCD ;get set-up instruction
 XORLW 0X00 ;0x00 is the indicator for last LCD instruction
 BTFSC STATUS,2 ;has last LCD set-up instruction now been done?
 GOTO SETEND ;YES, so end the LCD SET routine
 CALL LCDOUT ;No, send the instruction to LCD
 INCF LOOP,F ;inc loop
 GOTO LCDST2 ;get the next set-up instruction
SETEND:
 CALL delay2
 RETURN ;to allow final LCD command to occur, it takes longer than the rest
;sub-routine to send a string of alphanumeric letter to LCD module
LCDMSG: CLRF LOOP ;clear loop
 BSF RSLINE,4 ;set RS for data send
LCDMS2: MOVF LOOP,W ;get table address
 CALL MESSAG ;get message letter
 XORLW 0X00 ;0x00 is the indicator for last data
 BTFSC STATUS,2 ;has last LCD letter been sent?
 GOTO MSGEND ;YES, so end the DATA SEND routine
 CALL LCDOUT ;No, send the data to LCD for display
 INCF LOOP,F ;inc loop
 GOTO LCDMS2 ;repeat for next one letter
 MSGEND: RETURN
;Line 2 fix.....................................................................
LCDMSG1: CLRF LOOP ;clear loop
 BSF RSLINE,4 ;set RS for data send
LCDMS21: MOVF LOOP,W ;get table address
 CALL MESSAG1 ;get message letter
 XORLW 0X00 ;0x00 is the indicator for last data
 BTFSC STATUS,2 ;has last LCD letter been sent?
 GOTO MSGEND1 ;YES, so end the DATA SEND routine
 CALL LCDOUT ;No, send the data to LCD for display
 INCF LOOP,F ;inc loop
 GOTO LCDMS21 ;repeat for next one letter
;line2 retuen...................................................................
MSGEND1: RETURN
;sub-routine to send one byte data to LCD (which can be a command or alphanumeric letter
LCDOUT: MOVWF STORE ;temp store data
 call delay1
 CALL SENDIT ;send MSB
 call delay1
 CALL SENDIT ;send LSB
 RETURN
;used by LCDOUT to send a 4-bit of one byte data to LCD
SENDIT: SWAPF STORE,F ;swap data nibbles
 MOVF STORE,W ;get data byte
 ANDLW 0x0F ;get nibble from byte (LSB)
 IORWF RSLINE,W ;OR the RS bit
 MOVWF LATB ;output the byte
 BSF LATB,5 ;set E line high
 BCF LATB,5 ;set E line low
 RETURN
;sub-routine to send an alphanumeric letter in W register to LCD module
LCDDATA: BSF RSLINE,4 ;set RS=1. This will set the LCD to Data mode
 CALL LCDOUT
 RETURN
;sub-routine to send a LCD command in W register to LCD module
LCDCMD: CLRF RSLINE ;set RS=0. This will set the LCD to Command mode
 CALL LCDOUT
 RETURN
;sub-routine which consists of a string of LCD command to be setup LCD module
;0x00 is an indicator for end of string
TABLCD:
    BRW ;LCD initialisation table
    RETLW 0x28 ;0b00101000 ;Function Set: 4-bit operation data length and 2 display lines
    RETLW 0x0c ;0b00001100 ;Display on/off control;Set entire display on, cursor off, blink off
    RETLW 0b00000110 ;Entry mode set ;Increment with no shift 
    RETLW 0x01 ;0b00000001 ;Clear Display
    RETLW 0x80 ;0b10000000 ;Set cursor to the beginning of the first line because all ADD = 0
    RETLW 0x00 ;0b00000000 ;End of initialisation table
;sub-routine which consists of a string of alphanumeric letters to be displayed on LCD module
;0x00 (or 0) is an indicator for end of string
MESSAG: BRW
 RETLW 0x48 ; 'H';0b01001000
 RETLW 0x54 ; 'T';0b01010100
 RETLW 0x45 ; 'E';0b01000101
 RETLW 0x54 ; 'T';0b01010100
 RETLW 0x00 ;End of string
;family name for line 2.........
MESSAG1: BRW
 RETLW 0x41 ; 'A';0b01000001
 RETLW 0x55 ; 'U';0b01010101
 RETLW 0x4E ; 'N';0b01001110
 RETLW 0x47 ; 'G';0b01000111
 RETLW 0x00 ;End of string
;delay subroutines
delay1:
clrf temp01
del11: decfsz temp01,f
goto del11
 return
delay2:
clrf temp1
movlw 0x01
movwf temp2
;clrf temp2
movlw 0x0f
movwf temp3
del12: decfsz temp1,f
goto del12
decfsz temp2,f
goto del12
decfsz temp3,f
goto del12
return
END ; directive 'end of program'