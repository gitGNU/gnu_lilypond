% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.0
\version "2.13.31"

\header {
%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
  texidoces = "
El «Makam» es un tipo de melodía de Turquía que
utiliza alteraciones microtonales de 1/9 de tono.  Consulte el
archivo de inicio @code{makam.ly} (véase el 'Manual de
aprendizaje @version{}, 4.6.3 Otras fuentes de información' para
averiguar la situación de este archivo) para ver detalles de los
nombres de las notas y las alteraciones.

"
  doctitlees = "Ejemplo de «Makam»"



%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Makam ist eine türkische Melodie, in der 1/9-Tonabstände
eingesetzt werden.  Sehen Sie sich die Initialisierungsdatei
@code{makam.ly} für weiter Information zu Tonhöhenbezeichnungen
und Alterationen an (siehe
Handbuch zum Lernen @version{}, 4.6.3 Weitere Information zu
Hinweisen, wo diese Datei gespeichert ist)."

  doctitlede = "Makam-Beispiel"

%% Translation of GIT committish: 4ab2514496ac3d88a9f3121a76f890c97cedcf4e
  texidocfr = "
Le « makam » est une forme de mélodie turque qui utilise des altérations
d'un neuvième de ton.  Consultez le fichier d'initialisation
@code{makam.ly} pour plus de détails sur les hauteurs et altérations
utilisées (voir le chapitre 4.6.3 - Autres sources d'information du
manuel d'initiation pour le localiser).

"
  doctitlefr = "Exemple de musique « Makam »"

  lsrtags = "pitches, world-music"
  texidoc = "
Makam is a type of melody from Turkey using 1/9th-tone microtonal
alterations.  Consult the initialization file @samp{ly/makam.ly} for
details of pitch names and alterations.

"
  doctitle = "Makam example"
} % begin verbatim


% Initialize makam settings
\include "makam.ly"

\relative c' {
  \set Staff.keySignature = #`((6 . ,(- KOMA)) (3 . ,BAKIYE))
  c4 cc db fk
  gbm4 gfc gfb efk
  fk4 db cc c
}
