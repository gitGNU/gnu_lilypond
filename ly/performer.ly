%
% setup for Request->Element conversion. Guru-only
%
StaffContext = \translator {
	\type "Staff_performer";
	\name Staff;
	\accepts Voice;

	\accepts VoiceOne;		% ugh.
	\accepts VoiceTwo;
	\accepts VoiceThree;
	\accepts VoiceFour;

	\consists "Key_performer";
	\consists "Time_signature_performer";
};
\translator { \StaffContext }

%% urg, why (needs praeludium-*.ly) these?
\translator
{
	\type "Performer_group_performer";
	\consists "Note_performer";
	 \name VoiceFour;
}

\translator
{
	\type "Performer_group_performer";
	\consists "Note_performer";
	\name VoiceThree;
}
\translator {
	\type "Performer_group_performer";
	\consists "Note_performer";
	 \name VoiceOne;
}

VoiceContext = \translator {
	\type "Performer_group_performer";
	\name Voice;
% All notes fall to Grace if you leave Thread out (huh?)
	\consists "Grace_position_performer";
	\accepts Thread;
	\accepts Grace;
};
\translator { \VoiceContext }

GraceContext = \translator {
	\type "Performer_group_performer";
	\name Thread;
	\consists "Note_performer";
	\consists "Tie_performer";
};
\translator { \GraceContext }

\translator {
	\type "Grace_performer_group";
	\name Grace;
	\consists "Note_performer";
	\consists "Tie_performer";
	 weAreGraceContext = "1";
}

\translator
{
	\type "Performer_group_performer";
	\name VoiceTwo;\consists "Note_performer";

}

GrandStaffContext = \translator {
	\type "Performer_group_performer";
	\name GrandStaff;
	\accepts Staff;
};
\translator { \GrandStaffContext }

PianoStaffContext = \translator {
        \type "Performer_group_performer";
	\name "PianoStaff";
	\accepts Staff;
};
\translator { \PianoStaffContext }

\translator {
	\type "Performer_group_performer";
	\consists "Lyric_performer";
	\name LyricVoice;
}

\translator{
	\type "Performer_group_performer";
	\name ChoirStaff;
	\accepts Staff;
}
\translator { 
	\type "Staff_performer";
	\accepts LyricVoice;
	\name Lyrics;
	\consists "Time_signature_performer";
}
\translator {
	\type Performer_group_performer;

	\name StaffGroup;
	\accepts Staff;
}

ScoreContext = \translator {
	\type "Score_performer";

	\name Score;
	instrument = "bright acoustic";
	\accepts Staff;
	\accepts GrandStaff;
	\accepts PianoStaff;
	\accepts Lyrics; 
	\accepts StaffGroup;
	\accepts ChoirStaff;
	\consists "Swallow_performer";
};
\translator { \ScoreContext }

