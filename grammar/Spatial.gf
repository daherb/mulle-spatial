abstract Spatial = open Predef in {
  flags startcat = Scene ;
  cat
    Scene ; Object ; Relation ; Num ; ValidRel Relation Object Object ; ValidPos Relation Num Num Num Num ; IsEqual Num Num ; IsLess Num Num ;
  fun
    z : Num ;
    s : Num -> Num ;
    n8 : Num ;
    n3 : Num ;
    otree, ohouse, osun, operson, ogirl, otable, obox, oball : Object ;
    rbesides, rleftof, rrightof, rin, rabove, rontopof : Relation ;
    treebesideshouse : ValidRel rbesides otree ohouse ;
    personbesideshouse : ValidRel rbesides operson ohouse ;
    girlbesideshouse : ValidRel rbesides ogirl ohouse ;
    personinhouse : ValidRel rin operson ohouse ;
    girlinhouse : ValidRel rin ogirl ohouse ;
    tableinhouse : ValidRel rin otable ohouse ;
    boxinhouse : ValidRel rin obox ohouse ;
    ballinhouse : ValidRel rin oball ohouse ;
    tableinbox : ValidRel rin otable obox ;
    ballinbox : ValidRel rin oball obox ;
    sunabovetree : ValidRel rabove osun otree ;
    sunabovehouse : ValidRel rabove osun ohouse ;
    sunaboveperson : ValidRel rabove osun operson ;
    ballontopoftable : ValidRel rontopof oball otable ;
    boxontopoftable : ValidRel rontopof obox otable ;
    leftofisbesides : (o1 : Object) -> (o2 : Object) -> ValidRel rbesides o1 o2 -> ValidRel rleftof o1 o2 ;
    rightofisbesides : (o1 : Object) -> (o2 : Object) -> ValidRel rbesides o1 o2 -> ValidRel rrightof o1 o2 ;
    ontopofisabove : (o1 : Object) -> (o2 : Object) -> ValidRel rontopof o1 o2 -> ValidRel rabove o2 o1 ;
    validinpos : (x1,y1,x2,y2 : Num) -> IsEqual x1 x2 -> IsEqual y1 y2 -> ValidPos rin x1 y1 x2 y2 ;
    validleftofpos : (x1,y1,x2,y2 : Num) -> IsEqual y1 y2 -> IsLess x1 x2 -> ValidPos rleftof x1 y1 x2 y2 ;
    validrightofpos : (x1,y1,x2,y2 : Num) -> IsEqual y1 y2 -> IsLess x2 x1 -> ValidPos rleftof x1 y1 x2 y2 ;
    equal : (n : Num) -> IsEqual n n ;
    lessz : IsLess z (s z);
    lesss : (n1, n2 : Num) -> IsLess n1 n2 -> IsLess (s n1) (s n2) ;
    lessn : (n1,n2,n3 : Num) -> IsLess n1 n2 -> IsLess n2 n3 -> IsLess n1 n3 ;
    place : (o1 : Object) -> (o2 : Object) -> (x1,y1,x2,y2 : Num) -> (r : Relation) -> ValidRel r o1 o2 -> ValidPos r x1 y1 x2 y2 -> Scene ;
}