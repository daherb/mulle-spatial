concrete SpatialGer of Spatial = SpatialI ** open ParadigmsGer, SyntaxGer, Prelude in {
  lincat
    Scene = S ;
    Object = NP ;
    Relation = Prep ;
  lin
    -- Basic objects and relations
    otree = mkObject "Baum" masculine ;
    ohouse = mkObject "Haus" neuter ;
    ogirl = mkObject "Mädchen" neuter ;
    obox = mkObject "Kiste" feminine ;
    oball = mkObject "Ball" masculine ;
    operson = mkObject "Person" feminine ;
    osun = mkObject "Sonne" feminine ;
    otable = mkObject "Tisch" masculine ;
    rontopof = mkPrep "auf" dative ;
    rin = mkPrep "in" dative ;
    rabove = mkPrep "über" dative ;
    rbesides = mkPrep "neben" dative;
    rleftof = mkPrep "links von" dative ;
    rrightof = mkPrep "rechts von" dative ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp = 
      mkS presentTense simultaneousAnt positivePol (mkCl o1 (mkAdv r o2)) ;
  oper
    mkObject : Str -> Gender -> NP = \o,g ->
      mkNP theSg_Det (mkN o g) ;
} ;