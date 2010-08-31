%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.31"

\header {
  lsrtags = "editorial-annotations, fretted-strings, spacing"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b

  texidoces = "
Las cifras de digitación orientadas verticalmente se colocan de forma
predeterminada fuera del pentagrama.  Sin embargo, este comportamiento
se puede cancelar.  Nota: se debe usar una construcción de acorde <>,
aunque sea una sola nota.


"
  doctitlees = "Permitir que las digitaciones se impriman dentro del pentagrama"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Normalerweise werden vertikal orientierte Fingersatzzahlen außerhalb des Systems
gesetzt.  Das kann aber verändert werden.

"
  doctitlede = "Fingersatz auch innerhalb des Systems setzen"

%% Translation of GIT committish: 4ab2514496ac3d88a9f3121a76f890c97cedcf4e
  texidocfr = "
L'empilement des indications de doigté se fait par défaut à l'extérieur
de la portée.  Néanmoins, il est possible d'annuler ce comportement.

"
  doctitlefr = "Impression des doigtés à l'intérieur de la portée"


  texidoc = "
By default, vertically oriented fingerings are positioned outside the
staff.  However, this behavior can be canceled. Note: you must use a
chord construct <>, even if it is only a single note.

"
  doctitle = "Allowing fingerings to be printed inside the staff"
} % begin verbatim

\relative c' {
  <c-1 e-2 g-3 b-5>2
  \override Fingering #'staff-padding = #'()
  <c-1 e-2 g-3 b-5>4 <g'-0>
}

