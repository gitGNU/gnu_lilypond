/*
  col-info.hh -- declare Colinfo

  source file of the GNU LilyPond music typesetter

  (c) 1997 Han-Wen Nienhuys <hanwen@stack.nl>
*/


#ifndef COL_INFO_HH
#define COL_INFO_HH

#include "lily-proto.hh"
#include "pointer.hh"
#include "interval.hh"
#include "assoc.hh"

/// helper struct for #Spacing_problem#
struct Colinfo {
  Paper_column *pcol_l_;
  P<Real> fixpos_p_;
  Assoc<int, Real> min_dists_assoc_;
  Interval width_;
  int rank_i_;
  /// did some tricks to make this column come out.
  bool ugh_b_;		
  /* *************** */
  Colinfo();
  Colinfo (Paper_column *,Real const *);

  int rank_i () const;
  void print() const;
  bool fixed_b() const ;
  Real fixed_position() const ;
};

#endif // COL_INFO_HH
