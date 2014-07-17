%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.19.2"

\header {
  lsrtags = "headword"

  texidoc = "
Simultaneous notes

"
  doctitle = "Simultaneous headword"
} % begin verbatim

\include "english.ly"

% NR 1.5 Simultaneous notes

% L. v. Beethoven, Op. 111
% Piano sonata 32
% Movt II - Arietta - Adagio molto semplice e cantabile
% measures 108 - 118

\layout {
  \context {
    \Score
    \override SpacingSpanner.base-shortest-duration =
    #(ly:make-moment 1/18)
    \override NonMusicalPaperColumn.line-break-system-details =
    #'((alignment-distances . (12)))
  }
}

trillFlat =
\once \override TrillSpanner.bound-details.left.text = \markup {
  \concat {
    \musicglyph #"scripts.trill"
    \translate #'(-0.5 . 1.9)
    \fontsize #-7
    \with-dimensions #'(0 . 0) #'(0 . 0)
    \flat
  }
}

\new PianoStaff <<

  % RH
  \new Staff <<
    \clef treble
    \key c \major
    \time 9/16
    \set Score.currentBarNumber = #108

    % RH voice 1
    \new Voice {
      \voiceOne
      s4. s8. |
      s4. a''8[( \p \> g''16]) |
      g''4. af''8[( g''16]) |
      g''8.[ g''8. g''8.] \pp |
      g''8.[ af''8.af''8.] |
      af''8.[ af''8.af''8.] |
      \trillFlat
      af''4.~ \startTrillSpan
      af''8.~ |
      4.~ 8.~ |
      \oneVoice
      <af'' d''>8.[ a''8. \p \< bf''8.]~ |
      8.[ b''8. c'''8.]~
      \bar "||"
      \key ef \major
      c'''8.[ cs'''8.] \f \stopTrillSpan
      r8.
    }

    % RH voice 2
    \new Voice {
      \voiceTwo
      \override Voice.TrillSpanner.direction = #DOWN
      d''4.~ \f \startTrillSpan
      d''8.~ |
      4.~ 8.~ |
      8. \stopTrillSpan
      \trillFlat
      d''4.~ \startTrillSpan |
      d''4.~ 8.~ |
      4.~ 8.~ |
      4.~ 8.~ \stopTrillSpan |
      \trillFlat
      d''4.~ \startTrillSpan
      d''8. ~ |
      4.~ 8.~ |
      \once \override NoteColumn.ignore-collision = ##t
      \hideNotes
      d''8. \stopTrillSpan
      s4. |
      s8. s8.
    }

  >>

  % LH staff
  \new Staff {
    \clef bass
    \key c \major
    \time 9/16
    r8. r8. <c! c,!>8[( <g, g,,>16]) |
    <g, g,,>4.
    \clef treble
    c''8[( b'16]) |
    b'4. c''8[( b'16]) |
    b'8.[ b'8. b'8.] |
    b'8.[ bf'8.]
    \clef bass
    <f f,>8[( <bf, bf,,>16]) |
    <bf, bf,,>4.
    \clef treble
    f'8[( bf16]) |
    <<
      \new Voice {
        \voiceOne
        \override Voice.TrillSpanner.direction = #UP
        f'4.~ \startTrillSpan
        f'8.~ |
        4.~ 8.~ |
        8. \stopTrillSpan
      }
      \new Voice {
        \voiceTwo
        \override Voice.TrillSpanner.direction = #DOWN
        bf8.[ bf8. bf8.] |
        bf8.[ bf8. bf8.] |
        bf8.
      }
    >>
    \oneVoice
    r8. r8. |
    r8. r8. r8.
    \clef bass
    |
    \key ef \major
    r8. r8. r8.
  }
>>
