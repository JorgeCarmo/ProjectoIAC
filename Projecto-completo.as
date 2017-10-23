; Projecto
; Definicao de constantes
CR 		EQU 	0Ah
FIM_TEXTO 	EQU 	'@'
INT_MASK_ADDR   EQU     FFFAh
INT_MASK        EQU     1000101010000001b
INT_MASKINI	EQU		0000000000000010b
LEDS		EQU		FFF8h
INTS		EQU		FFF9h
IO_READ 	EQU 	FFFFh
IO_POS		EQU 	FFFCh
IO_WRITE 	EQU 	FFFEh
SP_INICIAL	EQU 	E000h
DSP1		EQU		FFF0h
DSP2		EQU		FFF1h
DSP3		EQU		FFF2h
DSP4		EQU		FFF3h
Mais		EQU		2Bh
Menos		EQU		2Dh
Traco		EQU		7Ch
Jog2		EQU		23h
Jog1		EQU		58h
INIText1	EQU		0B21h
INIText2	EQU 	0C1Ch
FIMText1	EQU		0A20h
FIMText2	EQU 	0B1Ah
FIMText3	EQU		0C1Bh
Esquerda	EQU		4005h
Direita		EQU		4006h
Cima		EQU		4007h
Baixo		EQU		4008h
Temporizador	EQU		FFF6h
INITemp		EQU		FFF7h
Nivel1R5	EQU		100d
Nivel2R5	EQU		200d
Nivel3R5	EQU		400d
Nivel4R5	EQU		600d
LCD_PORT	EQU		FFF4h
LCD			EQU		FFF5h


			ORIG 	8000h
VarTexto1	STR 	'Bem-vindo ao TRON ', FIM_TEXTO
VarTexto2 	STR 	'Pressione I1 para comecar ', FIM_TEXTO
FimTexto1	STR		'  Fim do Jogo   ', FIM_TEXTO
FimTexto2	STR		'Pressione I1 para recomecar', FIM_TEXTO
TextoWin1	STR		'O jogador 1 venceu esta ronda', FIM_TEXTO
TextoWin2	STR		'O jogador 2 venceu esta ronda', FIM_TEXTO
Contador	WORD	0007h
Tempo		WORD	0000h
ProxPos1	WORD	Baixo
ProxPos2	WORD	Cima
Vencedor	WORD	0000h
Pos1		WORD	0c19h
Pos2		WORD	0c38h
PosIni1		WORD	0c19h
PosIni2		WORD	0c38h
Posicoes	TAB		1900h
Mais1		WORD	0110h
Mais2		WORD	0141h
Mais3		WORD	1610h
Mais4		WORD	1641h
Menos1		WORD	0111h
Menos2		WORD	1611h
FMenos1		WORD	0141h
FMenos2		WORD	1641h
Traco1		WORD	0210h
Traco2		WORD	0241h
FTraco1		WORD	1610h
FTraco2		WORD	1641h
Tempo1		WORD	48d
Tempo2		WORD	48d
Tempo3		WORD	48d
Tempo4		WORD	48d
Tempo5		WORD	48d
TempoMax1	WORD	48d
TempoMax2	WORD	48d
TempoMax3	WORD	48d
TempoMax4	WORD	48d
Vit11		WORD	48d
Vit21		WORD	48d
Vit12		WORD	48d
Vit22		WORD	48d
TextLCD1	STR		'TEMPO MAX:', FIM_TEXTO
TextLCD2	STR		'J1: ', FIM_TEXTO
TextLCD3	STR		'J2: ', FIM_TEXTO

			ORIG	FE00h
INT0 		WORD	J2E
			ORIG    FE01h				
INT1		WORD	Comeca
			ORIG    FE07h
INT7		WORD	J1D
			ORIG    FE09h
INT9		WORD	J1E
			ORIG    FE0Bh
INTB		WORD	J2D
			ORIG    FE0Fh
INTF        WORD    Timer

			ORIG	0000h
			JMP 	Inicio

Comeca:		MOV		R1, R0
			RTI

Timer:		PUSH	R1
			MOV		R1, 1h
			DEC		M[Contador]
			INC		M[Tempo5]
			MOV		M[Temporizador], R1
			MOV		M[INITemp], R1
			POP		R1
			RTI

J2E:		MOV		R3, Esquerda
			RTI

J2D:		MOV		R3, Direita

			RTI

J1E:		MOV		R2, Esquerda
			RTI

J1D:		MOV		R2, Direita
			RTI

; --------------------------------------------------------------------
; ---------------------Escrita de Janela------------------------------
; --------------------------------------------------------------------



