%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.62"

\header {
  lsrtags = "rhythms"

 doctitlees = "Cambiar el número del grupo especial"
 texidoces = "

De forma predeterminada sólo se imprime el numerador del grupo
especial sobre el corchete de grupo, es decir, el denominador del
argumento de la instrucción @code{\\times}. De forma alternativa, se
puede imprimr un quebrado en la forma numerador:denominador del número
del grupo, o eliminar el número.

"

%% Translation of GIT committish :<6ce7f350682dfa99af97929be1dec6b9f1cbc01a>
texidocde = "
Standardmäßig wird nur der Zähler des N-tolen-Bruchs über der Klammer
dargestellt, wie er dem @code{\\times}-Befehl übergeben wird.
Man kann aber auch Zähler/Nenner ausgeben lassen, oder die Zahl
vollständig unterdrücken.

"
  doctitlede = "Die Zahl der N-tole verändern"

  texidoc = "
By default, only the numerator of the tuplet number is printed over the
tuplet bracket, i.e., the denominator of the argument to the
@code{\\times} command. Alternatively, num:den of the tuplet number may
be printed, or the tuplet number may be suppressed altogether.

"
  doctitle = "Changing the tuplet number"
} % begin verbatim

\relative c'' {
  \times 2/3 { c8 c c } \times 2/3 { c8 c c }
  \override TupletNumber #'text = #tuplet-number::calc-fraction-text
  \times 2/3 { c8 c c }
  \override TupletNumber #'stencil = ##f
  \times 2/3 { c8 c c }
}
