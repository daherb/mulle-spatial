incomplete concrete SpatialI of Spatial = {
  lincat
    StackeddObject, BaseObject, ExternalObject, InsideObject,
      BesideObject, OnTopOfObject, AboveObject, BelowObject  = Str ;
    ValidPos, ValidRel, Num, InRange, IsEqual, IsLess  = Str ;
  lin
    -- Basic numbers
    z, n1, n2, n3, n4, n5 = "" ;
    s n = n ;
    equal n = n ;
    lessz = "" ;
    lesss n1 n2 l = n1 ++ n2 ++ l ;
    lesst n1 n2 n3 l1 l2 = n1 ++ n2 ++ n3 ++ l1 ++ l2 ;
        -- Restrictions on objects
    treebeside = "" ;
    housebeside = "" ;
    personbeside = "" ;
    girlbeside = "" ;
    tablebeside = "" ;
    boxbeside = "" ;
    ballbeside = "" ; 
--    personin = "" ;
--    girlin = "" ;
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
    boxinhouse = "" ;
    girlinhouse = "" ;
    personinhouse = "" ;
    treeinbox = "" ;
    validbeside o1 o2 r1 r2 = r1 ++ r2 ;
    validin o1 o2 r1 r2 = r1 ++ r2 ;
    validabove o1 o2 r1 r2 = r1 ++ r2 ;
    validontop o1 o2 r1 r2 = r1 ++ r2 ;
    -- Coerce relations
    nexttoisbeside o1 o2 r = r ;
    leftofisbeside o1 o2 r = r ;
    rightofisbeside o1 o2 r = r ;
    ontopofisabove o1 o2 r = r ;
    -- Restrictions on positions
    inrange x1 y1 x2 y2 l1 l2 l3 l4 = x1 ++ y1 ++ x2 ++ y2 ++ l1 ++ l2 ++ l3 ++ l4 ;
    validinpos x1 y1 x2 y2 e1 e2 e3 r = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ++ e3 ++ r ;
    validnexttoleftpos x1 y1 x2 y2 e1 e2 e3 r = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ++ e3 ++ r ;
    validnexttorightpos x1 y1 x2 y2 e1 e2 e3 r = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ++ e3 ++ r ;
    validleftofpos x1 y1 x2 y2 e1 e2 l r = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ++ l ++ r ;
    validrightofpos x1 y1 x2 y2 e1 e2 l r = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ++ l ++ r ;
    validabovepos x1 y1 x2 y2 l e1 e2 r = x1 ++ y1 ++ x2 ++ y2 ++ l ++ e1 ++ e2 ++ r ;
    validontopofpos x1 y1 x2 y2 e1 e2 e3 r = x1 ++ y1 ++ x2 ++ y2 ++ e1 ++ e2 ++ e3 ++ r ;
} ;