EscMais:	MOV		R1, M[Mais1]
			MOV		M[IO_POS], R1
			ADD		R1, Posicoes
			PUSH	R4
			MOV		R4, 1d
			MOV		M[R1], R4
			POP		R4
			MOV		R1, Mais
			MOV		M[R2], R1
			MOV 	M[IO_WRITE], R1
				
			MOV		R1, M[Mais2]
			MOV 	M[IO_POS], R1
			ADD		R1, Posicoes
			PUSH	R4
			MOV		R4, 1d
			MOV		M[R1], R4
			POP		R4
			MOV		R1, Mais
			MOV		M[R2], R1
			MOV 	M[IO_WRITE], R1
				
			MOV		R1, M[Mais3]
			MOV 	M[IO_POS], R1
			ADD		R1, Posicoes
			PUSH	R4
			MOV		R4, 1d
			MOV		M[R1], R4
			POP		R4
			MOV		R1, Mais
			MOV		M[R2], R1
			MOV 	M[IO_WRITE], R1
				
			MOV		R1, M[Mais4]
			MOV 	M[IO_POS], R1		
			ADD		R1, Posicoes
			PUSH	R4
			MOV		R4, 1d
			MOV		M[R1], R4
			POP		R4
			MOV		R1, Mais
			MOV		M[R2], R1
			MOV 	M[IO_WRITE], R1
			RET

CicloTraco1:	MOV		R3, M[Traco1]
CicloTra1:	MOV 	M[IO_POS], R3
			PUSH	R4
			MOV		R4, R3
			ADD		R4, Posicoes
			PUSH	R1
			MOV		R1, 1d
			MOV		M[R4], R1
			POP		R1
			POP		R4
			MOV		R1, Traco
			MOV		M[R2], R1
			MOV 	M[IO_WRITE], R1
			ADD		R3, 0100h
			CMP		R3, M[FTraco1]
			BR.NZ	CicloTra1
			RET
			
CicloTraco2:	MOV		R3, M[Traco2]
CicloTra2:	MOV 	M[IO_POS], R3
			PUSH	R4
			MOV		R4, R3
			ADD		R4, Posicoes
			PUSH	R1
			MOV		R1, 1d
			MOV		M[R4], R1
			POP		R1
			POP		R4
			MOV		R1, Traco
			MOV		M[R2], R1
			MOV		M[IO_WRITE], R1
			ADD		R3, 0100h
			CMP		R3, M[FTraco2]
			BR.NZ	CicloTra2
			RET
			
CicloMenos1:	MOV		R3, M[Menos1]
CicloMe1:	MOV 	M[IO_POS], R3
			PUSH	R4
			MOV		R4, R3
			ADD		R4, Posicoes
			PUSH	R1
			MOV		R1, 1d
			MOV		M[R4], R1
			POP		R1
			POP		R4
			MOV		R1, Menos
			MOV		M[R2], R1
			MOV		M[IO_WRITE], R1
			ADD		R3, 0001h
			CMP		R3, M[FMenos1]
			BR.NZ	CicloMe1
			RET
			
CicloMenos2:MOV		R3, M[Menos2]
CicloMe2:	MOV		M[IO_POS], R3
			PUSH	R4
			MOV		R4, R3
			ADD		R4, Posicoes
			PUSH	R1
			MOV		R1, 1d
			MOV		M[R4], R1
			POP		R1
			POP		R4
			MOV		R1, Menos
			MOV		M[R2], R1
			MOV 	M[IO_WRITE], R1
			ADD		R3, 0001h
			CMP		R3, M[FMenos2]
			BR.NZ	CicloMe2
			RET
		
; --------------------------------------------------------------------
; ---------------------Escrita dos Jogadores--------------------------
; --------------------------------------------------------------------
			
Jogador1:	MOV		R1, M[PosIni1]	;Posicao do primeiro Jogador
			MOV		M[Pos1], R1
			MOV		M[IO_POS], R1
			PUSH	R4
			MOV		R4, R1
			ADD		R4, Posicoes
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R4
			MOV		R3, Jog1
			MOV		M[IO_WRITE], R3
			RET
			
Jogador2:	MOV		R1, M[PosIni2]			;Posicao do Segundo Jogador
			MOV		M[Pos2], R1
			MOV 	M[IO_POS], R1
			PUSH	R4
			MOV		R4, R1
			ADD		R4, Posicoes
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R4
			MOV		R3, Jog2
			MOV		M[IO_WRITE], R3
			RET

		
; --------------------------------------------------------------------
; ---------------------------Escrita no LCD---------------------------
; --------------------------------------------------------------------


