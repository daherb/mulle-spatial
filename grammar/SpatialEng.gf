concrete SpatialEng of Spatial = SpatialI ** SpatialLangI with (Constructors=ConstructorsEng) ** open ParadigmsEng, SyntaxEng, Prelude in {
  lincat
    Scene, FreeScene, EditScene = S ;
    Object = NP ;
    Relation = Prep ;
  lin
    -- Basic objects and relations
    otree = mkObject "tree" ;
    ohouse = mkObject "house" ;
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
  oper
    mkObject : Str -> NP = \o ->
      mkNP theSg_Det (mkN o) ;
} ;
