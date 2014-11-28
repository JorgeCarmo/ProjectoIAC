; Projecto
; Definicao de constantes
CR 		EQU 	0Ah
FIM_TEXTO 	EQU 	'@'
INT_MASK_ADDR   EQU     FFFAh
INT_MASK        EQU     1000101010000001b
INT_MASKINI	EQU	0000000000000010b
IO_READ 	EQU 	FFFFh
IO_POS		EQU 	FFFCh
IO_WRITE 	EQU 	FFFEh
SP_INICIAL	EQU 	E000h
Mais		EQU	2Bh
Menos		EQU	2Dh
Traco		EQU	7Ch
Jog1		EQU	23h
Jog2		EQU	58h
INIText1	EQU	0C21h
INIText2	EQU 	0D1Ch
ProxPos1	EQU	4001h
ProxPos2	EQU	4002h
Pos1		EQU	4003h
Pos2		EQU	4004h
Esquerda	EQU	4005h
Direita		EQU	4006h
Cima		EQU	4007h
Baixo		EQU	4008h
Temporizador	EQU	FFF6h
INITemp		EQU	FFF7h
Nivel1R5	EQU	100d
Nivel2R5	EQU	200d
Nivel3R5	EQU	400d
Nivel4R5	EQU	600d


		ORIG 	8000h
VarTexto1	STR 	'Bem-vindo ao TRON ', FIM_TEXTO
VarTexto2 	STR 	'Pressiona I1 para comecar ', FIM_TEXTO


		ORIG	FE00h
INT0 		WORD	J2E				
INT1		WORD	Comeca
INT2		WORD	J1D
INT3		WORD	J1E
INT4		WORD	J2D
		ORIG    FE0Fh
INTF            WORD    Timer

		ORIG	0000h
		JMP 	Inicio

Comeca:		MOV	R1, R0
		RTI

Timer:		MOV	R1, 0001h
		MOV	M[INITemp], R1
		DEC	R5
		INC	R7
		RTI

J2E:		MOV	R3, Esquerda
		RTI

J2D:		MOV	R3, Direita
		RTI

J1E:		MOV	R2, Esquerda
		RTI

J1D:		MOV	R2, Direita
		RTI

; --------------------------------------------------------------------
; ---------------------Escrita de Janela------------------------------
; --------------------------------------------------------------------



EscMais:	MOV	R1, 0110h
		MOV	M[IO_POS], R1
		MOV	R2, R1
		ADD	R2, SP_INICIAL
		MOV	R1, Mais
		MOV	M[R2], R1
		MOV 	M[IO_WRITE], R1
			
		MOV	R1, 0141h
		MOV 	M[IO_POS], R1
		MOV	R2, R1
		ADD	R2, SP_INICIAL
		MOV	R1, Mais
		MOV	M[R2], R1
		MOV 	M[IO_WRITE], R1
			
		MOV	R1, 1610h
		MOV 	M[IO_POS], R1
		MOV	R2, R1
		ADD	R2, SP_INICIAL
		MOV	R1, Mais
		MOV	M[R2], R1
		MOV 	M[IO_WRITE], R1
			
		MOV	R1, 1641h
		MOV 	M[IO_POS], R1		
		MOV	R2, R1			
		ADD	R2, SP_INICIAL
		MOV	R1, Mais
		MOV	M[R2], R1
		MOV 	M[IO_WRITE], R1
		RET

CicloTraco1:	MOV	R3, 0210h
CicloTra1:	MOV 	M[IO_POS], R3
		MOV	R2, R3
		ADD	R2, SP_INICIAL
		MOV	R1, Traco
		MOV	M[R2], R1
		MOV 	M[IO_WRITE], R1
		ADD	R3, 0100h
		CMP	R3, 1610h
		BR.NZ	CicloTra1
		RET
			
CicloTraco2:	MOV	R3, 0241h
CicloTra2:	MOV 	M[IO_POS], R3
		MOV	R2, R3
		ADD	R2, SP_INICIAL
		MOV	R1, Traco
		MOV	M[R2], R1
		MOV	M[IO_WRITE], R1
		ADD	R3, 0100h
		CMP	R3, 1641h
		BR.NZ	CicloTra2
		RET
			
CicloMenos1:	MOV	R3, 0111h
CicloMe1:	MOV 	M[IO_POS], R3
		MOV	R2, R3
		ADD	R2, SP_INICIAL
		MOV	R1, Menos
		MOV	M[R2], R1
		MOV	M[IO_WRITE], R1
		ADD	R3, 0001h
		CMP	R3, 0141h
		BR.NZ	CicloMe1
		RET
			