EscSTRLCD:	PUSH	R6
			PUSH	R7
			MOV		R6, 1000000000000000b
			MOV		M[LCD_PORT], R6
			
			MOV		R2, TextLCD1
			MOV		R6, 1000000000000000b
			CALL	EscCarLCD
					
			MOV		R2, TextLCD2
			MOV		R6, 1000000000010000b
			CALL	EscCarLCD
			
			MOV		R2, TextLCD3
			MOV		R6, 1000000000011010b
			CALL	EscCarLCD
			
			MOV		R2, M[Vit11]
			MOV		R6, 1000000000010011b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Vit21]
			MOV		R6, 1000000000011101b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Vit12]
			MOV		R6, 1000000000010100b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Vit22]
			MOV		R6, 1000000000011110b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Tempo1]
			MOV		R6,	1000000000001011b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Tempo2]
			MOV		R6,	1000000000001100b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Tempo3]
			MOV		R6,	1000000000001101b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Tempo4]
			MOV		R6,	1000000000001110b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, 115d
			MOV		R6,	1000000000001111b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			POP		R7
			POP 	R6
			RET
			
		
EscCarL:	PUSH 	R1
			MOV 	R1, M[SP+3]
			MOV 	M[LCD], R1
			POP 	R1
			RETN 	1

EscCarLCD:  PUSH    R1
            PUSH    R2
CicloL:     MOV 	M[LCD_PORT], R6
			MOV     R1, M[R2]
            CMP     R1, FIM_TEXTO
            JMP.Z   FimEscL
			PUSH	R1
            CALL    EscCarL
            INC     R2
			INC		R6
            BR      CicloL
FimEscL:    POP     R2
            POP     R1
            RET		
		
		
; --------------------------------------------------------------------
; ---------------------Funcoes auxiliares a escrita-------------------
; --------------------------------------------------------------------


EscCar:		PUSH 	R1
			MOV 	R1, M[SP+3]
			MOV 	M[IO_WRITE], R1
			POP 	R1
			RETN 	1

EscString:  PUSH    R1
            PUSH    R2
Ciclo:      MOV 	M[IO_POS], R6
			MOV     R1, M[R2]
            CMP     R1, FIM_TEXTO
            JMP.Z   FimEsc
			PUSH	R1
            CALL    EscCar
            INC     R2
			INC		R6
            BR      Ciclo
FimEsc:     POP     R2
            POP     R1
            RET




; --------------------------------------------------------------------
; ---------------------Inicio do Programa-----------------------------
; --------------------------------------------------------------------

Inicio:     MOV     R7, SP_INICIAL
            MOV     SP, R7
			MOV     R7, INT_MASKINI
            MOV     M[INT_MASK_ADDR], R7
			MOV		R2, FFFFh
			CALL	LeTam
			MOV		M[IO_POS], R2
			MOV     R2, VarTexto1
			MOV		R6, INIText1
			MOV		M[IO_POS], R6
			CALL    EscString
			MOV     R2, VarTexto2
			MOV		R6, INIText2
			MOV		M[IO_POS], R6
			CALL    EscString
			CALL	EscSTRLCD
			MOV		R7, 0000000000000000b
			MOV		M[LEDS], R7
			ENI
			MOV		R1, 0001h
Ciclo2:		CMP		R1, R0
			BR.NZ	Ciclo2
Jogo:		CALL	LeTam
			CALL	LeNivel
			MOV		R2, FFFFh
			MOV		M[IO_POS], R2
			CALL	Apaga
			CALL	EscMais
			CALL	CicloTraco1
			CALL	CicloTraco2
			CALL	CicloMenos1
			CALL	CicloMenos2
			CALL	Jogador1
			CALL	Jogador2
			CALL	LimpaDados
			CALL	LeNivel
			CALL	EscDSP
			MOV     R7, INT_MASK
			MOV     M[INT_MASK_ADDR], R7
			JMP		JogoComeca
			
			
			
; --------------------------------------------------------------------
; ----------------------Funcao Fim de jogo----------------------------
; --------------------------------------------------------------------


LimpaDados:	PUSH	R7
			MOV		R7, 48d
			MOV		M[Tempo1], R7
			MOV		M[Tempo2], R7
			MOV		M[Tempo3], R7
			MOV		M[Tempo4], R7
			MOV		M[Tempo5], R7
			POP 	R7
			RET
		
; --------------------------------------------------------------------
; ----------------------Funcao Fim de jogo----------------------------
; --------------------------------------------------------------------
		
Fim:		CALL	Apaga
			PUSH	R2
			MOV		R2, 0000h
			CMP		R2, M[Vencedor]
			POP		R2
			JMP.Z	EscWin1
			JMP		EscWin2
			
EscWin1:	MOV     R2, TextoWin1
			MOV		R6, FIMText2
			MOV		M[IO_POS], R6
			CALL    EscString
			JMP		ContFim


EscWin2:	MOV     R2, TextoWin2
			MOV		R6, FIMText2
			MOV		M[IO_POS], R6
			CALL    EscString
			JMP		ContFim			


