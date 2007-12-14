%%  Do not edit this file; it is auto-generated from LSR!
\version "2.11.35"

\header { texidoc = "
By default, beams can't be printed across line breaks. Here's a way to
force the line break, by setting the @code{#'breakable} property. See
also in the manual the \"Line Breaking\" and \"Manual beams\" sections.
" }

\layout { ragged-right= ##t }

\relative c''  {
  \override Score.Beam #'breakable = ##t
  \time 3/16 c16-[ d e \break f-] 
}
