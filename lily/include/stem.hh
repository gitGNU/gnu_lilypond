/*
  stem.hh -- declare Stem

  (c) 1996--1999 Han-Wen Nienhuys
*/

#ifndef STEM_HH
#define STEM_HH
#include "item.hh"
#include "array.hh"
#include "moment.hh"
#include "molecule.hh"
#include "staff-symbol-referencer.hh"
#include "directional-element.hh"

/**the rule attached to the ball.
  takes care of:

  \begin{itemize}
  \item the rule
  \item the flag
  \item up/down position.
  \end{itemize}

  should move beam_{left, right} into Beam

  TODO.
  
  Stem size depends on flag.

  elt properties:

  beam_dir: direction of the beam (int)

  dir_force: is direction explicitely specified? (bool)

  /// how many abbrev beam don't reach stem?
  int beam_gap_i_;


  
  */
// todo: remove baseclass Staff_symbol_referencer, since stem
// can be across a staff.
class Stem : public Item, public Staff_symbol_referencer,
	     public Directional_element
{

  /**extent of the stem (positions).
    fractional, since Beam has to adapt them.
    */
  Drul_array<Real> yextent_drul_;

public:

    
  /// log of the duration. Eg. 4 -> 16th note -> 2 flags
  int flag_i_;

  /** 
    don't print flag when in beam.
    our beam, for aligning abbrev flags
   */
  Beam* beam_l () const;
  Note_head * first_head () const;

  Drul_array<int> beams_i_drul_;
  Stem ();
    
  /// ensure that this Stem also encompasses the Notehead #n#
  void add_head (Rhythmic_head*n);
  void beamify ();

  Real hpos_f () const;
  Real chord_start_f () const;
  
  int type_i () const;

  void do_print() const;
  void set_stemend (Real);
  Direction get_default_dir() const;

  int get_center_distance(Direction) const;

  void set_default_stemlen();
  void set_default_extents();
  void set_noteheads();

  Real stem_length_f() const;
  Real stem_end_f() const;
  Real stem_begin_f() const;
  Real note_delta_f () const;

  bool invisible_b() const;
    
  /// heads that the stem encompasses (positions)
  Interval_t<int> head_positions() const;

protected:
  Molecule flag () const;

  virtual void do_pre_processing();
  static Interval dim_callback (Dimension_cache const*);
  virtual Molecule* do_brew_molecule_p() const;

  void set_spacing_hints () ;
};
#endif