ContFim:	MOV		R7, M[TempoMax1]
			CMP		R7, M[Tempo1]
			JMP.N	ActTemp
			JMP.P	ContEsc
			MOV		R7, M[TempoMax2]
			CMP		R7, M[Tempo2]
			JMP.N	ActTemp
			JMP.P	ContEsc
			MOV		R7, M[TempoMax3]
			CMP		R7, M[Tempo3]
			JMP.N	ActTemp
			JMP.P	ContEsc
			MOV		R7, M[TempoMax4]
			CMP		R7, M[Tempo4]
			JMP.N	ActTemp
			JMP.P	ContEsc
				
			
ActTemp:	MOV		R2, M[Tempo1]
			MOV		M[TempoMax1], R2
			MOV		R6,	1000000000001011b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Tempo2]
			MOV		M[TempoMax2], R2
			MOV		R6,	1000000000001100b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Tempo3]
			MOV		M[TempoMax3], R2
			MOV		R6,	1000000000001101b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Tempo4]
			MOV		M[TempoMax4], R2
			MOV		R6,	1000000000001110b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2


ContEsc:	MOV     R2, FimTexto1
			MOV		R6, FIMText1
			MOV		M[IO_POS], R6
			CALL    EscString
			
			MOV     R2, FimTexto2
			MOV		R6, FIMText3
			MOV		M[IO_POS], R6
			CALL    EscString
			
			MOV		R2, M[Vit11]
			MOV		R6, 1000000000010011b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Vit21]
			MOV		R6, 1000000000011101b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Vit12]
			MOV		R6, 1000000000010100b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV		R2, M[Vit22]
			MOV		R6, 1000000000011110b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
	
			MOV		R2, 115d
			MOV		R6,	1000000000001111b
			MOV 	M[LCD_PORT], R6
			MOV 	M[LCD], R2
			
			MOV     R7, INT_MASKINI
			MOV     M[INT_MASK_ADDR], R7
			MOV		R1, 0001h
			
			CALL	EscDSP
Leds2:		CALL 	Leds1
			CMP		R1, R0
			BR.NZ	Leds2
			MOV		R7, 0000000000000000b
			MOV		M[LEDS], R7
			CALL	Apaga
			JMP		Jogo
		
		
Leds1:		MOV		R7, 0000000000000001b
			MOV		M[LEDS], R7
			MOV		R7, 0000000000000010b
			MOV		M[LEDS], R7
			MOV		R7, 0000000000000100b
			MOV		M[LEDS], R7
			MOV		R7, 0000000000001000b
			MOV		M[LEDS], R7
			MOV		R7, 0000000000010000b
			MOV		M[LEDS], R7
			MOV		R7, 0000000000100000b
			MOV		M[LEDS], R7
			MOV		R7, 0000000001000000b
			MOV		M[LEDS], R7
			MOV		R7, 0000000010000000b
			MOV		M[LEDS], R7
			MOV		R7, 0000000100000000b
			MOV		M[LEDS], R7
			MOV		R7, 0000001000000000b
			MOV		M[LEDS], R7
			MOV		R7, 0000010000000000b
			MOV		M[LEDS], R7
			MOV		R7, 0000100000000000b
			MOV		M[LEDS], R7
			MOV		R7, 0001000000000000b
			MOV		M[LEDS], R7
			MOV		R7, 0010000000000000b
			MOV		M[LEDS], R7
			MOV		R7, 0100000000000000b
			MOV		M[LEDS], R7
			MOV		R7, 1000000000000000b
			MOV		M[LEDS], R7
			MOV		R7, 0000000000000000b
			MOV		M[LEDS], R7
			RET
; ---------------------------------------------------------------------------------------------
; ---------------------Funcao que apaga ecra e tabela de posicoes------------------------------
; ---------------------------------------------------------------------------------------------
		
Apaga:		PUSH	R7
			PUSH	R4
			PUSH	R5
			MOV		R5, 0020h
			MOV		R4, R0
			MOV		R7, Posicoes
Apg:		MOV		M[R7], R0
			MOV		M[IO_POS], R4
			MOV		M[IO_WRITE], R5
			INC		R4
			INC		R7
			CMP		R4, 1900h
			BR.NZ	Apg

			POP		R5
			POP		R4
			POP		R7
			RET
			
; -------------------------------------------------------------------------
; ---------------------Verificacao de Tamanho------------------------------
; -------------------------------------------------------------------------
		
		
LeTam:		PUSH	R5
			DSI
			MOV		R5, M[INTS]
			AND		R5, 0000000000000011b
            CMP		R5, 0000000000000000b
            JMP.Z	Tam4
            CMP		R5, 0000000000000001b
            JMP.Z	Tam1
            CMP		R5, 0000000000000010b
            JMP.Z	Tam2
            JMP		Tam3
            
            
