%%  Do not edit this file; it is auto-generated from LSR!
\version "2.11.35"

\header { texidoc = "
You can alter the number of stems in a beam.  In this example, two sets
of four 32nds are joined, as if they were 8th notes.



" }

\relative {
  #(override-auto-beam-setting '(end * * * *)  1 4)
  f32 g a b b a g f

  f32 g a 
  \set stemRightBeamCount = #1  b
  \set stemLeftBeamCount = #1 b
  a g f
}

