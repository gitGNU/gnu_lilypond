%%  Do not edit this file; it is auto-generated from LSR!
\version "2.11.35"

\header { texidoc = "
Ambits can be added per voice. In that case, the ambitus must be moved
manually to prevent collisions. 
" }

{
\new Staff <<
  \new Voice \with {
    \consists "Ambitus_engraver"
  } \relative c'' {
    \override Ambitus #'X-offset = # 2.0
    \voiceOne
    c4 a d e f1
  }
  \new Voice \with {
    \consists "Ambitus_engraver"
  } \relative c' {
    \voiceTwo
	es4 f g as b1
  }
>>

}
