\version "2.10.12"

\header { texidoc = "
This is a Scheme function which prints a tempo mark such as
    Fast (♩= 222)
" }

tempoMark =
    #(define-music-function (parser location prependText notevalue appendText) (string? string? string?)
        #{
            \mark \markup
            { \line { $prependText " (" \fontsize #-2 \general-align #Y #DOWN \note #$notevalue #1 $appendText ) } }
        #})

theMusic =
{
    \once \override Score.RehearsalMark #'self-alignment-X = #-1
    \time 4/4 \tempoMark "Fast" "4" "= 220-222" s1    
}

\score
{
    \theMusic
}
