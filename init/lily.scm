; lily.scm -- implement Scheme output routines for TeX and PostScript
;
;  source file of the GNU LilyPond music typesetter
; 
; (c) 1998 Jan Nieuwenhuizen <janneke@gnu.org>

; TODO
;   - naming
;   - ready ps code (draw_bracket) vs tex/ps macros/calls (pianobrace),
;     all preparations from ps,tex to scm

;;; library funtions
(define
  (xnumbers->string l)
  (string-append 
   (map (lambda (n) (string-append (number->string n ) " ")) l)))

(define
  (numbers->string l)
  (apply string-append 
  (map (lambda (n) (string-append (number->string n) " ")) l)))

(define (chop-decimal x) (if (< (abs x) 0.001) 0.0 x))

(define (number->octal-string x)
  (let* ((n (inexact->exact x))
         (n64 (quotient n 64))
         (n8 (quotient (- n (* n64 64)) 8)))
        (string-append
         (number->string n64)
         (number->string n8)
         (number->string (remainder (- n (+ (* n64 64) (* n8 8))) 8)))))

(define (inexact->string x radix)
  (let ((n (inexact->exact x)))
       (number->string n radix)))


(define
  (control->string c)
  (string-append
    (string-append (number->string (car c)) " ")
    (string-append (number->string (cadr c)) " ")))