Tam1:		MOV		R5, 0c1ch
			MOV		M[PosIni1], R5
			MOV		R5, 0c35h
			MOV		M[PosIni2], R5
			MOV		R5, 0118h
			MOV		M[Mais1], R5
			MOV		R5, 0139h
			MOV		M[Mais2], R5
			MOV		R5, 1618h
			MOV		M[Mais3], R5
			MOV		R5, 1639h
			MOV		M[Mais4], R5
			MOV		R5, 0119h
			MOV		M[Menos1], R5
			MOV		R5, 1619h
			MOV		M[Menos2], R5
			MOV		R5, 0139h
			MOV		M[FMenos1], R5
			MOV		R5, 1639h
			MOV		M[FMenos2], R5
			MOV		R5, 0218h
			MOV		M[Traco1], R5
			MOV		R5, 0239h
			MOV		M[Traco2], R5
			MOV		R5, 1618h
			MOV		M[FTraco1], R5
			MOV		R5, 1639h
			MOV		M[FTraco2], R5
			JMP		FimTam

Tam2:		MOV		R5, 0c19h
			MOV		M[PosIni1], R5
			MOV		R5, 0c38h
			MOV		M[PosIni2], R5
			MOV		R5, 0610h
			MOV		M[Mais1], R5
			MOV		R5, 0641h
			MOV		M[Mais2], R5
			MOV		R5, 1110h
			MOV		M[Mais3], R5
			MOV		R5, 1141h
			MOV		M[Mais4], R5
			MOV		R5, 0611h
			MOV		M[Menos1], R5
			MOV		R5, 1111h
			MOV		M[Menos2], R5
			MOV		R5, 0641h
			MOV		M[FMenos1], R5
			MOV		R5, 1141h
			MOV		M[FMenos2], R5
			MOV		R5, 0710h
			MOV		M[Traco1], R5
			MOV		R5, 0741h
			MOV		M[Traco2], R5
			MOV		R5, 1110h
			MOV		M[FTraco1], R5
			MOV		R5, 1141h
			MOV		M[FTraco2], R5
			JMP		FimTam

Tam3:		MOV		R5, 0c1ch
			MOV		M[PosIni1], R5
			MOV		R5, 0c35h
			MOV		M[PosIni2], R5
			MOV		R5, 0618h
			MOV		M[Mais1], R5
			MOV		R5, 0639h
			MOV		M[Mais2], R5
			MOV		R5, 1118h
			MOV		M[Mais3], R5
			MOV		R5, 1139h
			MOV		M[Mais4], R5
			MOV		R5, 0619h
			MOV		M[Menos1], R5
			MOV		R5, 1119h
			MOV		M[Menos2], R5
			MOV		R5, 0639h
			MOV		M[FMenos1], R5
			MOV		R5, 1139h
			MOV		M[FMenos2], R5
			MOV		R5, 0718h
			MOV		M[Traco1], R5
			MOV		R5, 0739h
			MOV		M[Traco2], R5
			MOV		R5, 1118h
			MOV		M[FTraco1], R5
			MOV		R5, 1139h
			MOV		M[FTraco2], R5
			JMP		FimTam

Tam4:		MOV		R5, 0c19h
			MOV		M[PosIni1], R5
			MOV		R5, 0c38h
			MOV		M[PosIni2], R5
			MOV		R5, 0110h
			MOV		M[Mais1], R5
			MOV		R5, 0141h
			MOV		M[Mais2], R5
			MOV		R5, 1610h
			MOV		M[Mais3], R5
			MOV		R5, 1641h
			MOV		M[Mais4], R5
			MOV		R5, 0111h
			MOV		M[Menos1], R5
			MOV		R5, 1611h
			MOV		M[Menos2], R5
			MOV		R5, 0141h
			MOV		M[FMenos1], R5
			MOV		R5, 1641h
			MOV		M[FMenos2], R5
			MOV		R5, 0210h
			MOV		M[Traco1], R5
			MOV		R5, 0241h
			MOV		M[Traco2], R5
			MOV		R5, 1610h
			MOV		M[FTraco1], R5
			MOV		R5, 1641h
			MOV		M[FTraco2], R5
			JMP		FimTam


FimTam:  	ENI
			POP 	R5
			RET		

; ----------------------------------------------------------------------------------------
; ----------------------------------Escolha do nivel--------------------------------------
; ----------------------------------------------------------------------------------------

LeNivel:	PUSH	R5
			DSI
			MOV		R5, M[INTS]
			AND		R5, 0000000000111100b
            CMP		R5, 0000000000000100b
            JMP.Z	ModN1
            CMP		R5, 0000000000001000b
            JMP.Z	ModN2
            CMP		R5, 0000000000010000b
            JMP.Z	ModN3
            CMP		R5, 0000000000100000b
            JMP.Z	ModN4
            JMP		FimNivel
            
