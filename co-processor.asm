
data_seg	segment	'data'
        datax            dd    0.0
        dataa1           dd    0.0
        dataa2           dd    0.0
        dataa3           dd    0.0
	inputmessage	 db    0ah ,'input X,A1,A2,A3:' , '$' 
	errormessage	 db    0ah ,'error!' , '$'
        buf              dd    0
        wan              dd    10000.0
        ten              dd    10.0
        tenn             dw    10
        four             dd    4.0
        three            dd    3.0
        two              dd    2.0
        one              dd    1.0
        zero             dd    0.0
        conste           dd    2.718281828459 
        con256           dw    256
        mfchss           db    0      
        mweishu          db    0
        weishu           dw    0  
        tiaoshi          dd    0
        data01           dd    0.0
        data02           dd    0.0
        data03           dd    0.0
        data04           dd    0.0
        data05           dd    0.0
        data06           dd    0.0
        data07           dd    0.0
        data08           dd    0.0
        num              dw    0
       mem16             dw    0
data_seg	ends
STACK_SEG       segment stack 
        dw 1024 dup(0)
STACK_SEG ends
code_seg	segment	'code'
	assume	CS:CODE_SEG,SS:STACK_SEG,DS:DATA_SEG
	main	proc	far
		mov	ax,data_seg
		mov	ds,ax
		
                mov dx , offset inputmessage	
                mov ah , 9
                int 21h    

 
                mov mfchss,0  
                mov mweishu,0
                mov weishu,0
              
               fld zero
               
readin1:
                mov ah,1
                int 21h
                mov bl,al
                cmp bl,'-'
                jne nextt1
                mov dx , offset errormessage	
                mov ah , 9
                int 21h  
                mov	ah,4ch
		int 	21h
                
nextt1:
                cmp bl,' '
                je  endd1
                cmp bl,'.'
                jne nextt2
                mov mweishu,1
                jmp readin1
nextt2:
                cmp mweishu,1
                jne nextt3
                mov ax,weishu
                add ax,1
                mov weishu,ax
nextt3:         
                sub bl,48
                fmul ten
                mov byte ptr buf[0],bl
                fiadd dword ptr buf
                
               
   
                jmp readin1
endd1:          
                mov bx,0
              
                
               


stt1:           
                fdiv ten
                add bx,1
                cmp bx,weishu
                jbe  stt1
                fmul ten
                cmp  mfchss,1
                jne  nextt4
                fchs
nextt4: 
                
               fstp datax      
                
      
               
  


;==================∂¡»ÎA1===============================================
                             mov mfchss,0  
                mov mweishu,0
                mov weishu,0
              
                fld zero
               
readin1_2:
                mov ah,1
                int 21h
                mov bl,al
                cmp bl,'-'
                jne nextt1_2
                mov mfchss,1
                jmp readin1_2
nextt1_2:
                cmp bl,' '
                je  endd1_2
                cmp bl,'.'
                jne nextt2_2
                mov mweishu,1
                jmp readin1_2
nextt2_2:
                cmp mweishu,1
                jne nextt3_2
                mov ax,weishu
                add ax,1
                mov weishu,ax
nextt3_2:         
                sub bl,48
                fmul ten
                mov byte ptr buf[0],bl
                fiadd dword ptr buf
               
   
                jmp readin1_2
endd1_2:          
                mov bx,0
stt1_2:           
                fdiv ten
                add bx,1
                cmp bx,weishu
                jbe  stt1_2
                fmul ten
                cmp  mfchss,1
                jne  nextt4_2
                fchs
nextt4_2: 
                
                fstp dataa1

;=============================================a2=====================================

                mov mfchss,0  
                mov mweishu,0
                mov weishu,0
              
                fld zero
               
readin1_3:
                mov ah,1
                int 21h
                mov bl,al
                cmp bl,'-'
                jne nextt1_3
                mov mfchss,1
                jmp readin1_3
nextt1_3:
                cmp bl,' '
                je  endd1_3
                cmp bl,'.'
                jne nextt2_3
                mov mweishu,1
                jmp readin1_3
nextt2_3:
                cmp mweishu,1
                jne nextt3_3
                mov ax,weishu
                add ax,1
                mov weishu,ax
nextt3_3:         
                sub bl,48
                fmul ten
                mov byte ptr buf[0],bl
                fiadd dword ptr buf
               
   
                jmp readin1_3
endd1_3:          
                mov bx,0
stt1_3:           
                fdiv ten
                add bx,1
                cmp bx,weishu
                jbe  stt1_3
                fmul ten
                cmp  mfchss,1
                jne  nextt4_3
                fchs
nextt4_3: 
                
                fstp dataa2

;================================================a3=========================================
              

                mov mfchss,0  
                mov mweishu,0
                mov weishu,0
              
                fld zero
               
readin1_4:
                mov ah,1
                int 21h
                mov bl,al
                cmp bl,'-'
                jne nextt1_4
                mov mfchss,1
                jmp readin1_4
nextt1_4:
                cmp bl,' '
                je  endd1_4
                cmp bl,'.'
                jne nextt2_4
                mov mweishu,1
                jmp readin1_4
nextt2_4:
                cmp mweishu,1
                jne nextt3_4
                mov ax,weishu
                add ax,1
                mov weishu,ax
nextt3_4:         
                sub bl,48
                fmul ten
                mov byte ptr buf[0],bl
                fiadd dword ptr buf
               
   
                jmp readin1_4
endd1_4:          
                mov bx,0
stt1_4:           
                fdiv ten
                add bx,1
                cmp bx,weishu
                jbe  stt1_4
                fmul ten
                cmp  mfchss,1
                jne  nextt4_4
                fchs
nextt4_4: 
                
                fstp dataa3

;====================================º∆À„=============================
  
               fld datax
               fsqrt
               fmul dataa1
               fstp data01
               
               fld datax
               fld conste
               fyl2x
               fst data03
               frndint 
               fst data04
               fld data03
               fsub data04
               f2xm1
               fadd one
               fscale 
               fmul dataa2
               
               
               
               fadd data01
               
               fstp data02
;==================================== ‰≥ˆdata02================================
                mov dl,10
                mov ah,06
                int 21h

                fld data02
                ftst
       
		fstsw	mem16
		mov 	ax,mem16
		sahf   
		ja		f1
                mov dx,'-'
                mov ah,06
                int 21h
f1:
                fabs
                fstp data02
                
                fld data02
                fmul ten
                fmul ten
                frndint
                fistp tiaoshi
                
                mov cl,byte ptr tiaoshi[3]
                mov ax,0
                mov ch,0
                add ax,cx
                mul con256
                mov cl,byte ptr tiaoshi[2]
                mov ch,0
                add ax,cx
                mul con256
                mov cl,byte ptr tiaoshi[1]
                mov ch,0
                add ax,cx
                mul con256
                mov cl,byte ptr tiaoshi[0]
                mov ch,0
                add ax,cx

                mov bx,0
                
 stt2:          cmp ax,0
                je endd2
                mov cx,10
                div cx
                push dx
                add bx,1
                mov dx,0
                jmp stt2


endd2:           
                mov  num,bx
                mov  bx,0
 
stt3:            
                cmp bx,num
                jae endd3
                mov dx,num
                sub dx,bx
                cmp  dx,2
                jne  nextt5
                mov dx,'.'
                mov ah,6
                int 21h
nextt5:
                add bx,1
                pop dx
                add dx,48
                mov ah,6
                int 21h
                jmp stt3
endd3:
         
                
               
                
               
		mov	ah,4ch
		int 	21h
	main	endp
code_seg	ends
		end	main
