.MODEL SMALL ;TEACHERS ARE REQUIRED TO READ ABOUT
.STACK 100H  ;PROJECT BY BSCS-3E STUDENTS
       ;-----------------------------------------------------------------------------------------------MACROS
PRINT MACRO MSG
       ;THIS MACRO IS RESPONSIBLE TO PRINT ANY STRING SENT AS PARAMETER
       ;ANYTIME A STRING IS TO BE PRINTED, THIS MACRO IS CALLED.
    LEA DX,MSG
    MOV AH,9
    INT 21H
    
ENDM

CALCULATE_TOTAL MACRO NUM
        ;THIS MACRO IS CALLED WHEN TOTAL MATCHSTICKS ARE TO BE CALCULATED
        ;FOR EG: INPUT: USER 1=3
        ;               USER 2=2
        ;TOTAL VARIABLE WILL BE UPDATED TO TOTAL = TOTAL+USER1
        ;                                  TOTAL = TOTAL+USER2
        ;THEREFORE                         TOTAL = 5
    MOV AL,NUM
    ADD TOTAL,AL
    
ENDM
        ;SINCE MACROS CANNOT HAVE DUPLICATE DECLARATIONS OF LABELS
        ;THEREFORE I HAD TO CREATE DIFFERENT ONE FOR U1,U2,COMPUTER.
        
DISPLAY_REMAINING_MATCHSTICKS MACRO NUM
        ;DISPLAYS TOTAL REMAINING MATCHSTICKS VISUALLY
        ;WE KNOW THERE ARE 21 MATCHSTICKS IN TOTAL
        ;THEREFORE WHENEVER THIS MACRO IS CALLED, TOTAL IS SENT AS PARAMETER
        ;PSEUDOCODE:
        ;          SEND TOTAL TO MACRO
        ;          21 MINUS TOTAL
        ;          FOR EG: 21-7 = 14 [ ! ! ! ! ! ! ! ! ! ! ! ! ! ! ]      
    MOV AL,NUM
    MOV BL,21
    MOV CX,0
    SUB BL,AL
    MOV CL,BL
    
    MOV DL,' '
    MOV AH,2
    INT 21H
   
    MOV DL,'['
    MOV AH,2
    INT 21H
    L1:
    PRINT MATCHSTICKS
    LOOP L1:
    MOV DL,']'
    MOV AH,2
    INT 21H
       
ENDM

DISPLAY_USER1_MATCHSTICKS MACRO NUM
        ;DISPLAYS USER 1 SELECTED MATCHSTICKS VISUALLY 
        ;THERE'S A LOOP THAT RUNS THE TIMES USER INPUT AND DISPLAYS MATCHSTICKS.
    MOV BL,NUM
    MOV CX,0
    MOV CL,BL
    
    MOV DL,' '
    MOV AH,2
    INT 21H
    
    MOV DL,'['
    MOV AH,2
    INT 21H
    L2:
    PRINT MATCHSTICKS
    LOOP L2:
    MOV DL,']'
    MOV AH,2
    INT 21H
    
ENDM

DISPLAY_COMPUTER_MATCHSTICKS MACRO NUM
        ;DISPLAYS COMPUTER SELECTED MATCHSTICKS VISUALLY 
        ;THERE'S A LOOP THAT RUNS THE TIMES USER INPUT AND DISPLAYS MATCHSTICKS.
    MOV BL,NUM
    MOV CX,0
    MOV CL,BL
    MOV DL,' '
    MOV AH,2
    INT 21H
    
    MOV DL,'['
    MOV AH,2
    INT 21H
    L3:
    PRINT MATCHSTICKS
    LOOP L3:
    MOV DL,']'
    MOV AH,2
    INT 21H
    
ENDM

