%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.18.0"

\header {
  lsrtags = "ancient-notation"

  texidoc = "
Time signatures may also be engraved in an old style.



"
  doctitle = "Ancient time signatures"
} % begin verbatim


{
  \override Staff.TimeSignature.style = #'neomensural
  s1
}
