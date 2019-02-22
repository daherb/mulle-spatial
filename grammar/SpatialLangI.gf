incomplete concrete SpatialLangI of Spatial = SpatialI ** open Constructors in {
  lin
    -- Put everything together as a scene
    constraintPlace o1 o2 x1 y1 x2 y2 r vr vp = mkScene (lin Object o1) (lin Object o2) (lin Relation r) ;
--      mkS presentTense simultaneousAnt positivePol (mkCl o1 (C.mkAdv r o2)) ;
    freePlace o1 o2 r vr = mkScene (lin Object o1) (lin Object o2) (lin Relation r) ;
    freeEdit o1 o2 r = mkScene (lin Object o1) (lin Object o2) (lin Relation r) ;

  oper
    mkScene : Object -> Object -> Relation -> S =
      \o1,o2,r -> 
      mkS presentTense simultaneousAnt positivePol (mkCl (lin NP o1) (Constructors.mkAdv (lin Prep r) (lin NP o2))) ;
}