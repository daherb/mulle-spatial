concrete SpatialProlog of Spatial = SpatialI ** open Prelude in {
  lincat Object, Relation, Scene, EditScene, FreeScene = Str ;
  lin
    oball = "ball" ;
    obox = "box";
    ogirl = "girl" ;
    ohouse = "house" ;
    operson = "person" ;
    osun = "sun" ;
    otable = "table" ;
    otree = "tree" ;
    rabove = "above" ;
    rbeside = "beside" ;
    rin = "in" ;
    rleftof = "leftOf" ;
    rnextto = "nextTo" ;
    rontopof = "onTopOf" ;
    rrightof = "rightOf" ;
    constraintPlace o1 o2 x1 y1 x2 y2 r _ _ =  mkScene o1 o2 x1 y1 x2 y2 r ;
    freePlace o1 o2 r _ = mkScene o1 o2 r "" "" "" "" ;
    freeEdit o1 o2 r = mkScene o1 o2 r "" "" "" "" ;
  oper
    mkScene : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str =
      \o1,o2,x1,y1,x2,y2,r ->
      "scene :-" ++ "\n"
      ++ "\t" ++ o1 ++ BIND ++ "(X),\n"
      ++ "\t" ++ o2 ++ BIND ++ "(Y),\n"
      ++ "\t" ++ "pos(X," ++ x1 ++ "," ++ y1 ++ ").\n"
      ++ "\t" ++ "pos(Y," ++ x2 ++ "," ++ y2 ++ ").\n"
      ++ "\t" ++ r  ++ BIND ++ "(X,Y).\n"
      ;
}