CicloMenos2:	MOV	R3, 1611h
CicloMe2:	MOV	M[IO_POS], R3
		MOV	R2, R3
		ADD	R2, SP_INICIAL
		MOV	R1, Menos
		MOV	M[R2], R1
		MOV 	M[IO_WRITE], R1
		ADD	R3, 0001h
		CMP	R3, 1641h
		BR.NZ	CicloMe2
		RET
			
Jogador1:	MOV	R1, 0c19h			;Posicao do primeiro Jogador
		MOV	M[IO_POS], R1
		MOV	R4, R1		
		MOV	R2, R1			
		ADD	R2, SP_INICIAL
		MOV	R1, Jog2
		MOV	M[R2], R1
		MOV	M[IO_WRITE], R1
		RET
			
Jogador2:	MOV	R1, 0c38h			;Posicao do Segundo Jogador
		MOV 	M[IO_POS], R1
		MOV	R5, R1		
		MOV	R2, R1			
		ADD	R2, SP_INICIAL
		MOV	R1, Jog1
		MOV	M[R2], R1
		MOV	M[IO_WRITE], R1
		RET



EscCar:		PUSH 	R1
		MOV 	R1, M[SP+3]
		MOV 	M[IO_WRITE], R1
		POP 	R1
		RETN 	1

EscString:     	PUSH    R1
               	PUSH    R2
Ciclo:          MOV 	M[IO_POS], R6
		MOV     R1, M[R2]
                CMP     R1, FIM_TEXTO
                JMP.Z    FimEsc
		PUSH	R1
                CALL    EscCar
                INC     R2
		INC	R6
                BR      Ciclo
FimEsc:         POP     R2
                POP     R1
                RET





;-------------------------------------------------------------------------

Inicio:         MOV     R7, SP_INICIAL
                MOV     SP, R7
		MOV     R7, INT_MASKINI
                MOV     M[INT_MASK_ADDR], R7
		MOV	R2, FFFFh
		MOV	M[IO_POS], R2
		MOV     R2, VarTexto1
		MOV	R6, INIText1
		MOV	M[IO_POS], R6
                CALL    EscString
		MOV     R2, VarTexto2
		MOV	R6, INIText2
		MOV	M[IO_POS], R6
                CALL    EscString
		ENI
		MOV	R1, 0001h
		CMP	R1, R0
		BR.NZ	-2
		MOV	R2, FFFFh
		MOV	M[IO_POS], R2
		CALL	EscMais
		CALL	CicloTraco1
		CALL	CicloTraco2
		CALL	CicloMenos1
		CALL	CicloMenos2
		CALL	Jogador1
		CALL	Jogador2
		MOV     R7, INT_MASK
                MOV     M[INT_MASK_ADDR], R7
		ENI
		JMP	JogoComeca
		
Fim:            BR      -1






;----------------------------------------------------------------------------------------------



;Posicao Jog1= R4, Jog2= R5  ---- usar pilha




JogoComeca: 	MOV	R7, R0
		MOV	R1, 1h
		MOV	M[Temporizador], R1		
		MOV	M[INITemp], R1
		MOV	R5, 7d
		MOV	R2, Baixo
		MOV	M[ProxPos1], R2
		MOV	R2, Cima
		MOV	M[ProxPos2], R2			
CicloTimer:	MOV	R2, R0
		MOV	R3, R0
		CMP	R5, R0
		BR.NZ	-2
Movimentos1:	CMP	R2, Esquerda
		JMP.Z	EsqJog1
		CMP	R2, Direita
		JMP.Z	DirJog1
Movimentos2:	CMP	R3, Esquerda
		JMP.Z	EsqJog2
		CMP	R3, Direita
		JMP.Z	DirJog2
		

FimMovimentos:	CALL	VerificaNivel	;Chamar a funcao que faz os movimentos dos jogadores em relacao a ProxPos1 e ProxPos2
		

MovJog1:	MOV	M[ProxPos1], R4
		CMP	R4, Cima
		JMP.Z	MJ1C
		CMP	R4, Baixo
		JMP.Z	MJ1B
		CMP	R4, Direita
		JMP.Z	MJ1B
		JMP	MJ1E

MovJog2:	MOV	M[ProxPos2], R4
		CMP	R4, Cima
		JMP.Z	MJ2C
		CMP	R4, Baixo
		JMP.Z	MJ2B
		CMP	R4, Direita
		JMP.Z	MJ2B
		JMP	MJ2E

MJ1C:		MOV	R4, M[SP+2]
		SUB	R4, 0100h
		MOV	M[IO_POS], R4
		MOV	R4, Jog1
		MOV	M[IO_WRITE], R4
		JMP	MovJog2

