--# -path=/home/herb/src/own/gf-rgl/src/latin:/home/herb/src/own/gf-rgl/src/latin/api
concrete SpatialLat of Spatial = SpatialI ** open ParadigmsLat, SyntaxLat, Prelude in {
  lincat
    Scene = S ;
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
    rontopof = mkPrep "supra" acc ;
    rin = mkPrep "in" acc ;
    rabove = mkPrep "supra" acc ; -- Latin does not seem to make a difference
    rbeside = mkPrep "vicinus" acc ;
    rnextto = mkPrep "vicinus" acc ;
    rleftof = mkPrep "sinister" acc ;
    rrightof = mkPrep "dexter" acc ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp = 
      mkS presentTense simultaneousAnt positivePol (mkCl o1 (mkAdv r o2)) ;
  oper
    mkObject = overload {
      mkObject : Str -> NP = \o ->
        mkNP theSg_Det (mkN o) ;
      mkObject : N -> NP = \n ->
	mkNP theSg_Det n ;
      };
} ;
