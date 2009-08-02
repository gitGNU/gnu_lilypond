%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "fretted-strings, tweaks-and-overrides"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Se pueden establecer las propiedades de los diagramas de
posiciones a través de @code{'fret-diagram-details}.  Para los
diagramas de posiciones de marcado, se pueden aplicar overrides
(sobreescrituras) al objeto @code{Voice.TextScript} o directamente al elemento de marcado.

"
 doctitlees = "Personalizar diagramas de posiciones de marcado"

%% Translation of GIT committish: 3f880f886831b8c72c9e944b3872458c30c6c839

  texidocfr = "
Les propriétés d'un diagramme de fret sont modifiables grâce au 
@code{'fret-diagram-details}.  Lorsqu'ils sont générés sous forme 
de @code{\markup}, rien n'empêche de les modifier en jouant sur les 
réglages de l'objet @code{Voice.TextScript} ou bien directement sur 
le @qq{markup}.

"
  doctitlefr = "Personnalisation des diagrammes de fret"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Bunddiagramme können mit der Eigenschaft @code{'fret-diagram-details}
angepasst werden.  Bunddiagramme, die als Textbeschriftung eingefügt werden,
können Veränderungen im @code{Voice.TextScript}-Objekt oder direkt in der
Beschriftung vorgenommen werden.

"
  doctitlede = "Anpassung von Beschriftungs-Bunddiagrammen"

  texidoc = "
Fret diagram properties can be set through
@code{'fret-diagram-details}.  For markup fret diagrams, overrides can
be applied to the @code{Voice.TextScript} object or directly to the
markup.

"
  doctitle = "Customizing markup fret diagrams"
} % begin verbatim

<<
  \chords { c1 | c | c | d }
  
  \new Voice = "mel" {
    \textLengthOn
    % Set global properties of fret diagram
    \override TextScript #'size = #'1.2
    \override TextScript
      #'(fret-diagram-details finger-code) = #'in-dot
    \override TextScript
      #'(fret-diagram-details dot-color) = #'white

    %% C major for guitar, no barre, using defaults
       % terse style
    c'1^\markup { \fret-diagram-terse #"x;3-3;2-2;o;1-1;o;" }

    %% C major for guitar, barred on third fret
       % verbose style
       % size 1.0
       % roman fret label, finger labels below string, straight barre
    c'1^\markup {
      % standard size
      \override #'(size . 1.0) {
        \override #'(fret-diagram-details . (
                     (number-type . roman-lower)
                     (finger-code . in-dot)
                     (barre-type . straight))) {
          \fret-diagram-verbose #'((mute 6)
                                   (place-fret 5 3 1)
                                   (place-fret 4 5 2)
                                   (place-fret 3 5 3)
                                   (place-fret 2 5 4)
                                   (place-fret 1 3 1)
                                   (barre 5 1 3))
        }
      }
    }

    %% C major for guitar, barred on third fret
       % verbose style
       % landscape orientation, arabic numbers, M for mute string
       % no barre, fret label down or left, small mute label font
    c'1^\markup {
      \override #'(fret-diagram-details . (
                   (finger-code . below-string)
                   (number-type . arabic)
                   (label-dir . -1)
                   (mute-string . "M")
                   (orientation . landscape)
                   (barre-type . none)
                   (xo-font-magnification . 0.4)
                   (xo-padding . 0.3))) {
        \fret-diagram-verbose #'((mute 6)
                                 (place-fret 5 3 1)
                                 (place-fret 4 5 2)
                                 (place-fret 3 5 3)
                                 (place-fret 2 5 4)
                                 (place-fret 1 3 1)
                                 (barre 5 1 3))
      }
    }

    %% simple D chord
       % terse style
       % larger dots, centered dots, fewer frets
       % label below string
    d'1^\markup {
      \override #'(fret-diagram-details . (
                   (finger-code . below-string)
                   (dot-radius . 0.35)
                   (dot-position . 0.5)
                   (fret-count . 3))) {
        \fret-diagram-terse #"x;x;o;2-1;3-2;2-3;"
      }
    }
  }
>>
