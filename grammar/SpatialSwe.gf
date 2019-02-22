concrete SpatialSwe of Spatial = SpatialI ** SpatialLangI with (Constructors=ConstructorsSwe)** open ParadigmsSwe, SyntaxSwe, Prelude in {
  lincat
    Scene, FreeScene, EditScene = S ;
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
  oper
    mkObject : Str -> Gender -> NP = \o,g ->
      mkNP theSg_Det (mkN o g) ;
} ;
