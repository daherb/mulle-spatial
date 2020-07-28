module SpatialAbs where

data Num : Set where
  z : Num
  s : Num → Num

n1 : Num
n1 = s z

n2 : Num
n2 =  s n1

n3 : Num
n3 = s n2

n4 : Num
n4 = s n3

n5 : Num
n5 = s n4

maxx : Num
maxx = n5

maxy : Num
maxy = n3

data Object : Set where
  otree : Object
  ohouse : Object
  osun : Object
  operson : Object
  otable : Object
  obox : Object
  oball : Object

data Relation : Set where
  rbeside : Relation
  rleftof : Relation
  rrightof : Relation
  rin : Relation
  rabove : Relation
  rontopof : Relation
  rnextto : Relation
data StackedObject : Object → Set where
data BaseObject : Object → Set where
  tablebase : BaseObject otable
data OutsideObject : Object → Set where
  houseout : OutsideObject ohouse
  boxout : OutsideObject obox
data InsideObject : Object → Set where
  tablein : InsideObject otable
  boxin : InsideObject obox
  ballin : InsideObject oball
data BesideObject : Object → Set where
  treebeside : BesideObject otree
  housebeside : BesideObject ohouse
  personbeside : BesideObject operson
  tablebeside : BesideObject otable
  boxbeside : BesideObject obox
  ballbeside : BesideObject oball
data OnTopObject : Object → Set where
  ballontop : OnTopObject oball
  boxontop : OnTopObject obox
data AboveObject : Object → Set where
  sunabove : AboveObject osun
  ballabove : AboveObject oball
data BelowObject : Object → Set where
  treebelow : BelowObject otree
  housebelow : BelowObject ohouse
  personbelow : BelowObject operson

data ValidRel : Relation → Object → Object → Set where
  boxinhouse : ValidRel rin obox ohouse
  personinhouse : ValidRel rin operson ohouse
  treeinbox : ValidRel rin otree obox
  validbeside : (o1 o2 : Object) → BesideObject o1 → BesideObject o2 → ValidRel rbeside o1 o2
  validin : (o1 o2 : Object) → InsideObject o1 → OutsideObject o2 → ValidRel rin o1 o2
  validabove : (o1 o2 : Object) → AboveObject o1 → BelowObject o2 → ValidRel rabove o1 o2
  validontop : (o1 o2 : Object) → OnTopObject o1 → BaseObject o2 → ValidRel rontopof o1 o2
  -- Coerce relations
  nexttoisbeside : (o1 o2 : Object) -> ValidRel rbeside o1 o2 -> ValidRel rnextto o1 o2
  leftofisbeside : (o1 o2 : Object) -> ValidRel rbeside o1 o2 -> ValidRel rleftof o1 o2
  rightofisbeside : (o1 o2 : Object) -> ValidRel rbeside o1 o2 -> ValidRel rrightof o1 o2
  ontopofisabove : (o1 o2 : Object) -> ValidRel rontopof o1 o2 -> ValidRel rabove o2 o1
    
data IsEqual : Num → Num → Set where
  equal : (n : Num) → IsEqual n n
  requal : (n n' : Num) → IsEqual n n' → IsEqual n' n

data IsLess : Num → Num → Set where
  lessz : (n : Num) → IsLess z (s n)
  lesss : (n1 n2 : Num) → IsLess n1 n2 → IsLess (s n1) (s n2)
  lesst : (n1 n2 n3 : Num ) → IsLess n1 n2 → IsLess n2 n3 → IsLess n1 n3


data InRange : Num -> Num -> Num -> Num -> Set where
  -- Restrictions on positions
  inrange : (x1 y1 x2 y2 : Num) -> IsLess x1 maxx -> IsLess x2 maxx -> IsLess y1 maxy -> IsLess y2 maxy -> InRange x1 y1 x2 y2

data ValidPos : Relation -> Num -> Num -> Num -> Num -> Set where
  validinpos : (x1 y1 x2 y2 : Num) -> IsEqual x1 x2 -> IsEqual y1 y2 -> IsEqual y1 z -> InRange x1 y1 x2 y2 -> ValidPos rin x1 y1 x2 y2
  validleftofpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsLess x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rleftof x1 y1 x2 y2
  validrightofpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsLess x2 x1 -> InRange x1 y1 x2 y2 -> ValidPos rrightof x1 y1 x2 y2
  validnexttoleftpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsEqual x2 (s x1) -> InRange x1 y1 x2 y2 -> ValidPos rnextto x1 y1 x2 y2
  validnexttorightpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsEqual (s x2) x1 -> InRange x1 y1 x2 y2 -> ValidPos rnextto x1 y1 x2 y2
  validabovepos : (x1 y1 x2 y2 : Num) -> IsLess y2 y1 -> IsEqual y2 z -> IsEqual x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rabove x1 y1 x2 y2
  validontopofpos : (x1 y1 x2 y2 : Num) -> IsEqual (s y2) y1 -> IsEqual y2 z -> IsEqual x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rontopof x1 y1 x2 y2

data Scene : Set where
  constraintPlace : (o1 o2 : Object) -> (x1 y1 x2 y2 : Num) -> (r : Relation) -> ValidRel r o1 o2 -> ValidPos r x1 y1 x2 y2 -> Scene
data FreeScene : Set where
   freePlace : (o1 o2 : Object) -> (r : Relation) -> ValidRel r o1 o2 -> FreeScene

test : Scene
test = constraintPlace obox ohouse z z z z rin boxinhouse (validinpos z z z z (requal z z (equal z)) (requal z z (equal z)) (equal z) (inrange z z z z (lessz (s (s (s (s z))))) (lessz (s (s (s (s z))))) (lessz (s (s z))) (lessz (s (s z)))))

-- test : Scene
-- test = constraintPlace oball operson z (s z) z z rabove  (validabove ballabove personbelow) (validabovepos lessz equal equal
--                                                                                            (inrange lessz lessz (lesss lessz) lessz))

-- test' : Scene
-- test' = constraintPlace oball otree z (s z) z z rabove (validabove ballabove treebelow) (validabovepos lessz equal equal
--                                                                                            (inrange lessz lessz (lesss lessz) lessz))

-- test'' : Scene
-- test'' = constraintPlace oball ohouse z ((s (s z))) z z rabove (validabove ballabove housebelow) (validabovepos lessz equal equal
--                                                                                                     (inrange lessz lessz (lesss (lesss lessz)) lessz))
-- test''' : Scene
-- test''' = constraintPlace obox otable (s (s z)) (s z) (s (s z)) z rontopof (validontop boxontop tablebase) (validontopofpos equal equal equal (inrange (lesss (lesss lessz)) (lesss (lesss lessz)) (lesss lessz)
--                                                                                                                                                  lessz))
