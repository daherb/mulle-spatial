concrete SpatialGer of Spatial = open ParadigmsGer, SyntaxGer, Prelude in {
  lincat
    Scene = S ;
    Object = NP ;
    Relation = Prep ;
    StackeddObject, BaseObject, ExternalObject, InsideObject,
      BesidesObject, OnTopOfObject, AboveObject, BelowObject  = Str ;
    ValidPos, ValidRel, Num, InRange, IsEqual, IsLess  = Str ;
    
  lin
    -- Basic numbers
    z, n1, n2, n3, n4, n5 = "" ;
    s n = n ;
    equal n = n ;
    lessz = "" ;
    lesss n1 n2 l = n1 ++ n2 ++ l ;
    lesst n1 n2 n3 l1 l2 = n1 ++ n2 ++ n3 ++ l1 ++ l2 ;
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
    -- Restrictions on objects
    treebesides = "" ;
    housebesides = "" ;
    personbesides = "" ;
    girlbesides = "" ;
    tablebesides = "" ;
    boxbesides = "" ;
    ballbesides = "" ; 
    personin = "" ;
    girlin = "" ;
    tablein = "" ;
    boxin = "" ;
    ballin = "" ;
    houseout = "" ;
    boxout = "" ;
    sunabove = "" ;
    treebelow = "" ;
    housebelow = "" ;
    personbelow = "" ;
    girlbelow = "" ;
    tablebase = "" ;
    ballontop = "" ;
    boxontop = "" ;
    validbesides o1 o2 r1 r2 = r1 ++ r2 ;
    validin o1 o2 r1 r2 = r1 ++ r2 ;
    validabove o1 o2 r1 r2 = r1 ++ r2 ;
    validontop o1 o2 r1 r2 = r1 ++ r2 ;
    -- Coerce relations
    leftofisbesides o1 o2 r = r ;
    rightofisbesides o1 o2 r = r ;
    ontopofisabove o1 o2 r = r ;
    -- Restrictions on positions
    inrange x1 y1 x2 y2 l1 l2 l3 l4 = x1 ++ y1 ++ x2 ++ y2 ++ l1 ++ l2 ++ l3 ++ l4 ;
    validinpos x1 y1 x2 y2 e1 e2 r = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ++ r ;
    validleftofpos x1 y1 x2 y2 e l r = x1 ++ y1 ++ x2 ++ y2 ++ e ++ l ++ r ;
    validrightofpos x1 y1 x2 y2 e l r = x1 ++ y1 ++ x2 ++ y2 ++ e ++ l ++ r ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp = 
      mkS presentTense simultaneousAnt positivePol (mkCl o1 (mkAdv r o2)) ;
  oper
    mkObject : Str -> Gender -> NP = \o,g ->
      mkNP theSg_Det (mkN o g) ;
};