abstract Spatial = open Predef in {
  flags startcat = Scene ;
  cat
    Scene ; Object ; Relation ;
    StackeddObject Object ; BaseObject Object ; ExternalObject Object ;
    InsideObject Object ; BesidesObject Object ; OnTopOfObject Object ;
    AboveObject Object ; BelowObject Object ;
    ValidRel Relation Object Object ; ValidPos Relation Num Num Num Num ;
    Num ; IsEqual Num Num ; IsLess Num Num ;
    InRange Num Num Num Num ;
  fun
    -- Basic numbers
    z : Num ;
    s : Num -> Num ;
    n1 : Num ;
    n2 : Num ;
    n3 : Num ;
    n4 : Num ;
    n5 : Num ;
    -- n6 : Num ;
    -- n7 : Num ;
    -- n8 : Num ;
    equal : (n : Num) -> IsEqual n n ;
    lessz : IsLess z (s z);
    lesss : (n1, n2 : Num) -> IsLess n1 n2 -> IsLess (s n1) (s n2) ;
    lesst : (n1,n2,n3 : Num) -> IsLess n1 n2 -> IsLess n2 n3 -> IsLess n1 n3 ;
    -- Basic objects and relations
    otree, ohouse, osun, operson, ogirl, otable, obox, oball : Object ;
    rbesides, rleftof, rrightof, rin, rabove, rontopof : Relation ;
    -- Restrictions on objects
    treebesides : BesidesObject otree ;
    housebesides : BesidesObject ohouse ;
    personbesides : BesidesObject operson ;
    girlbesides : BesidesObject ogirl ;
    tablebesides : BesidesObject otable ;
    boxbesides : BesidesObject obox ;
    ballbesides : BesidesObject oball ;
    -- personin : InsideObject operson ;
    -- girlin : InsideObject ogirl ;
    tablein : InsideObject otable ;
    boxin : InsideObject obox ;
    ballin : InsideObject oball ;
    houseout : ExternalObject ohouse ;
    boxout : ExternalObject obox ;
    sunabove : AboveObject osun ;
    treebelow : BelowObject otree ;
    housebelow : BelowObject ohouse ;
    personbelow : BelowObject operson ;
    girlbelow : BelowObject ogirl ;
    tablebase : BelowObject otable ;
    ballontop : OnTopOfObject oball ;
    boxontop : OnTopOfObject obox ;
    boxinhouse : ValidRel rin obox ohouse ;
    girlinhouse : ValidRel rin ogirl ohouse ;
    personinhouse : ValidRel rin operson ohouse ;
    treeinbox : ValidRel rin otree obox ;
    validbesides : (o1,o2 : Object) -> BesidesObject o1 -> BesidesObject o2 -> ValidRel rbesides o1 o2 ;
    validin : (o1,o2 : Object) -> InsideObject o1 -> ExternalObject o2 -> ValidRel rin o1 o2 ;
    validabove : (o1,o2 : Object) -> AboveObject o1 -> BelowObject o2 -> ValidRel rabove o1 o2 ;
    validontop : (o1,o2 : Object) -> OnTopOfObject o1 -> BaseObject o2 -> ValidRel rontopof o1 o2 ;
    -- Coerce relations
    leftofisbesides : (o1 : Object) -> (o2 : Object) -> ValidRel rbesides o1 o2 -> ValidRel rleftof o1 o2 ;
--    rightofisbesides : (o1 : Object) -> (o2 : Object) -> ValidRel rbesides o1 o2 -> ValidRel rrightof o1 o2 ;
--    ontopofisabove : (o1 : Object) -> (o2 : Object) -> ValidRel rontopof o1 o2 -> ValidRel rabove o2 o1 ;
    -- Restrictions on positions
    inrange : (x1,y1,x2,y2 : Num) -> IsLess x1 n5 -> IsLess x2 n5 -> IsLess y1 n3 -> IsLess y2 n3 -> InRange x1 y1 x2 y2 ;
    validinpos : (x1,y1,x2,y2 : Num) -> IsEqual x1 x2 -> IsEqual y1 y2 -> IsEqual y1 z -> InRange x1 y1 x2 y2 -> ValidPos rin x1 y1 x2 y2 ;
    validleftofpos : (x1,y1,x2,y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsLess x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rleftof x1 y1 x2 y2 ;
    validrightofpos : (x1,y1,x2,y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsLess x2 x1 -> InRange x1 y1 x2 y2 -> ValidPos rleftof x1 y1 x2 y2 ;
    validabovepos : (x1,y1,x2,y2 : Num) -> IsLess y2 y1 -> IsEqual y2 z -> IsEqual x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rabove x1 y1 x2 y2 ;
    validontopof : (x1,y1,x2,y2 : Num) -> IsEqual (s y2) y1 -> IsEqual y2 z -> IsEqual x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rontopof x1 y1 x2 y2 ;
    -- Put everything together as a scene
    place : (o1 : Object) -> (o2 : Object) -> (x1,y1,x2,y2 : Num) -> (r : Relation) -> ValidRel r o1 o2 -> ValidPos r x1 y1 x2 y2 -> Scene ;

  def
    n1 = s z ;
    n2 = s (s z) ;
    n3 = s (s (s z)) ;
    n4 = s (s (s (s z))) ;
    n5 = s (s (s (s (s z)))) ;
    -- n6 = s (s (s (s (s (s z))))) ;
    -- n7 = s (s (s (s (s (s (s z)))))) ;
    -- n8 = s (s (s (s (s (s (s (s z))))))) ;
    -- n9 = s (s (s (s (s (s (s (s (s z)))))))) ;
}