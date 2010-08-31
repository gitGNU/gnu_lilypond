%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.31"

\header {
  lsrtags = "expressive-marks"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
  texidoces = "
El glifo de la marca de respiración se puede ajustar
sobreescribiendo la propiedad de texto del objeto de presentación
@code{BreathingSign}, con cualquier otro texto de marcado.

"
  doctitlees = "Cambiar el símbolo de la marca de respiración"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Das Schriftzeichen für das Atemzeichen kann verändert werden, indem
die Text-Eigenschaft des @code{BreathingSign}-Layoutobjekts mit einer
beliebigen Textbeschriftung definiert wird.

"
  doctitlede = "Das Atemzeichen-Symbol verändern"

%% Translation of GIT committish: 217cd2b9de6e783f2a5c8a42be9c70a82195ad20
  texidocfr = "
On peut choisir le glyphe imprimé par cette commande, en modifiant la
propriété @code{text} de l'objet @code{BreathingSign}, pour lui affecter
n'importe quelle indication textuelle.

"
  doctitlefr = "Modification de l'indicateur de respiration"


  texidoc = "
The glyph of the breath mark can be tuned by overriding the text
property of the @code{BreathingSign} layout object with any markup
text.

"
  doctitle = "Changing the breath mark symbol"
} % begin verbatim

\relative c'' {
  c2
  \override BreathingSign #'text = \markup { \musicglyph #"scripts.rvarcomma" }
  \breathe
  d2
}