DISPLAY_USER2_MATCHSTICKS MACRO NUM
        ;DISPLAYS USER 2 SELECTED MATCHSTICKS VISUALLY 
        ;THERE'S A LOOP THAT RUNS THE TIMES USER INPUT AND DISPLAYS MATCHSTICKS.
    MOV BL,NUM
    MOV CX,0
    MOV CL,BL
    
    MOV DL,' '
    MOV AH,2
    INT 21H
    
    MOV DL,'['
    MOV AH,2
    INT 21H
    L4:
    PRINT MATCHSTICKS
    LOOP L4:
    MOV DL,']'
    MOV AH,2
    INT 21H
    
ENDM



.DATA
       ;DATA SEGMENT CONTAINS ALL THE STRINGS TO BE PRINTED
       ;ASWELL AS ALL VARIABLES REQUIRED TO STORE AND FUNCTION FOR PROGRAM

MAIN_SCREEN DB 10,13,10,13, '--------21 MATCHSTICKS PROBLEM--------'
            DB 10,13, '            ---WELCOME---$'

CHOICE DB 10,13,10,13, '1)USER VS COMPUTER'
       DB 10,13,       '2)USER VS USER'
       DB 10,13,       '3)RULES'
       DB 10,13,       '4)ABOUT PROJECT'
       DB 10,13,       '5)EXIT PROGRAM$'
       
SELECTION DB 10,13,    '---ENTER SELECTION: $'
TOTAL DB ?
COMPUTER_MATCHSTICKS DB ? 
USER1_MATCHSTICKS DB ?
USER2_MATCHSTICKS DB ?
SWITCH DB ?
REM_MATCHSTICKS DB 10,13, 'REMAINING MATCHSTICKS: $'

MATCHSTICKS DB ' ! $'

MSG_GAME_END DB 10,13,10,13, 'PRESS (Y) FOR MAINMENU OR (N) FOR EXIT: $'

MSG0 DB 10,13, 'WRONG INPUT!$'

MSGU1 DB 10,13,10,13, 'USER 1-ENTER CHOICE(1-4 MATCHSTICKS): $'
MSGU2 DB 10,13,       'USER 2-ENTER CHOICE(1-4 MATCHSTICKS): $'

MSGC DB 10,13, 'COMPUTER PICKED: $'

MSG3 DB 10,13,10,13, 'MATCHSTICKS USED: $'

MSG4 DB 10,13, 'YOU LOSE! : YOU PICKED THE LAST MATCHSTICK '
     DB 10,13, '---------------GAME OVER----------------$'
     
     
RULES DB 10,13,10,13, '--------------RULES--------------'
            DB 10,13, '1)THE ONE WHO PICKS THE LAST MATCHSTICK LOOSES'
            DB 10,13, '2)YOU CAN ONLY INPUT BETWEEN 1-4 MATCHSTICKS'
            DB 10,13, '3)YOU CANNOT MAKE THE COMPUTER LOOSE'
            DB 10,13, '4)COMPUTER USES RECURSIVE LOGIC$'

ABOUT DB 10,13,10,13,'--------------ABOUT---------------'      
      DB 10,13, 'PROJECT LEAD:' 
      DB 10,13, '            UZAIR AHMED DAHRAJ'
      DB 10,13, 'MEMBERS:'
      DB 10,13, '       MUHAMMAD AFFAN'
      DB 10,13, '       SHAHZAIB CHUGTAI'
      DB 10,13, '       AMMAR KHOWAJA'
      DB 10,13, '       SHAZAIB SOOMRO'
      DB 10,13, '       SYED HASSAN ALI'
DB 10,13,10,13, 'INSTRUCTORS: (CSC2201)'
      DB 10,13, '           MR. SAQIB SADIQ-THEORY'
      DB 10,13, '           MR. MUBEEN AHMED-LAB$'        
      
EXIT DB 10,13, '--------------EXIT--------------$'       

TH DB ?
TL DB ?

