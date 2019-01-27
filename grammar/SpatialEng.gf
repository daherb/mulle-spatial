concrete SpatialEng of Spatial = SpatialI ** open ParadigmsEng, (C=ConstructorsEng), SyntaxEng, Prelude in {
  lincat
    Scene = S ;
    Object = NP ;
    Relation = Prep ;
  lin
    -- Basic objects and relations
    otree = mkObject "tree" ;
    ohouse = mkObject "house" ;
    ogirl = mkObject "girl" ;
    obox = mkObject "box" ;
    oball = mkObject "ball" ;
    operson = mkObject "person" ;
    osun = mkObject "sun" ;
    otable = mkObject "table" ;
    rontopof = mkPrep "on top of" ;
    rin = mkPrep "in" ;
    rabove = mkPrep "above" ;
    rbeside = mkPrep "beside" ;
    rnextto = mkPrep "next to" ;
    rleftof = mkPrep "left of" ;
    rrightof = mkPrep "right of" ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp = 
      mkS presentTense simultaneousAnt positivePol (mkCl o1 (C.mkAdv r o2)) ;
  oper
    mkObject : Str -> NP = \o ->
      mkNP theSg_Det (mkN o) ;
} ;
