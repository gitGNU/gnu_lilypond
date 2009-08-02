%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Normalmente están prohibidos los saltos de línea si las barras
atraviesan las líneas divisorias.  Se puede cambiar este
comportamiento como se muestra aquí:

"
  doctitlees = "Barras que atraviesan saltos de línea"
  

  doctitle = "Barras que atraviesan saltos de línea"
  

  doctitle = "Barras que atraviesan saltos de línea"
  
%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d  
texidocde = "
Zeilenumbrüche sind normalerweise während Balken verboten.  Das kann geändert
werden.

"
  doctitlede = "Balken über Zeilenumbrüche"


%% Translation of GIT committish: b3196fadd8f42d05ba35e8ac42f7da3caf8a3079
  
  texidocfr = "
Il est normalement impensable qu'un saut de ligne tombe au milieu d'une
ligature.  LilyPond permet néanmoins de l'obtenir.

"
  doctitlefr = "Ligature au moment d'un saut de ligne"

  texidoc = "
Line breaks are normally forbidden when beams cross bar lines. This
behavior can be changed as shown: 

"
  doctitle = "Beams across line breaks"
} % begin verbatim

\relative c'' {
  \override Beam #'breakable = ##t
  c8 c[ c] c[ c] c[ c] c[ \break  
  c8] c[ c] c[ c] c[ c] c
}


