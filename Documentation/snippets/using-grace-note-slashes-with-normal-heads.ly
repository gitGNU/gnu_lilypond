% DO NOT EDIT this file manually; it is automatically
% generated from Documentation/snippets/new
% Make any changes in Documentation/snippets/new/
% and then run scripts/auxiliar/makelsr.py
%
% This file is in the public domain.
%% Note: this file works from version 2.17.6
\version "2.18.0"

\header {
  lsrtags = "rhythms"

  texidoc = "
The slash through the stem found in acciaccaturas can be applied in
other situations.

"
  doctitle = "Using grace note slashes with normal heads"
} % begin verbatim


\relative c'' {
  \override Flag.stroke-style = #"grace"
  c8( d2) e8( f4)
}
