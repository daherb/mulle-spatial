concrete SpatialHTML of Spatial = SpatialI-[z,s] ** {
  param
    Rel = Besides | In | Above | OnTopOf | LeftOf | RightOf ;
  lincat
    Scene = Str ;
    Object = Str ;
    Relation = Rel ;
  lin
    z = "1" ;
    s z = z ++ "+ 1" ;
    -- Basic objects and relations
    otree = "\"../graphics/tree.svg\"" ;
    ohouse = "\"../graphics/house.svg\"" ;
    ogirl = "\"../graphics/girl.svg\"" ;
    obox = "\"../graphics/box.svg\"" ;
    oball = "\"../graphics/ball.svg\"" ;
    operson = "\"../graphics/person.svg\"" ;
    osun = "\"../graphics/sun.svg\"" ;
    otable = "\"../graphics/table.svg\"" ;
    rontopof = OnTopOf ;
    rin = In ;
    rabove = Above ; 
    rbesides = Besides ;
    rleftof = LeftOf ;
    rrightof = RightOf ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp =
      "<html>\n" ++
      "<svg height=\"600\" width=\"1000\">" ++
      --"<image x = \"(" ++ x1 ++ ")*200\" xlink:href="++ o1 ++ " y = \"(" ++ y1 ++ ")*200\" height=\"200\" width=\"200\"/>\n" ++
      --"<image x = \"(" ++ x2 ++ ")*200\" xlink:href="++ o2 ++ " y = \"(" ++ y2 ++ ")*200\" height=\"200\" width=\"200\"/>\n" ++
      "<image style=\"x : calc((" ++ x1 ++ ")*200); y: calc((" ++ y1 ++ ")*200);\" xlink:href="++ o1 ++ " height=\"200\" width=\"200\"/>\n" ++
      "<image style=\"x : calc((" ++ x2 ++ ")*200); y: calc((" ++ y2 ++ ")*200);\" xlink:href="++ o2 ++ " height=\"200\" width=\"200\"/>\n" ++
      "</svg>\n" ++
      "</html>\n"
      ;
} ;