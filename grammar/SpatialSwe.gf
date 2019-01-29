concrete SpatialSwe of Spatial = SpatialI ** open ParadigmsSwe, (C=ConstructorsSwe), SyntaxSwe, Prelude in {
  lincat
    Scene = S ;
    Object = NP ;
    Relation = Prep ;
  lin
    -- Basic objects and relations
    otree = mkObject "träd" neutrum ;
    ohouse = mkObject "hus" neutrum ;
    ogirl = mkObject "flicka" utrum ;
    obox = mkObject "låda" utrum ;
    oball = mkObject "boll" utrum ;
    operson = mkObject "person" utrum ;
    osun = mkObject "sol" utrum ;
    otable = mkObject "bord" neutrum ;
    rontopof = mkPrep "ovanpå" ;
    rin = mkPrep "i" ;
    rabove = mkPrep "över" ;
    rbeside = mkPrep "intill" ;
    rnextto = mkPrep "alldeles intill" ;
    rleftof = mkPrep "till vänster av" ;
    rrightof = mkPrep "till höger av" ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp = 
      mkS presentTense simultaneousAnt positivePol (mkCl o1 (C.mkAdv r o2)) ;
  oper
    mkObject : Str -> Gender -> NP = \o,g ->
      mkNP theSg_Det (mkN o g) ;
} ;
