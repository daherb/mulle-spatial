--# -path=/home/herb/src/own/gf-rgl/src/latin:/home/herb/src/own/gf-rgl/src/latin/api
concrete SpatialLat of Spatial = SpatialI ** open ParadigmsLat, SyntaxLat, Prelude, ResLat in {
  lincat
    Scene, FreeScene, EditScene = Str ;
    Object = NP ;
    Relation = Prep ;
  lin
    -- Basic objects and relations
    otree = mkObject (mkN "arbor" "arboris" feminine ) ;
    ohouse = mkObject "domus" ;
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
    constraintPlace o1 o2 x1 y1 x2 y2 r vr vp = mkScene (lin Object o1) (lin Object o2) (lin Relation r) ;
    freePlace o1 o2 r vr = mkScene (lin Object o1) (lin Object o2) (lin Relation r) ;
    freeEdit o1 o2 r = mkScene (lin Object o1) (lin Object o2) (lin Relation r) ;
  oper
    mkObject = overload {
      mkObject : Str -> NP = \o ->
        mkNP theSg_Det (mkN o) ;
      mkObject : N -> NP = \n ->
	mkNP theSg_Det n ;
      };

    mkScene : Object -> Object -> Relation -> Str =
      \o1,o2,r -> combineSentence (mkS presentTense simultaneousAnt positivePol (mkCl (lin NP o1) (mkAdv (lin Adv r) (lin NP o2)))) ! SPreO ! PreO ! SOV ;
} ;
