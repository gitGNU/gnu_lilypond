\version "2.17.6"

\header {
  lsrtags = "ancient-notation, chords, contexts-and-engravers"

  texidoc = "
When writing a figured bass, you can place the figures above or below
the bass notes, by defining the
@code{BassFigureAlignmentPositioning.direction} property (exclusively
in a @code{Staff} context).  Choices are @code{#UP} (or @code{#1}),
@code{#CENTER} (or @code{#0}) and @code{#DOWN} (or @code{#-1}).

This property can be changed as many times as you wish.  Use
@code{\\once \\override} if you don't want the override to apply to the
whole score.

"
  doctitle = "Adding a figured bass above or below the notes"
}


bass = {
  \clef bass
  g4 b, c d
  e d8 c d2
}
continuo = \figuremode {
  <_>4 <6>4 <5/>4
  \override Staff.BassFigureAlignmentPositioning.direction = #UP
  %\bassFigureStaffAlignmentUp
  < _+ >4 <6>
  \set Staff.useBassFigureExtenders = ##t
  \override Staff.BassFigureAlignmentPositioning.direction = #DOWN
  %\bassFigureStaffAlignmentDown
  <4>4. <4>8 <_+>4
}
\score {
  <<
    \new Staff = bassStaff \bass
    \context Staff = bassStaff \continuo
  >>
}
