/*   
  chord-tremolo-iterator.cc --  implement Chord_tremolo_iterator
  
  source file of the GNU LilyPond music typesetter
  
  (c) 2000 Han-Wen Nienhuys <hanwen@cs.uu.nl>
  
 */


/*
  this is culled from various other iterators, but sharing code by subclassing proved to be too difficult.
 */

#include "chord-tremolo-iterator.hh"
#include "repeated-music.hh"

void
Chord_tremolo_iterator::construct_children ()
{
  Repeated_music const* rep = dynamic_cast<Repeated_music const*> (music_l_);
  factor_  = Moment (1, rep->repeats_i_);
  child_iter_p_ = get_iterator_p (rep->repeat_body_p_);
}

Chord_tremolo_iterator::Chord_tremolo_iterator()
{
  factor_ = 1;
  child_iter_p_ = 0;
}

void
Chord_tremolo_iterator::do_process_and_next (Moment m)
{
  if (!m)
    {
      Music_iterator *yeah = try_music (music_l_);
      if (yeah)
	set_translator (yeah->report_to_l ());
      else
	music_l_->warning ( _("no one to print a tremolos"));
    }

  child_iter_p_->process_and_next  (factor_ * m);
}


Moment
Chord_tremolo_iterator::next_moment () const
{
  return child_iter_p_->next_moment () / factor_;
}

bool
Chord_tremolo_iterator::ok () const
{
  return child_iter_p_ && child_iter_p_->ok();
}

Chord_tremolo_iterator::~Chord_tremolo_iterator ()
{
  delete child_iter_p_;
}

Music_iterator*
Chord_tremolo_iterator::try_music_in_children (Music const *m) const
{
  return child_iter_p_->try_music (m);
}


void
Chord_tremolo_iterator::do_print () const
{
  child_iter_p_->print  ();
}
