        ; kr580vm80a assembler code for radio-86rk (32kb)
exit    equ 0F86Ch
print   equ 0F818h
setch   equ 0F809h

        org 0h
	mvi c, 1fh
	call setch
	lxi hl, num+3
	mvi a, 3
preplp:
	mvi m, 30h
	dcx hl
	dcr a
	cpi 0
	jnz preplp
	mvi m, 31h
mainlp:
	lxi hl, num
	call prinum
	lxi hl, minsev
	call print
	
	lxi hl, num+3
	mov a, m
	sui 6
lesslp:
	dcr a
	cpi 30h
	jnc ifless
	mvi b, 1
	adi 10
	mov m, a
	dcx hl
	mov a, m
	cpi 0
	jz end
	jnz lesslp
	
ifless:
	mov m, a
	call prinum
	mvi c, 0dh
	call setch
	mvi c, 0ah
	call setch
	jmp mainlp
	
end:
	lxi hl, endtxt
	call print
	jmp exit

prinum:	
	lxi hl, num
	mvi d, 4
	mvi b, 1
prinlp:	
	mov a, m
	cpi 30h
	jz pzer
	mov c, m
	mvi b, 0
	call setch
pzerrt:
	inx hl
	dcr d
	mov a, d
	cpi 0
	rz
	jmp prinlp

pzer:
	mov a, b
	mov c, m
	cpi 0
	cz setch
	jmp pzerrt

minsev:	
	db ' - 7 = ', 0

endtxt:
	db 'zaskamlen kak mamont ahahahahahahahah)00)00)))0', 0dh, 0ah, 0	

num:
	db 0,0,0,0