ModN1:		MOV		R5, 49d
			MOV		M[Tempo3], R5
			MOV		R5, 0005h
			MOV		M[Contador], R5
			JMP		FimNivel
			
ModN2:		MOV		R5, 50d
			MOV		M[Tempo3], R5
			MOV		R5, 0003h
			MOV		M[Contador], R5
			JMP		FimNivel
			
ModN3:		MOV		R5, 52d
			MOV		M[Tempo3], R5
			MOV		R5, 0002h
			MOV		M[Contador], R5
			JMP		FimNivel
			
ModN4:		MOV		R5, 54d
			MOV		M[Tempo3], R5
			MOV		R5, 0001h
			MOV		M[Contador], R5
			JMP		FimNivel
			
		
FimNivel:  	ENI
			POP 	R5
			RET		
			

; ----------------------------------------------------------------------------------------
; ---------------------Inicio do jogo, temporizador e nivel ------------------------------
; ----------------------------------------------------------------------------------------




JogoComeca: MOV		R1, 7d
			MOV		M[Contador], R1
			MOV		R1, Baixo
			MOV		M[ProxPos1], R1
			MOV		R1, Cima
			MOV		M[ProxPos2], R1
			MOV		M[Tempo], R0
			MOV		R1, 1h
			MOV		M[Temporizador], R1		
			MOV		M[INITemp], R1		
CicloTimer:	MOV		R2, R0
			MOV		R3, R0
CT:			CALL	LePausa
			CALL	EscDSP
			CALL	MudaTempos
			CMP		M[Contador], R0
			BR.NZ	CT
Movimentos1:	CMP	R2, Esquerda
			JMP.Z	EsqJog1
			CMP		R2, Direita
			JMP.Z	DirJog1
Movimentos2:	CMP		R3, Esquerda
			JMP.Z	EsqJog2
			CMP		R3, Direita
			JMP.Z	DirJog2
ContinuaM:	JMP		MovJog1
FimMovimentos:	JMP		VerificaNivel	
		
		
		
; -------------------------------------------------------------------------
; ---------------------Verificacao de Pausa------------------------------
; -------------------------------------------------------------------------
		
		
LePausa:        PUSH	R5
				DSI
CicloP:         MOV		R5, M[INTS]
                AND		R5, 0080h
                CMP		R5, 0080h
                BR.Z	CicloP
FimPausa:       ENI
				POP 	R5
				RET		
		
		
; -------------------------------------------------------------------------
; ---------------------Escrita Display-------------------------------------
; -------------------------------------------------------------------------		

		
EscDSP:			PUSH	R7
				MOV		R7, M[Tempo4]
				MOV		M[DSP1], R7
				MOV		R7, M[Tempo3]
				MOV		M[DSP2], R7
				MOV		R7, M[Tempo2]
				MOV		M[DSP3], R7
				MOV		R7, M[Tempo1]
				MOV		M[DSP4], R7
				POP		R7
				RET
		
		
; -------------------------------------------------------------------------
; ---------------------Muda ASCII Tempos-----------------------------------
; -------------------------------------------------------------------------


MudaTempos:		PUSH	R7
			MOV		R7, M[Tempo5]
			CMP		R7, 58d
			BR.Z	IncTemp4
			POP		R7
			RET
			
			
IncTemp4:	MOV		R7, 48d
			MOV		M[Tempo5], R7
			INC		M[Tempo4]
			MOV		R7, M[Tempo4]
			CMP		R7, 58d
			BR.Z	IncTemp3
			POP		R7
			RET
			
IncTemp3:	MOV		R7, 48d
			MOV		M[Tempo4], R7
			INC		M[Tempo3]
			MOV		R7, M[Tempo3]
			CMP		R7, 58d
			BR.Z	IncTemp2
			POP		R7
			RET
			
IncTemp2:	MOV		R7, 48d
			MOV		M[Tempo3], R7
			INC		M[Tempo2]
			MOV		R7, M[Tempo2]
			CMP		R7, 58d
			BR.Z	IncTemp1
			POP		R7
			RET
			
IncTemp1:	MOV		R7, 48d
			MOV		M[Tempo2], R7
			INC		M[Tempo1]
			POP		R7
			RET



		
; -------------------------------------------------------------------------
; ---------------------Verificacao de colisão------------------------------
; -------------------------------------------------------------------------
		
		
Embater1:	PUSH	R1
			PUSH	R2
			MOV		R1, 1d
			MOV		R2, M[Pos1]
			ADD		R2, Posicoes
			CMP		M[R2], R1
			JMP.Z	Win2
			POP		R2
			POP		R1
			RET
			
			
