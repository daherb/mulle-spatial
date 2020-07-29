module SpatialEng where

open import SpatialAbs
open import Data.String

linRelation : Relation → String
linRelation rbeside = "beside"
linRelation rleftof = "left of"
linRelation rrightof = "right of"
linRelation rin = "in"
linRelation rabove = "above"
linRelation rontopof = "on top of"
linRelation rnextto = "next to"

linObject : Object → String
linObject otree = "tree"
linObject ohouse = "house"
linObject osun = "sun"
linObject operson = "person"
linObject otable = "table"
linObject obox = "box"
linObject oball = "ball"

linScene : Scene → String
linScene (constraintPlace o1 o2 x1 y1 x2 y2 r x x₁) = "the " ++ (linObject o1) ++ " is " ++ (linRelation r) ++ " the " ++ (linObject o2)
