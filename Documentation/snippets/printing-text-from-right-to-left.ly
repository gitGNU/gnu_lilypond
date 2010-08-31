%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.31"

\header {
  lsrtags = "editorial-annotations, text, world-music"

  texidoc = "
It is possible to print text from right to left in a markup object, as
demonstrated here.

"
  doctitle = "Printing text from right to left"
} % begin verbatim

{
  b1^\markup {
    \line { i n g i r u m i m u s n o c t e }
  }
  f'_\markup {
    \override #'(text-direction . -1)
    \line { i n g i r u m i m u s n o c t e }
  }
}

