%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.31"

\header {
  lsrtags = "keyboards"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
  texidoces = "
Un corchete de arpegio puede indicar que se tienen que tocar con la
misma mano notas que están en dos pentagramas distintos. Para hacerlo,
el @code{PianoStaff} se debe configurar para que acepte símbolos de
arpegio de pentagrama cruzado y los símbolos de arpegio se deben
configurar a la forma de corchete en el contexto de @code{PianoStaff}.

(Debussy, Les collines d’Anacapri, m. 65)

"
  doctitlees = "Indicar acordes de pentagrama cruzado con corchetes de arpegio"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Eine Arpeggioklammer kann anzeigen, dass Noten auf zwei unterschiedlichen
Systemen mit der selben Hand gespielt werden sollen.  Damit das notiert
werden kann, muss der @code{PianoStaff}-Kontext so eingestellt werden,
dass er Arpeggios über Systeme hinweg akzeptiert und die Form der Arpeggios
muss auf eine Klammer eingestellt werden.

(Debussy, Les collines d’Anacapri, T. 65)

"
  doctitlede = "Akkorde auf zwei Systemen mit Arpeggioklammern anzeigen"

  texidoc = "
An arpeggio bracket can indicate that notes on two different staves are
to be played with the same hand. In order to do this, the
@code{PianoStaff} must be set to accept cross-staff arpeggios and the
arpeggios must be set to the bracket shape in the @code{PianoStaff}
context.


(Debussy, Les collines d’Anacapri, m. 65)

"
  doctitle = "Indicating cross-staff chords with arpeggio bracket"
} % begin verbatim

\new PianoStaff <<
  \set PianoStaff.connectArpeggios = ##t
  \override PianoStaff.Arpeggio #'stencil = #ly:arpeggio::brew-chord-bracket
  \new Staff {
    \relative c' {
      \key b \major
      \time 6/8
      b8-.(\arpeggio fis'-.\> cis-. e-. gis-. b-.)\!\fermata^\laissezVibrer
      \bar "||"
    }
  }
  \new Staff {
    \relative c' {
      \clef bass
      \key b \major
      <<
        {
          <a e cis>2.\arpeggio
        }
        \\
        {
          <a, e a,>2.
        }
      >>
    }
  }
>>