Embater2:	PUSH	R1
			PUSH	R2
			MOV		R1, 1d
			MOV		R2, M[Pos2]
			ADD		R2, Posicoes
			CMP		M[R2], R1
			JMP.Z	Win1
			POP		R2
			POP		R1
			RET			

; ----------------------------------------------------------------------------------------
; ---------------------Incremento das vitorias dos jogadores------------------------------
; ----------------------------------------------------------------------------------------
			
			
Win1:		MOV		R2, 0000h
			MOV		M[Vencedor], R2
			MOV		R2, 57d
			CMP		M[Vit12], R2
			BR.Z	IncVit11
			INC		M[Vit12]
			POP		R2
			POP		R1
			JMP		Fim
			
			
IncVit11:	INC		M[Vit11]
			MOV		R2, 48d
			MOV		M[Vit12], R2
			POP		R2
			POP		R1
			JMP		Fim

Win2:		MOV		R2, 0001h
			MOV		M[Vencedor], R2
			MOV		R2, 57d
			CMP		M[Vit22], R2
			BR.Z	IncVit21
			INC		M[Vit22]
			POP		R2
			POP		R1
			JMP		Fim
			
IncVit21:	INC		M[Vit21]
			MOV		R2, 48d
			MOV		M[Vit22], R2
			POP		R2
			POP		R1
			JMP		Fim
		
		
		
; ------------------------------------------------------------------------------------
; ---------------------Funcoes auxiliares aos movimentos------------------------------
; ------------------------------------------------------------------------------------
		
		
		
		

MovJog1:	MOV		R4, M[ProxPos1]
			CMP		R4, Cima
			JMP.Z	MJ1C
			CMP		R4, Baixo
			JMP.Z	MJ1B
			CMP		R4, Direita
			JMP.Z	MJ1D
			JMP		MJ1E

MovJog2:	MOV		R4, M[ProxPos2]
			CMP		R4, Cima
			JMP.Z	MJ2C
			CMP		R4, Baixo
			JMP.Z	MJ2B
			CMP		R4, Direita
			JMP.Z	MJ2D
			JMP		MJ2E

		
; --------------------------------------------------------------------------------------------------------
; ---------------------Funcoes que escreve a nova posicao no ecra, jogador 1------------------------------
; --------------------------------------------------------------------------------------------------------		
		
		
MJ1C:		MOV		R4, M[Pos1]
			SUB		R4, 0100h
			MOV		M[IO_POS], R4
			MOV		M[Pos1], R4
			CALL	Embater1
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog1
			MOV		M[IO_WRITE], R4
			JMP		MovJog2

MJ1B:		MOV		R4, M[Pos1]
			ADD		R4, 0100h
			MOV		M[IO_POS], R4
			MOV		M[Pos1], R4
			CALL	Embater1
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog1
			MOV		M[IO_WRITE], R4
			JMP		MovJog2

MJ1E:		MOV		R4, M[Pos1]
			DEC		R4
			MOV		M[IO_POS], R4
			MOV		M[Pos1], R4
			CALL	Embater1
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog1
			MOV		M[IO_WRITE], R4
			JMP		MovJog2

MJ1D:		MOV		R4, M[Pos1]
			INC		R4
			MOV		M[IO_POS], R4
			MOV		M[Pos1], R4
			CALL	Embater1
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog1
			MOV		M[IO_WRITE], R4
			JMP		MovJog2



; --------------------------------------------------------------------------------------------------------
; ---------------------Funcoes que escreve a nova posicao no ecra, jogador 2------------------------------
; --------------------------------------------------------------------------------------------------------


MJ2C:		MOV		R4, M[Pos2]
			SUB		R4, 0100h
			MOV		M[IO_POS], R4
			MOV		M[Pos2], R4
			CALL	Embater2
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog2
			MOV		M[IO_WRITE], R4
			JMP		FimMovimentos

MJ2B:		MOV		R4, M[Pos2]
			ADD		R4, 0100h
			MOV		M[IO_POS], R4
			MOV		M[Pos2], R4
			CALL	Embater2
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog2
			MOV		M[IO_WRITE], R4
			JMP		FimMovimentos
			

MJ2E:		MOV		R4, M[Pos2]
			DEC		R4
			MOV		M[IO_POS], R4
			MOV		M[Pos2], R4
			CALL	Embater2
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog2
			MOV		M[IO_WRITE], R4
			JMP		FimMovimentos

MJ2D:		MOV		R4, M[Pos2]
			INC		R4
			MOV		M[IO_POS], R4
			MOV		M[Pos2], R4
			CALL	Embater2
			ADD		R4, Posicoes
			PUSH	R3
			MOV		R3, 1d
			MOV		M[R4], R3
			POP		R3
			MOV		R4, Jog2
			MOV		M[IO_WRITE], R4
			JMP		FimMovimentos



