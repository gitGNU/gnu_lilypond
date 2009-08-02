%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "editorial-annotations, fretted-strings, spacing"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Las cifras de digitación orientadas verticalmente se colocan de
forma predeterminada fuera del pentagrama.  Sin embargo, este
comportamiento se puede cancelar.

"
  doctitlees = "Permitir que las digitaciones se impriman dentro del pentagrama"

%% Translation of GIT committish: 3f880f886831b8c72c9e944b3872458c30c6c839
  texidocfr = "
L'empilement des indications de doigté se fait par défaut à l'extérieur de la portée.  Néanmoins, il est possible d'annuler ce comportement.

"
  doctitlefr = "Impression des doigtés à l'intérieur de la portée"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Normalerweise werden vertikal orientierte Fingersatzzahlen außerhalb des Systems
gesetzt.  Das kann aber verändert werden.

"
  doctitlede = "Fingersatz auch innerhalb des Systems setzen"

  texidoc = "
By default, vertically oriented fingerings are positioned outside the
staff.  However, this behavior can be canceled.

"
  doctitle = "Allowing fingerings to be printed inside the staff"
} % begin verbatim

\relative c' {
  <c-1 e-2 g-3 b-5>2
  \once \override Fingering #'staff-padding = #'()
  <c-1 e-2 g-3 b-5>2
}

