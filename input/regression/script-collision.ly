\version "2.6.0"

\header {

  texidoc = "Scripts are put on the utmost head, so they are
      positioned correctly when there are collisions."
}


\relative c'' {
  c4
  <c d c'>\marcato
  <<  { c4^^ }\\
      { d4_^ } >>
}
\layout { raggedright = ##t}


