concrete SpatialGer of Spatial = SpatialI ** SpatialLangI with (Constructors=ConstructorsGer) ** open ParadigmsGer, SyntaxGer, Prelude in {
  lincat
    Scene, FreeScene, EditScene = S ;
    Object = NP ;
    Relation = Prep ;
  lin
    -- Basic objects and relations
    otree = mkObject "Baum" masculine ;
    ohouse = mkObject "Haus" neuter ;
    obox = mkObject "Kiste" feminine ;
    oball = mkObject "Ball" masculine ;
    operson = mkObject "Person" feminine ;
    osun = mkObject "Sonne" feminine ;
    otable = mkObject "Tisch" masculine ;
    rontopof = mkPrep "auf" dative ;
    rin = mkPrep "in" dative ;
    rabove = mkPrep "über" dative ;
    rbeside = mkPrep "neben" dative;
    rnextto = mkPrep "direkt neben" dative ;
    rleftof = mkPrep "links von" dative ;
    rrightof = mkPrep "rechts von" dative ;
  oper
    mkObject : Str -> Gender -> NP = \o,g ->
      mkNP theSg_Det (mkN o g) ;
} ;
