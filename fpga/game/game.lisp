
; Sprite 0 (player rocket)
(write-register 2 160)
(write-register 5 1)			; enable
(write-register 3 (- 240 30))	; y coord (a little up from the bottom)
(assign x0 (- 160 8))

(while 1
	; Wait for start of vblank
	(while (<> (read-register 1) 1)
		()
	)

	; Set up sprite 0
	(write-register 2 x0)	; X coord
	(write-register 4 s0shape)	; animation frame

	; Wait for end of vblank
	(while (read-register 1)
		()
	)

	; Left?
	(if (<> (and (read-register 0) 1) 0)
		(if (> x0 3)
			(assign x0 (- x0 3))
		)
	)

	; Move right?
	(if (<> (and (read-register 0) 2) 0)
		(if (< x0 (- 320 (+ 16 3)))
			(assign x0 (+ x0 3))
		)
	)

	(if (= animation-delay 0)
		; Animate jet exhaust
		(begin
			(assign s0shape (- 1 s0shape))
			(assign animation-delay 7)
		)
		(assign animation-delay (- animation-delay 1))
	)
)

