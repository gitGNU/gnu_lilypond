\version "2.6.0"

\header  {
texidoc = "Arpeggio stays clear of accidentals and flipped note heads."
}

\transpose c c' {
  <fis'' g d a>\arpeggio
  <fis, g d a>\arpeggio
  <fis'' g d a>\arpeggio
}
\layout {
  raggedright = ##t
  \context{
    \Staff
    connectArpeggios = ##t
  }
}


