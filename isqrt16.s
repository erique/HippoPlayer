����                          .   
; in:
; d0 = 16-bit number
; out:
; d1 = result
; scratch:
; d0,d2,d3

isqrt16


;isqrt16				;
;uint32				// OR uint16 OR uint8  
;isqrt32 (uint32 n) // OR isqrt16 ( uint16 n ) OR  isqrt8 ( uint8 n ) - respectively [ OR overloaded as isqrt (uint?? n) in C++ ]  
;{  
;    register uint32 // OR register uint16 OR register uint8 - respectively  
;        root, remainder, place;  
  
;    root = 0;  
	moveq	#0,d1
;    remainder = n;  
	; =d0

;    place = 0x40000000; // OR place = 0x4000; OR place = 0x40; - respectively  
	move.w	#$4000,d2

;    while (place > remainder)  
;        place = place >> 2;  
	cmp.w	d0,d2
	bls.b	.1

.a	lsr.w	#2,d2
	cmp.w	d0,d2
	bhi.b	.a
.1


.loop2
;    while (place)  
;    {  
;        if (remainder >= root + place)  
	move.w	d1,d3
	add.w	d2,d3
	cmp.w	d3,d0
	blo.b	.2
;       {  
;            remainder = remainder - root - place;  
	sub.w	d2,d0
	sub.w	d1,d0
;            root = root + (place << 1);  
	move.w	d2,d3
	lsl.w	#1,d3
	add.w	d3,d1
;        }  
.2
;        root = root >> 1;  
	lsr.w	#1,d1
;        place = place >> 2;  
	lsr.w	#2,d2
	bne.b	.loop2
;    }  
;    return root;  
;}
  	rts

isqrt32

	moveq	#0,d1
	move.l	#$40000000,d2

	cmp.l	d0,d2
	bls.b	.1

.a	lsr.l	#2,d2
	cmp.l	d0,d2
	bhi.b	.a
.1

.loop2
	move.l	d1,d3
	add.l	d2,d3
	cmp.l	d3,d0
	blo.b	.2
	sub.l	d2,d0
	sub.l	d1,d0
	move.l	d2,d3
	lsl.l	#1,d3
	add.l	d3,d1
.2
	lsr.l	#1,d1
	lsr.l	#2,d2
	bne.b	.loop2

  	rts
