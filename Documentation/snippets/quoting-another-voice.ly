%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.18.0"

\header {
  lsrtags = "staff-notation"

  texidoc = "
The @code{quotedEventTypes} property determines the music event types
which should be quoted.  The default value is @code{(note-event
rest-event tie-event beam-event tuplet-span-event)}, which means that
only the notes, rests, ties, beams and tuplets of the quoted voice will
appear in the @code{\\quoteDuring} expression. In the following
example, a 16th rest is not quoted since @code{rest-event} is not in
@code{quotedEventTypes}.

For a list of event types, consult the @qq{Music classes} section of
the Internals Reference.

"
  doctitle = "Quoting another voice"
} % begin verbatim


quoteMe = \relative c' {
  fis4 r16 a8.-> b4\ff c
}
\addQuote quoteMe \quoteMe

original = \relative c'' {
  c8 d s2
  \once \override NoteColumn.ignore-collision = ##t
  es8 gis8
}

<<
  \new Staff {
    \set Staff.instrumentName = #"quoteMe"
    \quoteMe
  }
  \new Staff {
    \set Staff.instrumentName = #"orig"
    \original
  }
  \new Staff \relative c'' <<
    \set Staff.instrumentName = #"orig+quote"
    \set Staff.quotedEventTypes =
      #'(note-event articulation-event)
    \original
    \new Voice {
      s4
      \set fontSize = #-4
      \override Stem.length-fraction = #(magstep -4)
      \quoteDuring #"quoteMe" { \skip 2. }
    }
  >>
>>
