LANGS="Swe Eng Ger Lat Prolog HTML"
GRAMMAR="Spatial"
for l in $LANGS; do GRAMMARS="$GRAMMARS $GRAMMAR$l.gf"; done
gf -make $GRAMMARS
