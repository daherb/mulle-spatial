module SpatialGer where

open import SpatialAbs
open import Data.String

data Gender : Set where
  fem : Gender
  masc : Gender
  neutr : Gender

data Case : Set where
  nom : Case
  acc : Case
  
record LinRelation : Set where
  constructor linrelation
  field
    relS : String
  
record LinObject : Set where
  constructor linobject
  field
    objS : String
    objG : Gender

record LinDet : Set where
  constructor lindet
  field
    detS : Gender → Case → String

linDet : LinDet
linDet = record { detS =
  λ where
    fem → λ where
      nom → "die"
      acc → "der"
    masc → λ where
      nom → "der"
      acc → "den"
    neutr → λ where
      nom → "das"
      acc → "dem" }

linRelation : Relation → LinRelation
linRelation rbeside = record { relS = "neben" }
linRelation rleftof = record { relS = "links von" }
linRelation rrightof = record { relS = "rechts von" }
linRelation rin = record { relS = "in" }
linRelation rabove = record { relS = "über" }
linRelation rontopof = record { relS = "auf" }
linRelation rnextto = record { relS = "direkt neben" }

linObject : Object → LinObject
linObject otree = record { objS = "Baum" ; objG = masc }
linObject ohouse = record { objS = "Haus" ; objG = neutr }
linObject osun = record { objS = "Sonne" ; objG = fem }
linObject operson = record { objS = "Person" ; objG = fem }
linObject otable = record { objS = "Tisch" ; objG = masc }
linObject obox = record { objS = "Kiste" ; objG = fem }
linObject oball = record { objS = "Ball" ; objG = masc }

_+++_ : String → String → String
_+++_ s1 s2 = s1 ++ " " ++ s2

infixl 6 _+++_

linScene : Scene → String
linScene (constraintPlace o1 o2 x1 y1 x2 y2 r x x₁) =
  let
    (linobject o1s o1g) = linObject o1
    (linobject o2s o2g) = linObject o2
    (linrelation rs) = linRelation r
    (lindet ds) = linDet
  in ds o1g nom +++ o1s +++ "ist" +++ rs +++ ds o2g acc +++ o2s