MJ1B:		MOV	R4, M[SP+2]
		ADD	R4, 0100h
		MOV	M[IO_POS], R4
		MOV	R4, Jog1
		MOV	M[IO_WRITE], R4
		JMP	MovJog2

MJ1E:		MOV	R4, M[SP+2]
		DEC	R4
		MOV	M[IO_POS], R4
		MOV	R4, Jog1
		MOV	M[IO_WRITE], R4
		JMP	MovJog2

MJ1D:		MOV	R4, M[SP+2]
		INC	R4
		MOV	M[IO_POS], R4
		MOV	R4, Jog1
		MOV	M[IO_WRITE], R4
		JMP	MovJog2



;------------------escreve movimento jogador 2

MJ2C:		MOV	R4, M[SP+1]
		SUB	R4, 0100h
		MOV	M[IO_POS], R4
		MOV	R4, Jog2
		MOV	M[IO_WRITE], R4
		JMP	FimMovimentos

MJ2B:		MOV	R4, M[SP+1]
		ADD	R4, 0100h
		MOV	M[IO_POS], R4
		MOV	R4, Jog2
		MOV	M[IO_WRITE], R4
		JMP	FimMovimentos

MJ2E:		MOV	R4, M[SP+1]
		DEC	R4
		MOV	M[IO_POS], R4
		MOV	R4, Jog2
		MOV	M[IO_WRITE], R4
		JMP	FimMovimentos

MJ2D:		MOV	R4, M[SP+1]
		INC	R4
		MOV	M[IO_POS], R4
		MOV	R4, Jog2
		MOV	M[IO_WRITE], R4
		JMP	FimMovimentos







VerificaNivel:	CMP	R7, Nivel1R5
		JMP.N	Nivel1
		CMP	R7, Nivel2R5
		JMP.N	Nivel2
		CMP	R7, Nivel3R5
		JMP.N	Nivel3
		CMP	R7, Nivel4R5
		JMP.N	Nivel4
		JMP	Nivel5
		; apos cada mudanca de nivel aumentar os leds
Nivel1:		MOV	R5, 7d
		JMP	CicloTimer

Nivel2:		MOV	R5, 5d
		JMP	CicloTimer

Nivel3:		MOV	R5, 3d
		JMP	CicloTimer

Nivel4:		MOV	R5, 2d
		JMP	CicloTimer
	
Nivel5:		MOV	R5, 1d
		JMP	CicloTimer


EsqJog1:	PUSH	R6
		MOV	R6, Direita
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Cima
		
		MOV	R6, Esquerda
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Baixo

		MOV	R6, Cima
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Esq

		MOV	R6, Baixo
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Esq		


DirJog1:	PUSH	R6
		MOV	R6, Direita
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Baixo
		
		MOV	R6, Esquerda
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Cima

		MOV	R6, Cima
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Dir	

		MOV	R6, Baixo
		CMP	M[ProxPos1], R6
		JMP.Z	Jog1Dir		

EsqJog2:	PUSH	R6
		MOV	R6, Direita
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Cima
		
		MOV	R6, Esquerda
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Baixo

		MOV	R6, Cima
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Esq

		MOV	R6, Baixo
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Esq		

DirJog2:	PUSH	R6
		MOV	R6, Direita
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Baixo
		
		MOV	R6, Esquerda
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Cima

		MOV	R6, Cima
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Dir	

		MOV	R6, Baixo
		CMP	M[ProxPos2], R6
		JMP.Z	Jog2Dir		

Jog1Esq:	MOV	R6, Esquerda
		MOV	M[ProxPos1], R6
		POP	R6
		JMP	Movimentos2

Jog1Dir:	MOV	R6, Direita
		MOV	M[ProxPos1], R6
		POP	R6
		JMP	Movimentos2

Jog1Cima:	MOV	R6, Cima
		MOV	M[ProxPos1], R6
		POP	R6
		JMP	Movimentos2

Jog1Baixo:	MOV	R6, Baixo
		MOV	M[ProxPos1], R6
		POP	R6
		JMP	Movimentos2
		
Jog2Esq:	MOV	R6, Esquerda
		MOV	M[ProxPos2], R6
		POP	R6
		JMP	MovJog1

Jog2Dir:	MOV	R6, Direita
		MOV	M[ProxPos2], R6
		POP	R6
		JMP	MovJog1

Jog2Cima:	MOV	R6, Cima
		MOV	M[ProxPos2], R6
		POP	R6
		JMP	MovJog1

Jog2Baixo:	MOV	R6, Baixo
		MOV	M[ProxPos2], R6
		POP	R6
		JMP	MovJog1