.CODE

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX 
    
    MAIN_MENU:                ;MAIN_MENU
    MOV TOTAL,0
    PRINT MAIN_SCREEN         ;PRINTS MAIN_SCREEN STRING
    PRINT CHOICE              ;PRINTS CHOICE STRING
    CHOICE_SELECTION:         ;IF INPUT IS WRONG, DO NOT PRINT WHOLE MAIN_MENU AGAIN
    PRINT SELECTION           ;THIS IS WHY I CREATED CHOICE_SELECTION LABEL
    MOV AH,1                  ;TAKE USER INPUT
    INT 21H
    SUB AL,48
    CMP AL,5
    JA ERROR_SELECTION        ;JUMP TO ERROR SELECTION LABEL IF INPUT > 5
    CMP AL,1
    JB ERROR_SELECTION        ;JUMP TO ERROR SELECTION LABEL IF INPUT < 1
    CMP AL,1                  
    MOV SWITCH,1              ;SWITCH=1, USED TO TELL PROGRAM ITS USERVSCOMPUTER
    JE USERVSCOMPUTER         
    CMP AL,2
    MOV SWITCH,2              ;SWITCH=2, USED TO TELL PROGRAM ITS USERVSUSER
    JE USERVSUSER             ;THE PURPOSE OF SWITCH IS TO JUMP TO SPECIFIC LABELS
    CMP AL,3                  ;FOR EG YOU SELECTED USERVSUSER
    JE PRINT_RULES            ;SO WHEN THE PROGRAM RUNS IT DOESN'T RUN COMPUTER
    CMP AL,4                  ;LABELS.
    JE PRINT_ABOUT            ;JUMP TO PRINT_ABOUT LABEL
    CMP AL,5
    JE EXIT_PROGRAM           ;JUMP TO EXIT_PROGRAM LABEL
    
    PRINT_RULES:              ;WHEN USER SELECTS TO PRINT RULES IT WILL JUMP TO
    PRINT RULES               ;THIS LABEL AND PRINT RULES
    JMP MAIN_MENU             ;AFTER PRINTING IT WILL JUMP TO MAIN_MENU AGAIN.
    
    PRINT_ABOUT:              ;WHEN USER SELECTES TO PRINT ABOUT IT WILL JUMP TO
    PRINT ABOUT               ;THIS LABEL AND PRINT ABOUT
    JMP MAIN_MENU             ;AFTER PRINTING IT WILL TO MAIN_MENU AGAIN.
    
       ;-----------------------------------------------------------------------------------------------USERVSUSER // USERVSCOMPUTER SWITCH LABEL   
    USERVSCOMPUTER:           ;SWITCH IS SET TO 1,AND IF USER SELECTS
                              ;USERVSCOMPUTER IT WILL JUMP TO THIS LABEL
    USERVSUSER:                                           
    
       ;-----------------------------------------------------------------------------------------------USER 1 INPUT
    
    USER1_INPUT:              ;USER1 INPUT IS DEFINED INSIDE THIS LABEL
    PRINT MSGU1               
    MOV AH,1                  ;ASK USER 1 INPUT
    INT 21H
    SUB AL,48                 ;ASCII ADJUSTMENT 1=48H
                              ;DOING THIS SOLVES THE PROBLEM OF ADDING
                              ;IT TO TOTAL OTHERWISE TOTAL WOULD HAVE BEEN
                              
                              ;FOR EG:TOTAL = TOTAL+48 <- WRONG IMPLEMENTATION
    ;COMPARE IF USER_INPUT IS IN RANGE 1-4
    CMP AL,4 
    JA ERROR_U1 ;(IF USER INPUT > 4)
    CMP AL,1
    JB ERROR_U1 ;(IF USER INPUT < 1)
    
    MOV USER1_MATCHSTICKS,AL
    DISPLAY_USER1_MATCHSTICKS USER1_MATCHSTICKS ;CALL MACRO
    CALCULATE_TOTAL USER1_MATCHSTICKS ;CALLS TOTAL MACRO TO UPDATE TOTAL MATCHSTICKS USED
    CMP TOTAL,20                      
    JA GAME_OVER                      ;IF TOTAL > 20 END GAME
    
    CMP SWITCH,2                      ;IF USERVSUSER JUMP TO USER2 INPUT
    JE USER2_INPUT
    
    JMP COMPUTER_INPUT                ;OTHERWISE JUMP TO COMPUTER INPUT
    
       ;-----------------------------------------------------------------------------------------------COMPUTER INPUT
    
    COMPUTER_INPUT:
    PRINT MSGC    
    MOV COMPUTER_MATCHSTICKS,5
    MOV AL,USER1_MATCHSTICKS
    SUB COMPUTER_MATCHSTICKS,AL
    CALCULATE_TOTAL COMPUTER_MATCHSTICKS  
    MOV DL,COMPUTER_MATCHSTICKS
    ADD DL,48
    MOV AH,2
    INT 21H
    DISPLAY_COMPUTER_MATCHSTICKS COMPUTER_MATCHSTICKS
    JMP PRINT_TOTAL_MATCHSTICKS_USED
     
       ;-----------------------------------------------------------------------------------------------USER 2 INPUT
     
    USER2_INPUT:
    PRINT MSGU2
    MOV AH,1
    INT 21H
    SUB AL,48
    ;COMPARE IF USER2_INPUT IS IN RANGE 1-4
    CMP AL,4 
    JA ERROR_U2 ;(IF USER INPUT > 4)
    CMP AL,1
    JB ERROR_U2 ;(IF USER INPUT < 1)
    MOV USER2_MATCHSTICKS,AL
    CALCULATE_TOTAL USER2_MATCHSTICKS
    DISPLAY_USER2_MATCHSTICKS USER2_MATCHSTICKS
    CMP TOTAL,20
    JA GAME_OVER
    JMP PRINT_TOTAL_MATCHSTICKS_USED
    

    PRINT_TOTAL_MATCHSTICKS_USED:
    PRINT MSG3
    MOV AL,TOTAL
    MOV BL,1 ;ASCII ADJUSTMENT, SO THAT TOTAL IS SPLITED INTO HIGHER AND LOWER BITS.
    MUL BL   ;ALTERNATIVELY AAA COULD BE USED BUT THEN TOTAL HAD TO BE CONVERTED TO WORD BYTE.
    AAM
    MOV TH,AH
    MOV TL,AL
    ADD TH,48
    ADD TL,48
    MOV DL,TH
    MOV AH,2
    INT 21H
    MOV DL,TL
    MOV AH,2
    INT 21H
    
    MOV DL,0AH
    MOV AH,2
    INT 21H
    MOV DL,0DH
    MOV AH,2
    INT 21H
    PRINT REM_MATCHSTICKS
    DISPLAY_REMAINING_MATCHSTICKS TOTAL 
    JMP USER1_INPUT
    
    ERROR_U1:
    PRINT MSG0
    JMP USER1_INPUT
    
    ERROR_U2:
    PRINT MSG0
    JMP USER2_INPUT
    
    ERROR_SELECTION:
    PRINT MSG0
    JMP CHOICE_SELECTION
    
    ERROR_SELECTION_GAME_OVER:
    PRINT MSG0
    JMP SELECTION_GAME_OVER
    
    
    GAME_OVER:
    PRINT MSG4
    SELECTION_GAME_OVER:
    PRINT MSG_GAME_END
    MOV AH,1
    INT 21H
    CMP AL,'Y'
    JE MAIN_MENU
    CMP AL,'y'
    JE MAIN_MENU
    CMP AL,'N'
    JE EXIT_PROGRAM
    CMP AL,'n'
    JE EXIT_PROGRAM
    
    JMP SELECTION_GAME_OVER
     
     
    EXIT_PROGRAM:
    PRINT ABOUT
    PRINT EXIT
    MOV AH,4CH
    INT 21H
    
    
    MAIN ENDP
END MAIN