; ---------------------------------------------------------------------------------
; ---------------------Verificacao e mudanca de nivel------------------------------
; ---------------------------------------------------------------------------------



VerificaNivel:	PUSH 	R7
			MOV		R7, M[Tempo3]
			CMP		R7, 49d;  Nivel1R5
			JMP.N	Nivel1
			CMP		R7, 50d;  Nivel2R5
			JMP.N	Nivel2
			CMP		R7, 52d;  Nivel3R5
			JMP.N	Nivel3
			CMP		R7, 54d; Nivel4R5
			JMP.N	Nivel4
			JMP		Nivel5
		

Nivel1:		MOV		R7, 0007h
			MOV		M[Contador], R7
			MOV		R7, R0
			MOV		M[LEDS], R7
			POP 	R7
			JMP		CicloTimer

Nivel2:		MOV		R7, 0005h
			MOV		M[Contador], R7
			MOV		R7, 0000000000001111b
			MOV		M[LEDS], R7
			POP 	R7
			JMP		CicloTimer

Nivel3:		MOV		R7, 0003h
			MOV		M[Contador], R7
			MOV		R7, 0000000011111111b
			MOV		M[LEDS], R7
			POP 	R7
			JMP		CicloTimer

Nivel4:		MOV		R7, 0002h
			MOV		M[Contador], R7
			MOV		R7, 0000111111111111b
			MOV		M[LEDS], R7
			POP 	R7
			JMP		CicloTimer
		
Nivel5:		MOV		R7, 0001h
			MOV		M[Contador], R7
			MOV		R7, 1111111111111111b
			MOV		M[LEDS], R7
			POP 	R7		
			JMP		CicloTimer

; ----------------------------------------------------------------------------------------------------
; ---------------------Mais funcoes auxiliares ao movimento do jogador 1------------------------------
; ----------------------------------------------------------------------------------------------------


EsqJog1:	PUSH	R6
			MOV		R6, Direita
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Cima
			
			MOV		R6, Esquerda
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Baixo

			MOV		R6, Cima
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Esq

			MOV		R6, Baixo
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Esq		


DirJog1:	PUSH	R6
			MOV		R6, Direita
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Baixo
			
			MOV		R6, Esquerda
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Cima

			MOV		R6, Cima
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Dir	

			MOV		R6, Baixo
			CMP		M[ProxPos1], R6
			JMP.Z	Jog1Dir		

; ----------------------------------------------------------------------------------------------------
; ---------------------Mais funcoes auxiliares ao movimento do jogador 2------------------------------
; ----------------------------------------------------------------------------------------------------

		
EsqJog2:	PUSH	R6
			MOV		R6, Direita
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Cima
			
			MOV		R6, Esquerda
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Baixo

			MOV		R6, Cima
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Esq

			MOV		R6, Baixo
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Esq		
		

DirJog2:	PUSH	R6
			MOV		R6, Direita
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Baixo
			
			MOV		R6, Esquerda
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Cima

			MOV		R6, Cima
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Dir	

			MOV		R6, Baixo
			CMP		M[ProxPos2], R6
			JMP.Z	Jog2Dir		
			
; ----------------------------------------------------------------------------------------------------
; ---------------------Mais funcoes auxiliares ao movimento do jogador 1------------------------------
; ----------------------------------------------------------------------------------------------------

Jog1Esq:	MOV		R6, Esquerda
			MOV		M[ProxPos1], R6
			POP		R6
			JMP		Movimentos2
	
Jog1Dir:	MOV		R6, Direita
			MOV		M[ProxPos1], R6
			POP		R6
			JMP		Movimentos2

Jog1Cima:	MOV		R6, Cima
			MOV		M[ProxPos1], R6
			POP		R6
			JMP		Movimentos2

Jog1Baixo:	MOV		R6, Baixo
			MOV		M[ProxPos1], R6
			POP		R6
			JMP		Movimentos2
		
; ----------------------------------------------------------------------------------------------------
; ---------------------Mais funcoes auxiliares ao movimento do jogador 2------------------------------
; ----------------------------------------------------------------------------------------------------		

Jog2Esq:	MOV		R6, Esquerda
			MOV		M[ProxPos2], R6
			POP		R6
			JMP		ContinuaM

Jog2Dir:	MOV		R6, Direita
			MOV		M[ProxPos2], R6
			POP		R6
			JMP		ContinuaM

Jog2Cima:	MOV		R6, Cima
			MOV		M[ProxPos2], R6
			POP		R6
			JMP		ContinuaM

Jog2Baixo:	MOV		R6, Baixo
			MOV		M[ProxPos2], R6
			POP		R6
			JMP		ContinuaM













