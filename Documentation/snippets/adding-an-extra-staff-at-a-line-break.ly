%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "staff-notation, contexts-and-engravers, breaks"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Al añadir un pentagrama nuevo en un salto de línea, por desgracia
se añade un espacio adicional al final de la línea antes del salto
(reservado para hacer sitio a un cambio de armadura que de todas
formas no se va a imprimir). La solución alternativa es añadir un
ajuste para @code{Staff.explicitKeySignatureVisibility} como se
muestra en el ejemplo.  En las versiones 2.10 y anteriores,
también se necesita un ajuste similar para las indicaciones de
compás (véase el ejemplo).

"
  doctitlees = "Añadir un pentagrama adicional en un salto de línea"

  texidoc = "
When adding a new staff at a line break, some extra space is
unfortunately added at the end of the line before the break (to fit in
a key signature change, which  will never be printed anyway).  The
workaround is to add a setting of
@code{Staff.explicitKeySignatureVisibility} as is shown in the example.
In versions 2.10 and earlier, a similar setting for the time signatures
is also required (see the example).



"
  doctitle = "Adding an extra staff at a line break"
} % begin verbatim

\score {
  \new StaffGroup \relative c'' {
    \new Staff
    \key f \major
    c1 c^"Unwanted extra space" \break
    << { c1 | c }
       \new Staff {
         \key f \major
         \once \override Staff.TimeSignature #'stencil = ##f
         c1 | c
       } 
    >>
    c1 | c^"Fixed here" \break
    << { c1 | c }
       \new Staff {
         \once \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
         % The next line is not needed in 2.11.x or later:
         \once \override Staff.TimeSignature #'break-visibility = #end-of-line-invisible
         \key f \major
         \once \override Staff.TimeSignature #'stencil = ##f
         c1 | c
       }
    >>
  }
}

