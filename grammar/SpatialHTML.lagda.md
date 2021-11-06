# Creating pictures

This is our final step, we actually want to create pictures from the abstract description, i.e. our
Agda types. There are plenty of ways to do this but the one we decided on is to create websites where
we arrange vector images of our objects in the grid we specified. The advantage is, that it is platform
specific and works in any web browser. We basically just create a bit of HTML by linearizing our scene,
i.e. converting our data types into strings.

While the other two modules are more about handling linguistics, this module involves a bit more of programming.

As usual we start with a new module:
```
module SpatialHTML where
```

But now we are loading a few more built-in modules in addition to the abstract module.
These modules allow us to use additional data types and functions, e.g. to do arithmetics.

```
open import SpatialAbs
open import Data.String
open import Agda.Builtin.Nat
open import Agda.Builtin.Int
```

The linearization function for objects is just a mapping to the file name containing the
image that will be part of the final picture. This is still the easiest part.
All images are vector graphics and have a size of 100x100 pixels. That makes it easy
to place them in the grid of cells of exactly this size.

```
linObject : Object → String
linObject otree = "\"../graphics/tree.svg\""
linObject ohouse = "\"../graphics/house.svg\""
linObject osun = "\"../graphics/sun.svg\""
linObject operson = "\"../graphics/person.svg\""
linObject otable = "\"../graphics/table.svg\""
linObject obox = "\"../graphics/box.svg\""
linObject oball = "\"../graphics/ball.svg\""
```

Before we present the other linearization functions, we need a few helper functions.
The first three are necessary to treat the special case of the "in" relation. If we
want to put an object into another object, we have to scale it down to fit and move
it around a bit to still be centered and not touching the surrounding object. To place
the inside object properly, we need an x and y offset and a scaling factor. This is
exactly what the three functions compute. Currently they ignore the object involved,
but to be more precise we could adjust them to treat inside a house differently from
inside a box.

```
computeXOffset : Relation → Object → String
computeXOffset rin _ = "20"
computeXOffset _ _ = "0"

computeYOffset : Relation → Object → String
computeYOffset rin _ = "30"
computeYOffset _ _ = "0"

computeScale : Relation → String
computeScale rin = "0.6"
computeScale _ = "1"
```

The next function we could have avoided by using the built-in type of natural numbers in the
first place. But now it is too late to regret, instead we convert between our type `Num` and the
Agda type `Nat` by simply matching the constructors. When using the Agda type we can actually
use arithmetics much like in any other programming language. 
```
numToNat : Num → Nat
numToNat z = zero
numToNat (s n) = suc (numToNat n)
```

Another nice thing we can do with the built-in numbers is that we can convert them to strings in a
nice way by going via integers. And combined with `numToNat` we can even convert our own numbers into
nice strings:

```
natToString : Nat → String
natToString n = primShowInteger (pos n)

linNat : Num → String
linNat n = natToString (numToNat n)
```

With all these functions we can finally create our picture. We use the two objects to choose their
images that are placed on the grid and their position to put them in the correct place. The relation
is only used implicitly because it is already encoded into the coordinates, but it influcences
certain aspects such as the size of the inside object. We talked about that before.

```
linScene : Scene → String
linScene (constraintPlace o1 o2 x1 y1 x2 y2 r x x₁) =
  let
```
Okay, befor diving deeper into it, let's compute a few values depending on the function parameters.
We want to be flexible about the size of the grid depending on the variables `maxx` and `maxy`.
And if one of the object is inside another, we need to scale and move it accordingly.

```
    height = natToString ((numToNat maxy) * 100)
    width = natToString ((numToNat maxx) * 100)
    xoffset = computeXOffset r o2
    yoffset = computeYOffset r o2
    scale = computeScale r
  in
```

Finally, all these numbers are put into place in a HTML sceleton of the picture:

```
  "<html>\n" ++
  "<body>\n" ++
  "<svg style="border:black; border-style: solid; background: white" height=\"" ++ height ++ "\" width=\"" ++ width ++ "\">" ++
  "<image style=\"x : calc(" ++ linNat x1 ++ "*100px + " ++ xoffset ++ "px); y: calc((2 - " ++ linNat y1 ++ ")*100px + " ++ yoffset ++ "px); height : calc(" ++ scale ++ "* 100px) ; width : calc(" ++ scale ++ "* 100px) ;\" xlink:href="++ linObject o1 ++ " />\n" ++
  "<image style=\"x : calc(" ++ linNat x2 ++ " * 100px); y: calc((2 - " ++ linNat y2 ++ ") * 100px);\" xlink:href="++ linObject o2 ++ " height=\"100\" width=\"100\"/>\n" ++
  "</svg>\n" ++
  "</body>\n" ++
  "</html>\n" 
```

Based on this linearization function, we can convert our example into HTML:
```
htmlExample : String
htmlExample = linScene example
```

The result is this piece of HTML code:

```HTML
<html>
<body>
<svg style="border:black; border-style: solid; background: white" height="400" width="500"><image style="x : calc(3*100px + 20px); y: calc((2 - 0)*100px + 30px); height : calc(0.6* 100px) ; width : calc(0.6* 100px) ;" xlink:href="../graphics/person.svg" />
<image style="x : calc(3 * 100px); y: calc((2 - 0) * 100px);" xlink:href="../graphics/house.svg" height="100" width="100"/>
</svg>
</body>
</html>
```

It would be great to directly include the results here, but Github strips away the SVG tags.
otherwise the picture would just appear below here:

<svg height="400" width="500"><image style="x : calc(3*100px + 20px); y: calc((2 - 0)*100px + 30px); height : calc(0.6* 100px) ; width : calc(0.6* 100px) ;" xlink:href="../graphics/person.svg" />
<image style="x : calc(3 * 100px); y: calc((2 - 0) * 100px);" xlink:href="../graphics/house.svg" height="100" width="100"/>
</svg>
