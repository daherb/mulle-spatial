--# -path=/home/herb/src/own/gf-rgl/src/latin:/home/herb/src/own/gf-rgl/src/latin/api
concrete SpatialLat of Spatial = SpatialI ** open ParadigmsLat, (C=Constructors), SyntaxLat, Prelude, ResLat in {
  lincat
    Scene = Str ;
    Object = NP ;
    Relation = Prep ;
  lin
    -- Basic objects and relations
    otree = mkObject (mkN "arbor" "arboris" feminine ) ;
    ohouse = mkObject "domus" ;
    ogirl = mkObject "puella" ;
    obox = mkObject "capsula" ;
    oball = mkObject "pila" ;
    operson = mkObject (mkN "homo" "hominis" masculine ) ;
    osun = mkObject (mkN "sol" "solis" masculine ) ;
    otable = mkObject "mensa" ;
    rontopof = lin Prep (mkPrep "supra" acc) ;
    rin = lin Prep (mkPrep "in" abl) ;
    rabove = lin Prep (mkPrep "supra" acc) ; -- Latin does not seem to make a difference
    rbeside = lin Prep (mkPrep "prope" acc) ;
    rnextto = lin Prep (mkPrep "iuxta" acc) ;
    rleftof = lin Prep (mkPrep "sinistra" abl) ;
    rrightof = lin Prep (mkPrep "dextra" abl) ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp = 
      combineSentence (mkS presentTense simultaneousAnt positivePol (mkCl o1 (mkAdv r o2))) ! SPreO ! PreO ! SOV ;
  oper
    mkObject = overload {
      mkObject : Str -> NP = \o ->
        mkNP theSg_Det (mkN o) ;
      mkObject : N -> NP = \n ->
	mkNP theSg_Det n ;
      };
} ;
