	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 800000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.
	EXPORT VarTime ; Rendue publique temporairement 
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc ; D�but def procedure
	
	    ldr r0,=VarTime ;   		  
						  
		ldr r1,=TimeValue
		str r1,[r0] ; *VarTime = TimeValue 
		
BoucleTempo	
		ldr r1,[r0] ; TimeValue = *VarTime    				
		
		subs r1,#1 ; TimeValue -= 1
		str  r1,[r0] ; *VarTime = TimeValue 
		bne	 BoucleTempo ; bne = branch if not equal
			
		bx lr ; bx = On jump � l'instruction suivant l'invocation de Delay_100ms (on continue l'ex�cution du fichier C ici)
		endp ; Fin def procedure
		
		
	END	