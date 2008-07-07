%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.51"

\header {
  lsrtags = "pitches, editorial-annotations"

  doctitle = "Applying note head styles depending on the step of the scale"

  texidoc = "
La propiedad @code{shapeNoteStyles} se puede usar para definir varios
estilos de cabezas de nota para cada grado de la escala (según esté
establecido por la armadura o por la propiedad \"tonic\"). Esta
propiedad requiere un conjunto de símbolos, que pueden ser puramente
arbitrarios (se permiten expresiones geométricas como @code{triangle},
triángulo, @code{cross}, aspas, y @code{xcircle}, círculo con aspas) o
basados en una antigua tradición americana de grabado (ciertos nombres
de nota latinos trambién se permiten).

Dicho esto, para imitar antiguos cancioneros americanos, existen
varios estilos predefinidos de cabezas de nota disponibles a través de
instrucciones de abreviatura como @code{\aikenHeads} o
@code{\sacredHarpHeads}.

Este ejemplo muestra distintas formas de obtener cabezas de notas con
forma, y muestra la capacidad de transportar una melodía sin perder la
correspondencia entre las funciones armónicas y los estilos de cabezas
de nota.

"



  texidoc = "
The @code{shapeNoteStyles} property can be used to define various note
head styles for each step of the scale (as set by the key signature or
the \"tonic\" property). This property requires a set of symbols, which
can be purely arbitrary (geometrical expressions such as
@code{triangle}, @code{cross}, and @code{xcircle} are allowed) or based
on old American engraving tradition (some latin note names are also
allowed).

That said, to imitate old American song books, there are several
predefined note head styles available through shortcut commands such as
@code{\\aikenHeads} or @code{\\sacredHarpHeads}.

This example shows different ways to obtain shape note heads, and
demonstrates the ability to transpose a melody without losing the
correspondence between harmonic functions and note head styles. 

"
  doctitle = "Applying note head styles depending on the step of the scale"
} % begin verbatim
fragment = {
  \key c \major
  c2 d
  e2 f
  g2 a
  b2 c
}

\score {
  \new Staff {
    \transpose c d 
    \relative c' {
      \set shapeNoteStyles = ##(do re mi fa #f la ti)
      \fragment
    }
    
    \relative c' {
      \set shapeNoteStyles  = ##(cross triangle fa #f mensural xcircle diamond)
      \fragment
    }
  }
}

