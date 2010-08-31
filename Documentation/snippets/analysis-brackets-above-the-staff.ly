%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.31"

\header {
  lsrtags = "editorial-annotations, tweaks-and-overrides"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
  texidoces = "
De forma predeterminada se añaden corchetes de análisis sencillos
debajo del pentagrama.  El ejemplo siguiente muestra una manera de
colocarlos por encima.

"
  doctitlees = "Corchetes de análisis encima del pentagrama"

  texidoc = "
Simple horizontal analysis brackets are added below the staff by
default. The following example shows a way to place them above the
staff instead.

"
  doctitle = "Analysis brackets above the staff"
} % begin verbatim

\layout {
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
  }
}
\relative c'' {
  \once \override HorizontalBracket #'direction = #UP
  c2\startGroup
  d2\stopGroup
}

