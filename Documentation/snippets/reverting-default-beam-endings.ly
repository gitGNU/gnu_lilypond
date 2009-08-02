%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
%% Translation of GIT committish: bee31293920d834cd3698f00ddcc2402c3164619
  texidocfr = "
Pour obtenir des ligatures en groupes de @code{3-4-3-2} croches, dans
une mesure à 12/8, il faudra préalablement annuler les réglages par
défaut relatifs à 12/8, puis ajouter nos propres règles :

"
  doctitlefr = "Annulation des règles de ligature par défaut"

  lsrtags = "rhythms"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Para tipografiar las barras agrupadas en la forma @code{3-4-3-2}
en 12/8, en primer lugar tenemos que sobreescribir los finales de
barra predeterminados en 12/8, y después preparar los finales de
barra nuevos:

"
  doctitlees = "Alteración de los finales de barra predeterminados"


%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Um Balken im 12/8-Takt als @code{3-4-3-2} zu gruppieren, muss man zuerst die
Standardwerte für die Balken im 12/8-Takt rückgängig machen und dann die neuen
Werte setzen:

"
  doctitlede = "Standard-Balkenwerte rückgängig machen"



  texidoc = "
To typeset beams grouped @code{3-4-3-2} in 12/8 it is necessary first
to override the default beam endings  in 12/8, and then to set up the
new beaming endings: 

"
  doctitle = "Reverting default beam endings"
} % begin verbatim

\relative c'' {
  \time 12/8

  % Default beaming
  a8 a a a a a a a a a a a

  % Revert default values in scm/auto-beam.scm for 12/8 time
  #(revert-auto-beam-setting '(end * * 12 8) 3 8)
  #(revert-auto-beam-setting '(end * * 12 8) 3 4)
  #(revert-auto-beam-setting '(end * * 12 8) 9 8)
  a8 a a a a a a a a a a a

  % Set new values for beam endings
  #(override-auto-beam-setting '(end * * 12 8) 3 8)
  #(override-auto-beam-setting '(end * * 12 8) 7 8)
  #(override-auto-beam-setting '(end * * 12 8) 10 8)
  a8 a a a a a a a a a a a
}

