DATA_SEG	SEGMENT	'DATA'
	PROMPT  DB  'LAB1:PB13011066 $'
        NUM 	DB  01H,02H,03H,04H,05H,06H
            	DB  07H,08H,09H,0AH,0BH,0CH
            	DB  0DH,0EH,0FH,10H,11H,12H
            	DB  13H,14H,15H,16H,17H,18H
            	DB  19H,1AH,1BH,1CH,1DH,1DH
            	DB  1FH,20H,21H,22H,23H,24H

	TEN	DB  0AH			;数字10
DATA_SEG	ENDS

CODE_SEG	SEGMENT	'CODE'
	ASSUME	CS:CODE_SEG,DS:DATA_SEG

	MAIN	PROC	FAR
		MOV AX,DATA_SEG
		MOV DS,AX		;设置DS寄存器

		MOV DX,OFFSET PROMPT
		MOV AH,09H
		INT 21H
		MOV DL,0AH
        	MOV AH,6
        	INT 21H 		;输出提示信息
	
	        MOV BX,-1    		;BX用于行循环
	LOOP1:  ADD BX,1		
        	MOV AL,6		
        	MUL BL
        	MOV DI,AX
        	MOV CX,0		;CX用于列循环
        	SUB DI,1
	LOOP2:  ADD DI,1D
        	JMP DISPLAY_NUM		;显示数字

	 RET1:  ADD CX,1		
        	JMP LOOP2		;增加列数继续输出
         RET2:	CMP BX,5
        	JNE LOOP1		;若循环未结束，跳入下一行
        	JMP EXIT		;否则退出程序

	
DISPLAY_NUM: 	MOV AL,BYTE PTR NUM[DI]	;读入由偏移量DI决定的字节数据
		MOV AH,0		
		DIV BYTE PTR TEN	;将数据除以10，分别在AL，AH得到商和余数
        	MOV DL,AL
		MOV DH,AH		;将AX的结果复制到DX中等待输出	
	        CMP DL,0H			
		JE  LOWONLY		;如果DL为0，则十位为0，只要输出个位
		ADD DL,30H		
		MOV AH,06H
		INT 21H			;否则算出商额ASCII码并输出
	LOWBIT:	MOV DL,DH
		ADD DL,30H
		MOV AH,06H
		INT 21H			;输出个位
		CMP CX,BX		
		JE  PRINT_NL		;若列和行相等则输出换行符
        	JMP PRINT_BL		;否则输出空格

     LOWONLY:   MOV DL,20H
        	MOV AH,6
        	INT 21H
		JMP LOWBIT		;输出一个空格用于对齐

    PRINT_NL:   MOV DL,0AH
        	MOV AH,6
        	INT 21H
        	JMP RET2		;输出换行，并返回到行循环

    PRINT_BL:   MOV DL,20H
        	MOV AH,6
        	INT 21H
        	JMP RET1		;输出空格，并返回到列循环
	
	EXIT:	MOV	AH,4CH		
		INT 	21H		;返回DOS提示符

	MAIN	ENDP
CODE_SEG	ENDS
		END	MAIN

              
                
