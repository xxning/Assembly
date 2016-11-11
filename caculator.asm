DATA_SEG	SEGMENT	'DATA'
	buf             dw   2048 dup(0)  
        num             dw   2048 dup(0) 
        fuhao           dw   0
DATA_SEG	ENDS
STACK_SEG       segment stack 
        dw 1024 dup(0)
STACK_SEG ends


CODE_SEG	SEGMENT	'CODE'
	ASSUME	CS:CODE_SEG,SS:STACK_SEG,DS:DATA_SEG
	MAIN	PROC	FAR
		MOV	AX,DATA_SEG
		MOV	DS,AX


		mov ah,01h
                int 21h
                mov cx,0
                mov sp,1
                mov bl,al        ;------------bl读入的字符，cx下标 自此占用------------------
readin:         
                cmp bl,'+'
                je  zjia
                cmp bl,'-'
                je zjian
                cmp bl,'('
                je  zzuo
                cmp bl,')'
                je zyou
                jmp zshu
zjia:           add cx,2
                mov di,cx
                mov buf[di],'+'
                mov sp,1
                jmp nextt
zjian:          add cx,2
                mov di,cx
                mov buf[di],'-'
                mov sp,1
                jmp nextt
zzuo:           add cx,2
                mov di,cx
                mov buf[di],'('
                mov sp,1
                jmp nextt
upp1:            jmp readin
zyou:           add cx,2
                mov di,cx
                mov buf[di],')'
                mov sp,1
                jmp nextt
zshu:
                cmp sp,1
                jne  checkk
                add cx,2
checkk:         mov sp,0 
                mov di,cx
                mov dx,buf[di]
                mov ax,10
                mul dx
                sub bl,48
                mov bh,0
                add ax,bx
                mov buf[di],ax
nextt:
                mov ah,01h
                int 21h
                mov bl,al
                cmp bl,13
                jne upp1          ;                -----------------解除对bl，cx占用
                add cx,2
                mov di,cx
                mov buf[di],'$'

                mov cx,2
                mov bx,0                         ;===================cx为buf下标，bx为num下标
                mov ax,'#'
                push ax
zhzh:           mov di,cx
                mov ax,buf[di]
                cmp ax,'+'
                jne zhzhjia
                pop dx
                cmp dx,'#'
                je  stt01
                cmp dx,'('
                je  stt01
                mov di,bx
                mov num[di],dx
                add bx,2
                jmp stt02
stt01:          push dx
stt02:
                push ax
                jmp nextt2
zhzhjia:        cmp ax,'-'
                jne zhzhjian
                pop dx
                cmp dx,'#'
                je  stt03
                cmp dx,'('
                je  stt03
                mov di,bx
                mov num[di],dx
                add bx,2
                jmp stt04
stt03:          push dx
stt04:
                push ax
                jmp nextt2
zhzhjian:       cmp ax,'('
                jne zhzhzuo
                push ax
                jmp nextt2
zhzhzuo:        cmp ax,')'
                jne zhzhyou
stt1:           pop ax
                cmp ax,'('
                je  nextt2
                mov di,bx
                mov num[di],ax
                add bx,2
                jmp stt1
zhzhyou:        mov di,bx
                mov num[di],ax
                add bx,2      



nextt2:

                add cx,2
                mov di,cx
                cmp buf[di],'$'
                jne zhzh                
                
stt2:           pop ax
                cmp ax,'#'
                je  nextt3
                mov di,bx
                mov num[di],ax
                add bx,2
                jmp stt2   
nextt3:         mov di,bx
                mov num[di],'$'   


;===============================================================以下为运算计算部分代码,bx为num下标===================================================
                
                mov  bx,0
stt3:           mov  di,bx
                mov  cx,num[di]
                cmp  cx,'$'
                je   endd1
                
                cmp cx,'+'
                jne  jisuanjia
                pop  ax
                pop  dx
                add  dx,ax
                push dx      
                jmp nextt4          
jisuanjia:

                cmp cx,'-'
                jne jisuanjian
                pop ax
                pop dx
                sub dx,ax
                push dx
                jmp nextt4
                
jisuanjian:
                push cx
               


nextt4:           
                add bx,2
                jmp stt3
endd1:          
                pop ax   ;====================输出AX=====================
                cmp ax,30000
                jb nextt5
                mov fuhao,1
                sub ax,32768
                mov bx,32768
                sub bx,ax
                mov ax,bx       
nextt5:  
                mov cx,'#'
                push cx
print:          mov cx,10
                mov dx,0
                div cx
                push dx
                cmp ax,0
                jne print

                cmp fuhao,0
                je nextt6
                mov dl,'-'
                mov ah,06h
                int 21h         
nextt6:
                
print2:         pop ax
                cmp ax,'#'
                je  endd2
                mov dx,ax
                add dx,48
                mov ah,06
                int 21h
                jmp print2
endd2:                          
                

                MOV	AH,4CH
		INT 	21H
                
	MAIN	ENDP
CODE_SEG	ENDS
		END	MAIN
		

		
		
	