(define
  (font i)
  (string-append
   "font"
   (make-string 1 (integer->char (+ (char->integer #\A) i)))
   ))



(define (scm-scm action-name)
  1)

;;;;;;;;
  (define (emptybar h)
    (string-append ""))


;;;;;;;; TeX

(define (tex-scm action-name)

  (define (unknown) 
    "%\n\\unknown%\n")

  (define (beam width slope thick)
    (embedded-ps ((ps-scm 'beam) width slope thick)))

  (define (bracket h)
    (embedded-ps ((ps-scm 'bracket) h)))

  (define (dashed-slur thick dash l)
    (embedded-ps ((ps-scm 'dashed-slur)  thick dash l)))

  (define (crescendo w h cont)
    (embedded-ps ((ps-scm 'crescendo) w h cont)))

  (define (decrescendo w h cont)
    (embedded-ps ((ps-scm 'decrescendo) w h cont)))

  (define (embedded-ps s)
    (string-append "\\embeddedps{" s "}"))


  (define (end-output) 
    "\n\\EndLilyPondOutput")

  (define (empty) 
    "%\n\\empty%\n")

  (define (experimental-on) "\\turnOnExperimentalFeatures")

  (define (extender o h)
    ((invoke-output o "invoke-dim1") "extender" h))

  (define (font-switch i)
    (string-append
     "\\" (font i) "\n"))

  (define (font-def i s)
    (string-append
     "\\font" (font-switch i) "=" s "\n"))

  (define (generalmeter num den)
    (string-append 
     "\\generalmeter{" (number->string (inexact->exact num)) "}{" (number->string (inexact->exact den)) "}"))

  (define (header-end) "\\turnOnPostScript")

  (define (header creator generate) 
    (string-append
     "%created by: " creator generate "\n"))

  (define (invoke-char s i)
    (string-append 
     "\n\\" s "{" (inexact->string i 10) "}" ))
  (define (char i)
    (string-append "\\show{" (inexact->string i 10) "}"))
    
  (define (invoke-dim1 s d)
    (string-append
     "\n\\" s "{" (number->dim d) "}"))

  (define (lily-def key val)
    (string-append
     "\\def\\" key "{" val "}\n"))

  (define (number->dim x)
    (string-append 
     (number->string (chop-decimal x)) "pt "))

  (define (placebox x y s) 
    (string-append 
     "\\placebox{"
     (number->dim y) "}{" (number->dim x) "}{" s "}"))

  (define (pianobrace y)
    (define step 1.0)
    (define minht mudelapaperstaffheight)
    (define maxht (* 6 minht))
    (string-append
     "{\\bracefont " (char  (/  (- (max y (- maxht step)) minht)   step)) "}"))
  
  (define (rulesym h w) 
    (string-append 
     "\\vrule height " (number->dim (/ h 2))
     " depth " (number->dim (/ h 2))
     " width " (number->dim w)
     )
    )

  (define (slur l)
    (embedded-ps ((ps-scm 'slur) l)))

  (define (start-line) 
    (string-append 
     "\\hbox{%\n")
    )

  (define (stem kern width height depth) 
    (string-append 
     "\\kern" (number->dim kern)
     "\\vrule width " (number->dim width)
     "depth " (number->dim depth)
     "height " (number->dim height) " "))

  (define (stop-line) 
    "}\\interscoreline")

  (define (text f s)
    (string-append "\\set" f "{" s "}"))

  (define (tuplet dx dy dir)
    (embedded-ps ((ps-scm 'tuplet) dx dy dir)))

  (define (volta w last)
    (embedded-ps ((ps-scm 'volta)  w last)))

  (define (maatstreep h)
    (string-append "\\maatstreep{" (number->dim h) "}"))
  
  (cond ((eq? action-name 'all-definitions)
	 `(begin
	   (define beam ,beam)
	   (define tuplet ,tuplet)
	   (define bracket ,bracket)
	   (define crescendo ,crescendo)
	   (define volta ,volta)
	   (define slur ,slur)
	   (define dashed-slur ,dashed-slur) 
	   (define decrescendo ,decrescendo) 
	   (define empty ,empty)
	   (define end-output ,end-output)
	   (define font-def ,font-def)
	   (define font-switch ,font-switch)
	   (define generalmeter ,generalmeter)
	   (define header-end ,header-end)
	   (define lily-def ,lily-def)
	   (define header ,header) 
	   (define invoke-char ,invoke-char) 
	   (define invoke-dim1 ,invoke-dim1)
	   (define placebox ,placebox)
	   (define rulesym ,rulesym)
	   (define start-line ,start-line)
	   (define stem ,stem)
	   (define stop-line ,stop-line)
	   (define text ,text)
	   (define experimental-on  ,experimental-on)
	   (define char  ,char)
	   (define maatstreep ,maatstreep)
	   (define pianobrace ,pianobrace)
	   ))

	((eq? action-name 'experimental-on) experimental-on)
	((eq? action-name 'beam) beam)
	((eq? action-name 'tuplet) tuplet)
	((eq? action-name 'bracket) bracket)
	((eq? action-name 'crescendo) crescendo)
	((eq? action-name 'volta) volta)
	((eq? action-name 'slur) slur)
	((eq? action-name 'dashed-slur) dashed-slur) 
	((eq? action-name 'decrescendo) decrescendo) 
	((eq? action-name 'empty) empty)
	((eq? action-name 'end-output) end-output)
	((eq? action-name 'font-def) font-def)
	((eq? action-name 'font-switch) font-switch)
	((eq? action-name 'generalmeter) generalmeter)
	((eq? action-name 'header-end) header-end)
	((eq? action-name 'lily-def) lily-def)
	((eq? action-name 'header) header) 
	((eq? action-name 'invoke-char) invoke-char) 
	((eq? action-name 'invoke-dim1) invoke-dim1)
	((eq? action-name 'placebox) placebox)
	((eq? action-name 'rulesym) rulesym)
	((eq? action-name 'start-line) start-line)
	((eq? action-name 'stem) stem)
	((eq? action-name 'stop-line) stop-line)
	(else (error "unknown tag -- PS-TEX " action-name))
	)

  )

;;;;;;;;;;;; PS
(define (ps-scm action-name)
  (define (beam width slope thick)
    (string-append
     (numbers->string (list width slope thick)) " draw_beam " ))

  (define (bracket h)
    (invoke-dim1 "draw_bracket" h))

  (define (crescendo w h cont)
    (string-append 
     (numbers->string (list w h (inexact->exact cont)))
     "draw_crescendo"))

  (define (dashed-slur thick dash l)
    (string-append 
     (apply string-append (map control->string l)) 
     (number->string thick) 
     " [ "
     (if (> 1 dash) (number->string (- (* thick dash) thick)) "0") " "
     (number->string (* 2 thick))
     " ] 0 draw_dashed_slur"))

  (define (decrescendo w h cont)
    (string-append 
     (numbers->string (list w h (inexact->exact cont)))
     "draw_decrescendo"))

  (define (empty) 
    "\n empty\n")

  (define (end-output)
    "\nshowpage\n")

  (define (experimental-on) "")

  (define (font-def i s)
    (string-append
     "\n/" (font i) " {/" 
     (substring s 0 (- (string-length s) 4))
     " findfont 12 scalefont setfont} bind def\n"))

  (define (font-switch i)
    (string-append (font i) " "))

  (define (generalmeter num den)
    (string-append (number->string (inexact->exact num)) " " (number->string (inexact->exact den)) " generalmeter "))

  (define (header-end) "")
  (define (lily-def key val)
    (string-append
     "/" key " {" val "} bind def\n"))

  (define (header creator generate) 
    (string-append
     "%!PS-Adobe-3.0\n"
     "%%Creator: " creator generate "\n"))

  (define (invoke-char s i)
    (string-append 
     "(\\" (inexact->string i 8) ") " s " " ))

  (define (invoke-dim1 s d) 
    (string-append
     (number->string d) " " s ))

  (define (placebox x y s) 
    (string-append 
     (number->string x) " " (number->string y) " {" s "} placebox "))

  (define (rulesym x y) 
    (string-append 
     (number->string x) " "
     (number->string y) " "
     "rulesym"))

  (define (slur l)
    (string-append 
     (apply string-append (map control->string l)) 
     " draw_slur"))

  (define (start-line) 
    "\nstart_line {\n")

  (define (stem kern width height depth) 
    (string-append (numbers->string (list kern width height depth))
		   "draw_stem" ))

  (define (stop-line) 
    "}\nstop_line\n")

  (define (text f s)
    (string-append "(" s ") set" f " "))


  (define (volta w last)
    (string-append 
     (numbers->string (list w (inexact->exact last)))
     "draw_volta"))
  (define   (tuplet dx dy dir)
    (string-append 
     (numbers->string (list dx dy (inexact->exact dir)))
     "draw_tuplet"))


  (define (unknown) 
    "\n unknown\n")


  ; dispatch on action-name
  (cond ((eq? action-name 'all-definitions)
	`(begin
	  (define beam ,beam)
	  (define tuplet ,tuplet)
	  (define bracket ,bracket)
	  (define crescendo ,crescendo)
	  (define volta ,volta)
	  (define slur ,slur)
	  (define dashed-slur ,dashed-slur) 
	  (define decrescendo ,decrescendo) 
	  (define empty ,empty)
	  (define end-output ,end-output)
	  (define font-def ,font-def)
	  (define font-switch ,font-switch)
	  (define generalmeter ,generalmeter)
	  (define header-end ,header-end)
	  (define lily-def ,lily-def)
	  (define header ,header) 
	  (define invoke-char ,invoke-char) 
	  (define invoke-dim1 ,invoke-dim1)
	  (define placebox ,placebox)
	  (define rulesym ,rulesym)
	  (define start-line ,start-line)
	  (define stem ,stem)
	  (define stop-line ,stop-line)
	  (define text ,text)
	  ))
	((eq? action-name 'tuplet) tuplet)
	((eq? action-name 'beam) beam)
	((eq? action-name 'bracket) bracket)
	((eq? action-name 'crescendo) crescendo)
	((eq? action-name 'volta) volta)
	((eq? action-name 'slur) slur)
	((eq? action-name 'dashed-slur) dashed-slur) 
	((eq? action-name 'decrescendo) decrescendo)
	(else (error "unknown tag -- PS-SCM " action-name))
	)
)



