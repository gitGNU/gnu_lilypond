% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.1
\version "2.13.31"

\header {
%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b

  texidoces = "
La visibilidad de los objetos de extensión que acaban en la primera
nota después de un salto de línea está controlada por la función de
callback de @code{after-line-breaking}
@code{ly:spanner::kill-zero-spanned-time}.

Para los objetos como los glissandos y los reguladores, el
comportamiento predeterminado es ocultar el objeto de extensión
después del salto; la inhabilitación de la función de callback hace
que el objeto de extensión roto por la izquierda pueda mostrarse.

De forma inversa, los objetos de extensión que son visibles
normalmente, como los objetos de extensión de texto, se pueden
ocultar habilitando la función de callback.
"

  doctitlees = "Controlar la visibilidad de los objetos de
  extensión después de un salto de línea"


  lsrtags = "expressive-marks, tweaks-and-overrides"
  texidoc = "The visibility of spanners which end on the first note
following a line break is controlled by the @code{after-line-breaking}
callback @code{ly:spanner::kill-zero-spanned-time}.

For objects such as glissandos and hairpins, the default behaviour is
to hide the spanner after a break; disabling the callback will allow
the left-broken span to be shown.

Conversely, spanners which are usually visible, such as text spans,
can be hidden by enabling the callback.
"

  doctitle = "Controlling spanner visibility after a line break"
} % begin verbatim


\paper { ragged-right = ##t }

\relative c'' {
  \override Hairpin #'to-barline = ##f
  \override Glissando #'breakable = ##t
  % show hairpin
  \override Hairpin #'after-line-breaking = ##t
  % hide text span
  \override TextSpanner #'after-line-breaking =
    #ly:spanner::kill-zero-spanned-time
  e2\<\startTextSpan
  % show glissando
  \override Glissando #'after-line-breaking = ##t
  f2\glissando
  \break
  f,1\!\stopTextSpan
}

