/*
  extender-spanner.cc -- implement Extender_spanner

  source file of the GNU LilyPond music typesetter

  (c) 1998, 1999 Jan Nieuwenhuizen <janneke@gnu.org>
*/

/*
  TODO: too complicated implementation.  Why the dx_drul?.
 */


#include "box.hh"
#include "debug.hh"
#include "lookup.hh"
#include "molecule.hh"
#include "paper-column.hh"
#include "paper-def.hh"
#include "extender-spanner.hh"

Extender_spanner::Extender_spanner ()
  : Directional_spanner ()
{
  dx_f_drul_[LEFT] = dx_f_drul_[RIGHT] = 0.0;
}


Offset
Extender_spanner::center () const
{
  Real dx = extent (X_AXIS).length ();

  return Offset (dx / 2, 0);
}

Molecule*
Extender_spanner::do_brew_molecule_p () const
{
  Molecule* mol_p = new Molecule;

  Real w = extent (X_AXIS).length ();
  
  w += (dx_f_drul_[RIGHT] - dx_f_drul_[LEFT]);
  Real h = paper_l ()->get_var ("extender_height");
  Molecule a = lookup_l ()->filledbox ( Box (Interval (0,w), Interval (0,h)));
  a.translate (Offset (dx_f_drul_[LEFT], 0));

  mol_p->add_molecule (a);

  return mol_p;
}

Interval
Extender_spanner::do_height () const
{
  return Interval (0,0);
}

void
Extender_spanner::do_post_processing ()
{
  // UGH
  Real gap = paper_l ()->get_var ("interline");

  Direction d = LEFT;
  do
    {
      Item* t = spanned_drul_[d]
	? spanned_drul_[d] : spanned_drul_[(Direction)-d];
      if (d == LEFT)
        dx_f_drul_[d] += t->extent (X_AXIS).length ();
      else
	dx_f_drul_[d] -= d * gap / 2;
    }
  while (flip(&d) != LEFT);
}

  
void
Extender_spanner::set_textitem (Direction d, Item* textitem_l)
{
  set_bounds (d, textitem_l);
  add_dependency (textitem_l);
}


