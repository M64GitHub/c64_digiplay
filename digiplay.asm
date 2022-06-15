.pc = $0801 "Basic Upstart"
:BasicUpstart(start)    // 10 sys$0810

.pc=$1000 "Program"

start:
		lda #$00      
		sta $d020     
		sta $d021     
		tax           
        		
		jsr play
		
		rts
		
		// clear screen                
		lda #$20      
!loop:	sta $0400,x   
		sta $0500,x   
		sta $0600,x   
		sta $0700,x
		dex            
		bne !loop-

        lda #$1      
!loop:	sta $d800,x   
		sta $d900,x   
		sta $da00,x   
		sta $db00,x
		dex            
		bne !loop-

		jsr play

		rts

play:            
	lda #<sample_data
    sta play_addr+1
    lda #>sample_data
    sta play_addr+2

    ldx #$00
    ldy #$3a    
    
play_addr: 
	lda $1234
	and #15
	sta $d418
	
	// delay
	tya
	pha
	ldy #15
	dey
	bne *-1
	pla
	tay
	
	inc play_addr+1
	bne !+
	inc play_addr+2

!:	dex
	bne play_addr
	dey
	bne play_addr
	jmp play
	
	rts



sample_data:
.import binary "out.raw"
sample_end:   

