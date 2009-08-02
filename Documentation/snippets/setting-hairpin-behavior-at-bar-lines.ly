%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "expressive-marks, tweaks-and-overrides"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Si la nota que da fin a un regulador cae sobre la primera parte de
un compás, el regulador se detiene en la línea divisoria
inmediatamente precedente.  Se puede controlar este comportamiento
sobreescribiendo la propiedad @code{'to-barline}.

"
  doctitlees = "Establecer el comportamiento de los reguladores en las barras de compás"
  
%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
texidocde = "
Wenn die Note, an welcher eine Crescendo-Klammer endet, die erste Note
eines Taktes ist, wird die Klammer an der vorhergehenden Tatklinie
beendet.  Dieses Verhalten kann auch mit der Eigenschaft
@code{'to-barline} geändert werden:
"
  doctitlede = "Das Verhalten von Crescendo-Klammern an Taktlinien beeinflussen"

  texidoc = "
If the note which ends a hairpin falls on a downbeat, the hairpin stops
at the bar line immediately preceding.  This behavior can be controlled
by overriding the @code{'to-barline} property.

"
  doctitle = "Setting hairpin behavior at bar lines"
} % begin verbatim

\relative c'' {
  e4\< e2.
  e1\!
  \override Hairpin #'to-barline = ##f
  e4\< e2.
  e1\!
}
