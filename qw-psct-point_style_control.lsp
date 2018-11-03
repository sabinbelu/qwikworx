; Point Style Control - short: "psct"
; detrimnes the details of the QW-point object and stores them in the USERI1 system variable
; each character in the number represents an info about the symbol; the format is SXUT, where:
; S = sign of the number (+ = symbol size is larger than normal; - = symbol size is smaller than normal)
; X = nr. of times symbol is larger/smaller than default ( 0 = default; 1 = 10x; 2 to 9 = 2x to 9x )
; U = unit - 9 unitless; 0 mm; 1 cm; 2 dm; 3 m; 4 dam; 5 hm; 6 km
; T = point object type ; -> 24-08-18 todo: add more point object types



; set USERI1 to default value 900 
(if (= (getvar "USERI1") 0) (setvar "USERI1" 900))


; Read the SUDX system var (USERI1) and parse it into the SUDX vars
; they are global for the drawing and will be cleared when the document is closed
; every time a function changes the SUDX var the parser should be run to update the individual variables

(defun qw-psct-hlp-parse ( / sxut)
	(setq sxut (getvar "USERI1"))
	
	(if (< sxut 0) (setq qw-gv-s -1) (setq qw-gv-s 1))
	(setq sxut (abs sxut))
	(setq sxut (itoa sxut))
	(setq qw-gv-x (atoi (substr sxut 1 1)))
	(setq qw-gv-u (atoi (substr sxut 2 1)))
	(setq qw-gv-t (atoi (substr sxut 3 1)))	
)
;

;update SUDX
(defun qw-psct-hlp-update ( / sxut_tmp )					
	(setvar "USERI1" (* qw-gv-s (+ (* qw-gv-x 100) (* qw-gv-u 10) qw-gv-t))) 
	(qw-psct-hlp-parse)
)
;
