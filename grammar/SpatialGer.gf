concrete SpatialGer of Spatial = open ParadigmsGer, SyntaxGer, Prelude in {
  lincat
    Scene = S ;
    Object = NP ;
    Relation = Prep ;
    ValidPos, ValidRel, Num, IsEqual, IsLess  = Str ;
  lin
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
    treebesideshouse,
      personbesideshouse,
      girlbesideshouse,
      personinhouse,
      girlinhouse, 
      tableinhouse,
      boxinhouse,
      ballinhouse,
      tableinbox,
      ballinbox,
      sunabovetree,
      sunabovehouse,
      sunaboveperson,
      ballontopoftable,
      boxontopoftable = "";
    leftofisbesides _ _  v = v ;
    rightofisbesides _ _  v = v ;
    n1 = "1" ; n2 = "2" ; n3 = "3" ; n4 = "4" ;
    n5 = "5" ; n6 = "6" ; n7 = "7" ; n8 = "8" ;
    equal n = n ;
    less1, less2, less3, less4, less5, less6, less7 = "" ;
    lessn n1 n2 n3 l1 l2 = n1 ++ n2 ++ l1 ++ l2 ;
    validinpos x1 y1 x2 y2 e1 e2 = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ;
    validleftofpos x1 y1 x2 y2 e l = x1 ++ y1 ++ x2 ++ y2 ++ e ++ l ;
    validrightofpos x1 y1 x2 y2 e l = x1 ++ y1 ++ x2 ++ y2 ++ e ++ l ;
    place o1 o2 x1 y1 x2 y2 r vr vp = 
      mkS presentTense simultaneousAnt positivePol (mkCl o1 (mkAdv r o2)) ;
  oper
    mkObject : Str -> Gender -> NP = \o,g ->
      mkNP theSg_Det (mkN o g) ;
};