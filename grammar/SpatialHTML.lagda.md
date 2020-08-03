# Creating pictures

```
module SpatialHTML where

open import SpatialAbs
open import Data.String
open import Agda.Builtin.Nat
open import Agda.Builtin.Int
-- open import IO
-- open import Agda.Builtin.Unit
-- open import Data.Unit using () renaming (⊤ to Unit)
open import IO.Primitive
open import Foreign.Haskell
open import Codata.Musical.Costring

linObject : Object → String
linObject otree = "\"../graphics/tree.svg\""
linObject ohouse = "\"../graphics/house.svg\""
linObject osun = "\"../graphics/sun.svg\""
linObject operson = "\"../graphics/person.svg\""
linObject otable = "\"../graphics/table.svg\""
linObject obox = "\"../graphics/box.svg\""
linObject oball = "\"../graphics/ball.svg\""

computeXOffset : Relation → Object → String
computeXOffset rin _ = "20"
computeXOffset _ _ = "0"

computeYOffset : Relation → Object → String
computeYOffset rin _ = "30"
computeYOffset _ _ = "0"

computeScale : Relation → String
computeScale rin = "0.6"
computeScale _ = "1"

numToNat : Num → Nat
numToNat z = zero
numToNat (s n) = suc (numToNat n)

natToString : Nat → String
natToString n = primShowInteger (pos n)

linNat : Num → String
linNat n = natToString (numToNat n)

linScene : Scene → String
linScene (constraintPlace o1 o2 x1 y1 x2 y2 r x x₁) =
  let
    height = natToString ((numToNat maxy) * 100)
    width = natToString ((numToNat maxx) * 100)
    xoffset = computeXOffset r o2
    yoffset = computeYOffset r o2
    scale = computeScale r
  in
  "<html>\n" ++
  "<body>\n" ++
  "<svg height=\"" ++ height ++ "\" width=\"" ++ width ++ "\">" ++
  "<image style=\"x : calc(" ++ linNat x1 ++ "*100px + " ++ xoffset ++ "px); y: calc((2 - " ++ linNat y1 ++ ")*100px + " ++ yoffset ++ "px); height : calc(" ++ scale ++ "* 100px) ; width : calc(" ++ scale ++ "* 100px) ;\" xlink:href="++ linObject o1 ++ " />\n" ++
  "<image style=\"x : calc(" ++ linNat x2 ++ " * 100px); y: calc((2 - " ++ linNat y2 ++ ") * 100px);\" xlink:href="++ linObject o2 ++ " height=\"100\" width=\"100\"/>\n" ++
  "</svg>\n" ++
  "</body>\n" ++
  "</html>\n" 

-- writeHTML : String → IO ⊤
-- writeHTML h = writeFile "../_tmp.htm" h
writeHTML : String → IO Unit
writeHTML h = writeFile "_tmp.htm" (toCostring h)

main : IO Unit
main = writeHTML (linScene example)

example2 : Scene
example2 = constraintPlace operson ohouse n3 z n3 z rin personinhouse (validinpos (s (s (s z))) z (s (s (s z))) z  (equal (s (s (s z))))  (equal z) (equal z)  (inrange (s (s (s z))) z (s (s (s z))) z
                                                                                                                                                                                   (lesss (s (s z)) (s (s (s (s z))))
                                                                                                                                                                                    (lesss (s z) (s (s (s z))) (lesss z (s (s z)) (lessz (s z)))))
                                                                                                                                                                                   (lesss (s (s z)) (s (s (s (s z))))
                                                                                                                                                                                    (lesss (s z) (s (s (s z))) (lesss z (s (s z)) (lessz (s z)))))
                                                                                                                                                                                   (lessz (s (s (s z)))) (lessz (s (s (s z))))))
```

```
<html>
<body>
<svg height="400" width="500"><image style="x : calc(3*100px + 20px); y: calc((2 - 0)*100px + 30px); height : calc(0.6* 100px) ; width : calc(0.6* 100px) ;" xlink:href="../graphics/person.svg" />
<image style="x : calc(3 * 100px); y: calc((2 - 0) * 100px);" xlink:href="../graphics/house.svg" height="100" width="100"/>
</svg>
</body>
</html>
```

<svg height="400" width="500"><image style="x : calc(3*100px + 20px); y: calc((2 - 0)*100px + 30px); height : calc(0.6* 100px) ; width : calc(0.6* 100px) ;" xlink:href="../graphics/person.svg" />
<image style="x : calc(3 * 100px); y: calc((2 - 0) * 100px);" xlink:href="../graphics/house.svg" height="100" width="100"/>
</svg>


