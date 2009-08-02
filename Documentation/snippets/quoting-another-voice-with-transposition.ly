%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "pitches, staff-notation"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Los pasajes citados tienen en cuenta la transposición de la fuente
tanto como la del destino.  En este ejemplo, todos los
instrumentos interpreta una nota con el sonido del Do central; el
destino de un instrumento transpositor en Fa.  La parte de destino
se puede transponer utilizando @code{\\transpose}.  En este caso
se transportan todas las notas (incluidas las citadas).

"

doctitlees = "Citar otra voz con transposición"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Zitate berücksichtigen sowohl die Transposition der Quelle als auch
des Zielinstruments.  In diesem Beispiel spielen alle Instrumente
klingendes C, das Zielinstrument ist in F.  Die Noten für das
Zielinstrument können mit @code{\\transpose} transponiert werden,
in diesem Fall werden alle Noten (auch die zitierten) transponiert.

"
  doctitlede = "Eine Stimme mit Transposition zitieren"

  texidoc = "
Quotations take into account the transposition of both source and
target.  In this example, all instruments play sounding middle C; the
target is an instrument in F.  The target part may be transposed using
@code{\\transpose}.  In this case, all the pitches (including the
quoted ones) are transposed.

"
  doctitle = "Quoting another voice with transposition"
} % begin verbatim

\addQuote clarinet {
  \transposition bes
  \repeat unfold 8 { d'16 d' d'8 }
}

\addQuote sax {
  \transposition es'
  \repeat unfold 16 { a8 }
}

quoteTest = {
  % french horn
  \transposition f
  g'4
  << \quoteDuring #"clarinet" { \skip 4 } s4^"clar." >>
  << \quoteDuring #"sax" { \skip 4 } s4^"sax." >>
  g'4
}

{
  \set Staff.instrumentName =
    \markup {
      \center-column { Horn \line { in F } }
    }
  \quoteTest
  \transpose c' d' << \quoteTest s4_"up a tone" >>
}
