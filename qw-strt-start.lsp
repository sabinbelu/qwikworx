(setvar 'cmdecho 0)

(if (findfile "qw-strt-start.lsp")
	(setq qw-gv-path (vl-string-right-trim "\\qw-strt-start.lsp" (findfile "qw-strt-start.lsp")))
	(alert "QW: Path not found!")
) 
;




;load files
(defun qw-strt-hlp-load_files ( / files)
	(setq files (vl-remove "qw-strt-start.lsp" (vl-directory-files qw-gv-path "qw*.lsp" 1)))
	(foreach file files		
		(load file)
		(princ (strcat "\n<" file "> succesfully loaded"))
	)
)
;	

(qw-strt-hlp-load_files)

;init point style control
(qw-psct-hlp-parse)
(qw-psct-hlp-update)



(setvar 'cmdecho 1)
(princ "\nQWikworx succesfully intialized")
(princ)

