%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.18.0"

\header {
  lsrtags = "fretted-strings"

  texidoc = "
Slides for chords can be indicated in both @code{Staff} and
@code{TabStaff}. String numbers are necessary for @code{TabStaff}
because automatic string calculations are different for chords and for
single notes.

"
  doctitle = "Chord glissando in tablature"
} % begin verbatim

myMusic = \relative c' {
  <c\3 e\2 g\1>1 \glissando <f\3 a\2 c\1>
}

\score {
  <<
    \new Staff {
      \clef "treble_8"
      \myMusic
    }
    \new TabStaff {
      \myMusic
    }
  >>
}
