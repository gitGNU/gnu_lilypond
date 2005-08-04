
\header
{

  texidoc = "Broken tuplets are adorned with little arrows. The arrows
  come from the @code{edge-text} property, and thus be replaced with
  larger glyphs or other text. "

}

\version "2.7.4"

\paper {
  raggedright = ##t  
  indent = 0.0
}


\relative c'' {
  \set tupletNumberFormatFunction = #fraction-tuplet-formatter

  \override TupletBracket #'edge-text = #(cons
					  (markup #:fontsize 6
					     #:arrow-head Y LEFT #f)
					  (markup #:arrow-head X RIGHT #f))
  \times 11/19 {
    c4 c4 c4 c4
    \bar "empty" \break
    c4 c4 c4 c4
    c4 c4 c4 c4
    \bar "empty" \break
    c4 c4 c4 c4
    c4 c4 c4 
  }
}   
