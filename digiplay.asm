.pc = $0801 "Basic Upstart"
:BasicUpstart(start)    // 10 sys$0810

.pc=$1000 "Program"

start:  jsr waitkey
                lda #$00      
                sta $d020     
                sta $d021     
                tax           
                        
                // clear screen
                ldy #0                
                lda #0      
!loop:  tay
                iny             
                tya             
                sta $0400,x   
                sta $0500,x   
                sta $0600,x   
                sta $0700,x
                dex            
                bne !loop-

        ldy #$ff      
!loop:  tay
                iny
                tya
                
                sta $d800,x   
                sta $d900,x   
                sta $da00,x   
                sta $db00,x
                dex            
                bne !loop-

                lda #15
                sta $d801

                jsr startscreen
                jsr reset_loop

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
speed:
        ldy #15
        dey
        bne *-1
        pla
        tay
        inc $0400
        inc play_addr+1
        bne !+
        inc $0401
        inc play_addr+2

!:      dex
        bne play_addr
        dey
        bne play_addr

loop_hander:    
// loop counter 
        inc $0402                               
                
        inc loop_ctr                    
        lda loop_ctr    
        
        ldx loop_idx
cmp_len:
        cmp #$04
        
        bne play
        
next_loop:      
        lda #0
        sta loop_ctr
        inc loop_idx    
        ldx loop_idx    
        lda speeds,x    
        beq reset_loop  
        sta speed+1
        lda lengths,x
        sta cmp_len+1
        
        jmp play
                        
reset_loop:             
        lda #0          
        sta loop_ctr            
        sta loop_idx            
        lda speeds              
        sta speed+1             
        lda lengths             
        sta cmp_len+1           
        
        jmp play
        
        rts

loop_ctr: .byte 0
loop_idx: .byte 0

startscreen:
        ldx #0
!:      lda message,x
        beq !+
        sta $0400,x
        inx     
        jmp !-  
!:      rts

waitkey:
        lda #$0
        sta $dc03       // port b ddr (input)
        lda #$ff
        sta $dc02       // port a ddr (output)
                        
        lda #$00
        sta $dc00       // port a
        lda $dc01       // port b
        cmp #$ff
        beq waitkey
        
        clc
        rts

message: .text "     digitest                      " 
.byte 0


speeds:         .byte 12, 10, 15,  5  
.byte 0
lengths:        .byte  4,  2,  2,  2  
.byte 0

sample_data:
// incbin "out.raw"     
//.fill $2000, 0
//.fill $2000, 16 + 16*sin(toRadians(i*360/64)) 
.import binary "out.raw"
sample_end:   
