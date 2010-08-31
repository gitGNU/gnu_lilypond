%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.31"

\header {
  lsrtags = "pitches"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
doctitlees = "Evitar que se impriman becuadros cuando cambia la armadura"

texidoces = "

Cuando cambia la armadura de la tonalidad, se imprimen becuadros
automáticamente para cancelar las alteraciones de las armaduras
anteriores.  Esto se puede evitar estableciendo al valor @qq{falso} la
propiedad @code{printKeyCancellation} del contexto @code{Staff}.

"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
doctitlede = "Auflösungzeichen nicht setzen wenn die Tonart wechselt"

texidocde = "
Wenn die Tonart wechselt, werden automatisch Auflösungszeichen ausgegeben,
um Versetzungszeichen der vorherigen Tonart aufzulösen.  Das kann
verhindert werden, indem die @code{printKeyCancellation}-Eigenschaft
im @code{Staff}-Kontext auf \"false\" gesetzt wird.
"

%% Translation of GIT committish: 4ab2514496ac3d88a9f3121a76f890c97cedcf4e
  texidocfr = "
Après un changement de tonalité, un bécarre est imprimé pour annuler
toute altération précédente.  Ceci peut être supprimé en réglant à
@code{\"false\"} la propriété @code{printKeyCancellation} du contexte
@code{Staff}.

"

  doctitlefr = "Suppression des bécarres superflus après un changement de
tonalité"

  texidoc = "
When the key signature changes, natural signs are automatically printed
to cancel any accidentals from previous key signatures.  This may be
prevented by setting to @code{f} the @code{printKeyCancellation}
property in the @code{Staff} context.

"
  doctitle = "Preventing natural signs from being printed when the key signature changes"
} % begin verbatim

\relative c' {
  \key d \major
  a4 b cis d
  \key g \minor
  a4 bes c d
  \set Staff.printKeyCancellation = ##f
  \key d \major
  a4 b cis d
  \key g \minor
  a4 bes c d
}

