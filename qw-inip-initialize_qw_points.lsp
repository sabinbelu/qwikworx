(defun qw-inip-def-qwpoint ()

	;define scale 
	(defun rs_tst_symbol ( / m1 )	

	(if (= SUDX_U 1) (setq scf 1000.0 bn "RS_Punt") (setq scf 1.0 bn "RS_Punt" ))

	(if (/= SUDX_X 0) 
		(progn
			(if (= SUDX_X 1) (setq m1 10) (setq m1 SUDX_X))				
			(if (= SUDX_S -1)
				(setq scf (abs (/ scf m1)))
				(setq scf (* scf m1))
			)
		)
	)
)
;
	
	
	
	

	;check if attribute layers exist, or create them if they do not
	(or (tblobjname "LAYER" "QW-PA-Elevation") (entmake (list (cons 0 "LAYER") (cons 2 "QW-PA-Elevation") (cons 62 5))))
	(or (tblobjname "LAYER" "QW-PA-Description") (entmake (list (cons 0 "LAYER") (cons 2 "QW-PA-Description") (cons 62 3))))
	(or (tblobjname "LAYER" "QW-PA-Point Name") (entmake (list (cons 0 "LAYER") (cons 2 "QW-PA-Point Name") (cons 62 7))))
	;QW Point block definition
	(entmake (list (cons 0 "BLOCK") (cons 2 "QW-Point") (cons 70 2) (cons 10 '(0 0 0))))
	(cond 
		( (= 1 qw-gv-t) (entmake (list (cons 0 "CIRCLE") (cons 10 (list 0 0 0)) (cons 8 "QW-Point") (cons 40 (* 0.0375 scf)) (cons 62 0)))	)
		;todo 05-09-18: add more point symbol types
		('T  (entmake (list (cons 0 "LINE") (cons 8 "QW-Point") (cons 10 (list 0 0 (* -0.05 scf))) (cons 11 (list 0 0 (* 0.05 scf))) (cons 62 0) ))	)	
	)
	(entmake (list (cons 0 "LINE") (cons 8 "QW-Point") (cons 10 (list (* -0.05 scf) 0.0 0.0)) (cons 11 (list (* 0.05 scf) 0.0 0.0)) (cons 62 0) ))
	(entmake (list (cons 0 "LINE") (cons 8 "QW-Point") (cons 10 (list 0.0 (* -0.05 scf) 0.0)) (cons 11 (list 0.0 (* 0.05 scf) 0.0)) (cons 62 0) ))
	(entmake (list 			; make point number attribute
				(cons 0 "ATTDEF")  
				(cons 10 (list 0 (* 0.125 scf) 0 )) 
				(cons 1 "") 
				(cons 2 "qw-pna") 
				(cons 3 "Point Name") 
				(cons 41 1) 
				(cons 40 (* 0.1 scf)); text size 				
				(cons 70 8) 	;sets value to predefined * otherwise doesn't work
				(cons 8 "QW-PA-Point Name")
				)
	);close entmake
	(entmake (list 			; make point height attribute
				(cons 0 "ATTDEF")  
				(cons 10 (list (* 0.15 scf) (* -0.05 scf) 0 )) 
				(cons 1 "")
				(cons 2 "qw-pel") 
				(cons 3 "Elevation") 
				(cons 41 1) 
				(cons 40 (* 0.1 scf)) ;text size
				(cons 70 8) 	;sets value to predefined * otherwise doesn't work
				(cons 8 "QW-PA-Elevation")
				)
	);close entmake
	(entmake (list 			; make point description attribute
				(cons 0 "ATTDEF")  
				(cons 10 (list 0 (* -0.225 scf) 0 )) 
				(cons 1 "") 
				(cons 2 "qw-pde") 
				(cons 3 "Description") 
				(cons 41 1) 
				(cons 40 (* 0.1 scf)); text size 
				(cons 70 8) 	;sets value to predefined * otherwise doesn't work
				(cons 8 "RS_ATT_PUNTBESCHRIJVING")
				)
	);close entmake
	(entmake (list (cons 0 "ENDBLK")));end block definition	
)
;end defun



	
	
;sub-routine to define a RS block point
(defun rs_def_rspoint ( / bn scf)
	;(if (= SUDX_U 1) (setq scf 1000.0 bn "RS_Punt") (setq scf 1.0 bn "RS_Punt"))
	
	(rs_tst_symbol)
	
	
	
	(setq mycolor (getvar "CECOLOR"))
	(setvar "CECOLOR" "BYLAYER")
	
	
	(entmake (list (cons 0 "LAYER") (cons 2 "RS_ATT_HOOGTE") (cons 62 5)))
	(entmake (list (cons 0 "LAYER") (cons 2 "RS_ATT_PUNTBESCHRIJVING") (cons 62 3)))
	(entmake (list (cons 0 "LAYER") (cons 2 "RS_ATT_PUNTNUMMER") (cons 72 7)))
	
	;start RS_Punt block definition
	(entmake (list (cons 0 "BLOCK") (cons 2 bn) (cons 8 "RS_PUNT")(cons 70 2) (cons 10 (list 0 0 0)))) 
	
	;2d or 3d block
	(if (= 2 SUDX_D) 
		;if 2D pt draw a circle
		(entmake (list (cons 0 "CIRCLE") (cons 10 (list 0 0 0)) (cons 8 "RS_PUNT") (cons 40 (* 0.0375 scf)) (cons 62 0)   ))
		;else draw a line in he Z-plane
		(entmake (list (cons 0 "LINE") (cons 8 "RS_PUNT") (cons 10 (list 0 0 (* -0.05 scf))) (cons 11 (list 0 0 (* 0.05 scf))) (cons 62 0) ))
	)
	
	; Create a point in order to be able to snap to node
	(entmake (list (cons 0 "POINT") (cons 8 "RS_PUNT") (cons 10 (list 0 0 0))))
	
	(entmake (list (cons 0 "LINE") (cons 8 "RS_PUNT") (cons 10 (list (* -0.05 scf) 0.0 0.0)) (cons 11 (list (* 0.05 scf) 0.0 0.0)) (cons 62 0) ))
	(entmake (list (cons 0 "LINE") (cons 8 "RS_PUNT") (cons 10 (list 0.0 (* -0.05 scf) 0.0)) (cons 11 (list 0.0 (* 0.05 scf) 0.0)) (cons 62 0) ))
	(entmake (list 			; make point number attribute
				(cons 0 "ATTDEF")  
				(cons 10 (list 0 (* 0.125 scf) 0 )) 
				(cons 1 "") 
				(cons 2 "PT#") 
				(cons 3 "Point number") 
				(cons 41 1) 
				(cons 40 (* 0.1 scf)); text size 
				(cons 7 "Ratio Survey") 
				(cons 70 8) 	;sets value to predefined * otherwise doesn't work
				(cons 8 "RS_ATT_PUNTNUMMER")
				)
	);close entmake
	(entmake (list 			; make point height attribute
				(cons 0 "ATTDEF")  
				(cons 10 (list (* 0.15 scf) (* -0.05 scf) 0 )) 
				(cons 1 "")
				(cons 2 "ELEV2") 
				(cons 3 "ELEVATION") 
				(cons 41 1) 
				(cons 40 (* 0.1 scf)) ;text size
				(cons 7 "Ratio Survey") 
				(cons 70 8) 	;sets value to predefined * otherwise doesn't work
				(cons 8 "QW-PA-Elevation")
				)
	);close entmake
	(entmake (list 			; make point description attribute
				(cons 0 "ATTDEF")  
				(cons 10 (list 0 (* -0.225 scf) 0 )) 
				(cons 1 "") 
				(cons 2 "qw-pde") 
				(cons 3 "Description") 
				(cons 41 1) 
				(cons 40 (* 0.1 scf)); text size 
				(cons 70 8) 	;sets value to predefined * otherwise doesn't work
				(cons 8 "QW-PA-Description")
				)
	);close entmake
	(entmake (list (cons 0 "ENDBLK")));end block definition		
	
	(setvar "CECOLOR" mycolor)
)
;