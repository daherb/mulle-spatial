# The English module for the Spatial dependent types

Based on [SpatialAbs.ladga.md](SpatialAbs.ladga.md) we can define
a translation from the abstract types into English descriptions
of the scenes. This translation is roughly equivalent to using
GF to linearize an abstract syntax tree using a concrete grammar.
A linearization, sometimes also called a pretty-printer or un-parser
is a translation from an abstract representation, usually an abstract
syntax tree, back into a string representation. Here we try to define
a translation from the types we defined in our abstract module into
strings. For English this is directly possible. For other languages, 
intermediate steps are possible.

We again start by defining a new module. In addition we load the
"abstract" module and the built-in strings.
```
module SpatialEng where

open import SpatialAbs
open import Data.String
```

Out of all the data types we defined in the "abstract" module,
we only need three to form the picture description in English.
The others are only used to make sure that the object placement
makes sense and are used to generate pictures of a scene.

So here we only care about scenes, relations and objects.

We can easily define the string representations for relations
and objects.

```
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
```

Finally, we can translate a scene. There is one constructor to build a scene defined in the
"abstract" module and we can pattern match on it to get all its parameters. We only care about
the two objects and the relation. We feed them into the "linearization" functions and use the
resulting strings to build our description.

```
linScene : Scene → String
linScene (constraintPlace o1 o2 x1 y1 x2 y2 r x x₁) = "the " ++ (linObject o1) ++ " is " ++ (linRelation r) ++ " the " ++ (linObject o2)
```
And here is the translation of our example. You can use C-c C-n englishExample
in Emacs to see the result.

```
-- "the person is in the house"
englishExample : String
englishExample = linScene example
```

All this was pretty straight forward for English. If you want to see something a little more fun
we can try the same for German in [SpatialGer.lagda.md](SpatialGer.lagda.md).
