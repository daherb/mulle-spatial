concrete SpatialHTML of Spatial = SpatialI-[z,s] ** {
  param
    Rel = Beside | NextTo | In | Above | OnTopOf | LeftOf | RightOf ;
  lincat
    Scene = Str ;
    Object = Str ;
    Relation = Rel ;
  lin
    z = "0" ;
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
    rbeside = Beside ;
    rleftof = LeftOf ;
    rrightof = RightOf ;
    rnextto = NextTo ;
    -- Put everything together as a scene
    place o1 o2 x1 y1 x2 y2 r vr vp =
      let
	width= case r of {
	  In => "\"80\"";
	  _ => "\"100\""
	  } ;
	xoffset= case r of {
	  In => "10" ;
	  _ => "0"
	  } ;
      in
      "<html>\n" ++
      "<svg height=\"300\" width=\"500\">" ++
      "<image style=\"x : calc((" ++ x1 ++ ")*100 + " ++ xoffset ++ "); y: calc((2 - (" ++ y1 ++ "))*100);\" xlink:href="++ o1 ++ " height=\"100\" width=" ++ width ++ " />\n" ++
      "<image style=\"x : calc((" ++ x2 ++ ")*100); y: calc((2 - (" ++ y2 ++ "))*100);\" xlink:href="++ o2 ++ " height=\"100\" width=\"100\"/>\n" ++
      "</svg>\n" ++
      "</html>\n"
      ;
} ;