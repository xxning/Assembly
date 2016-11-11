DATA_SEG	SEGMENT	'DATA'
	PROMPT  DB  'LAB1:PB13011066 $'
        NUM 	DB  01H,02H,03H,04H,05H,06H
            	DB  07H,08H,09H,0AH,0BH,0CH
            	DB  0DH,0EH,0FH,10H,11H,12H
            	DB  13H,14H,15H,16H,17H,18H
            	DB  19H,1AH,1BH,1CH,1DH,1DH
            	DB  1FH,20H,21H,22H,23H,24H

	TEN	DB  0AH			;����10
DATA_SEG	ENDS

CODE_SEG	SEGMENT	'CODE'
	ASSUME	CS:CODE_SEG,DS:DATA_SEG

	MAIN	PROC	FAR
		MOV AX,DATA_SEG
		MOV DS,AX		;����DS�Ĵ���

		MOV DX,OFFSET PROMPT
		MOV AH,09H
		INT 21H
		MOV DL,0AH
        	MOV AH,6
        	INT 21H 		;�����ʾ��Ϣ
	
	        MOV BX,-1    		;BX������ѭ��
	LOOP1:  ADD BX,1		
        	MOV AL,6		
        	MUL BL
        	MOV DI,AX
        	MOV CX,0		;CX������ѭ��
        	SUB DI,1
	LOOP2:  ADD DI,1D
        	JMP DISPLAY_NUM		;��ʾ����

	 RET1:  ADD CX,1		
        	JMP LOOP2		;���������������
         RET2:	CMP BX,5
        	JNE LOOP1		;��ѭ��δ������������һ��
        	JMP EXIT		;�����˳�����

	
DISPLAY_NUM: 	MOV AL,BYTE PTR NUM[DI]	;������ƫ����DI�������ֽ�����
		MOV AH,0		
		DIV BYTE PTR TEN	;�����ݳ���10���ֱ���AL��AH�õ��̺�����
        	MOV DL,AL
		MOV DH,AH		;��AX�Ľ�����Ƶ�DX�еȴ����	
	        CMP DL,0H			
		JE  LOWONLY		;���DLΪ0����ʮλΪ0��ֻҪ�����λ
		ADD DL,30H		
		MOV AH,06H
		INT 21H			;��������̶�ASCII�벢���
	LOWBIT:	MOV DL,DH
		ADD DL,30H
		MOV AH,06H
		INT 21H			;�����λ
		CMP CX,BX		
		JE  PRINT_NL		;���к��������������з�
        	JMP PRINT_BL		;��������ո�

     LOWONLY:   MOV DL,20H
        	MOV AH,6
        	INT 21H
		JMP LOWBIT		;���һ���ո����ڶ���

    PRINT_NL:   MOV DL,0AH
        	MOV AH,6
        	INT 21H
        	JMP RET2		;������У������ص���ѭ��

    PRINT_BL:   MOV DL,20H
        	MOV AH,6
        	INT 21H
        	JMP RET1		;����ո񣬲����ص���ѭ��
	
	EXIT:	MOV	AH,4CH		
		INT 	21H		;����DOS��ʾ��

	MAIN	ENDP
CODE_SEG	ENDS
		END	MAIN

              
                