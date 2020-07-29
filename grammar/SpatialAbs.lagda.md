# Dependent types and spatial relations in pictures

We start our project by defining an "abstract" module. It defines the data types
which we need to describe our pictures. Later we can add modules to translate
these data types into other representations. We call this module "SpatialAbs"

```
module SpatialAbs where

```
## Introduction

Dependent types are great to model constraints. To put it very shortly,
a dependent type is a type that depends on values of another type.
A simple example is the definition of vectors, i.e. lists with associated
length. The type of a vector depends on its length. This solves issues
one can have with lists such as trying to get the head of an empty list
because the `head` function is only defined for vectors of length larger
than 0 and this constraint can be expressed on the type level.

In Agda a vector can be defined this way:

```
open import Agda.Builtin.Nat

data Vector (A : Set) : Nat → Set where
  []  : Vector A zero
  _∷_ : {n : Nat} → A → Vector A n → Vector A (suc n)
```
We use the built-in definition of natural numbers, which is essentially the same as the numbers
we will use later, based on the Peano axioms.

Because we want
to have vectors working for any type, we use a type variable `(A : Set)`
in the definition (`Set` is the type of types in Agda). And the part `Nat → Set`
defines a vector as a dependent type, depending on a number of type `Nat`, the
length of the vector.

The vector is similar to a list with `[]` being the empty vector and using `::` to
concatenate a value to the vector. Both are type constructors for vectors.
The constructor for the empty vector sets the length in the type (!) to 0.
The constructor `::` takes several arguments: An implicit number `n` (in curly brackets),
a value of type `A` and a vector of length `n` containing elements of type `A`. As
a result it again produces a vector containing `A`s but with the type containing
the length plus 1.

Now we can define a safe version of `head` only working on vectors of length greater than
0 (expressed as `suc n`, which is always at least 1 greater than zero):

```
head : {n : Nat} → {A : Set } → Vector A (suc n) → A
head (x ∷ v) = x
```
And already the types guarantee that we cannot try to get the `head` of an empty list.

But dependent types can also be very useful when modelling concepts
closely related to natural language, especially concepts of semantics.
This document explains how dependent
types, both in Grammatical Framework (GF) and Agda can be used to express spatial relationship
between objects in a picture and how the same type-theoretic representation
can be translated into both graphical pictures and natural language
descriptions.

## Getting started

Before we can dive into more complex topics, we have to define a concept
of numbers. An easy way to define natural numbers is using the Peano axioms.
We could use the built-in numbers as we did with the vectors before, but it
cannot hurt to repeat the definition here:
```
data Num : Set where
  z : Num
  s : Num → Num
```
This definition basically says, that zero (`z`) is a natural number (`Num`) and
for each number, the succesor (`s`) is also a number. We need this type later
to place objects and check if a position is valid for a certain spatial relationship.

To place object we use a grid with x and y directions, ranging from 0 to a maximum for
each direction. The grid has the following shape:

```verbatim
-------------------------------
|     |     |     |     |     |
| 0,2 | 1,2 | 2,2 | 3,2 | 4,2 |
|     |     |     |     |     |
|-----+-----+-----+-----+-----|
|     |     |     |     |     |
| 0,1 | 1,1 | 2,1 | 3,1 | 4,1 |
|     |     |     |     |     |
|-----+-----+-----+-----+-----|
|     |     |     |     |     |
| 0,0 | 1,0 | 2,0 | 3,0 | 4,0 |
|     |     |     |     |     |
-------------------------------
```

To avoid some tedious typing, we can define a few number constants for the numbers from
1 to 5 and for the maximum x and y valus. 


```
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
maxy = n4
```

After defining our numbers we can move on to the description of our pictures. We already
mentioned a grid on which objects can be placed. The next step is to define these basic
objects. The type of objects is simply defined by listing all possible values.
All types we have defined so far are simple types. But they will be later used in the definition
of the dependent types describing, e.g. what objects can appear in which position.

```
data Object : Set where
  otree : Object
  ohouse : Object
  osun : Object
  operson : Object
  otable : Object
  obox : Object
  oball : Object
```

Another simple type is the list of all valid relations between objects. This type is again
defined listing all values. We later have to define what exactly it means to be beside, in
or above of another object.

```
data Relation : Set where
  rbeside : Relation
  rleftof : Relation
  rrightof : Relation
  rin : Relation
  rabove : Relation
  rontopof : Relation
  rnextto : Relation
```

But before moving on, we need to add a bit to our numbers. To be able to use our numbers in
a meaningful way, we need to know when two numbers are equal or when one number is smaller
than another. We can define these two relations using dependent types for the first time.

We define two new data types, modeling if two numbers are equal or if a number is smaller than
another one. These are not predicates in the traditional sense, they are data types, but if we
can construct a value of such a type, it counts as a proof that the relation holds.

Equality is defined by reflexivity, i.e. a number is equal to itself, and by symmetry, i.e.
if x=y then also y=x. The second case is probably not necessary but there are some issues with
dependent types in GF which can be circumvented by including this case. Going back to what was
just said. Given any number, we can construct a proof object that it is equal to itself. And
for each two numbers if we know that x=y then we can also prove that y=x, i.e. from the proof
object `IsEqual x y` we can construct a proof for `IsEqual y x`.

```
data IsEqual : Num → Num → Set where
  equal : (n : Num) → IsEqual n n
  sequal : (n n' : Num) → IsEqual n n' → IsEqual n' n
```

The less-than relation is defined the following way:
- zero is less than the successor of every other number (`lessz`)
- If n1<n2 then also the succesor of n1 is smaller than the succesor of n2 (`lesss`)
- by transitivity, if n1<n2 and n2<n2 we also know that n1<n3 (`lesst`)

```
data IsLess : Num → Num → Set where
  lessz : (n : Num) → IsLess z (s n)
  lesss : (n1 n2 : Num) → IsLess n1 n2 → IsLess (s n1) (s n2)
  lesst : (n1 n2 n3 : Num ) → IsLess n1 n2 → IsLess n2 n3 → IsLess n1 n3

```
All these number parameters involved could be turned into implicit arguments, i.e.
they don't have to be given explicitly and don't show up in the proofs (or functions).
But because we want to build the same terms as we would get from GF we include
them es explicit arguments.

These two relations come in handy later, when actually placing objects.
But before placing objects, we can clasify them. Not every object can
take every position. For example it is quite difficult to place something
on top of a ball. Of course we could define for each object separately,
where it can be used. But it is easier to define classes of objects
that can be used in the rules about how objects can be placed.
Some of these classes are only defined for one type of object, so we
could use this object directly. But having these classes, we can add
objects later more easily.

```
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
```

Now that we have defined the objects, spatial relations and classes of objects, we can
define a new dependent type describing what relation is valid between which two objects.

The first four just rely on the classes we defined. For example, if both objects are in
the class `BesideObject` they can be combined in the `Beside` relation.

But then some of the relations are related. If something is next to something else, it is
also beside it. And if something is on top of something else, it is also above. So, if we
can find a way to proof, that something is on top of something else, it is also above it.

Finally, we handle a few special cases, where we don't want to use the general classes but
only handle a few objects separately. It is not nice to put a person into a box, so we did
not define `Person` as an `InsideObject`, but people can be in houses.

```
data ValidRel : Relation → Object → Object → Set where
  validbeside : (o1 o2 : Object) → BesideObject o1 → BesideObject o2 → ValidRel rbeside o1 o2
  validin : (o1 o2 : Object) → InsideObject o1 → OutsideObject o2 → ValidRel rin o1 o2
  validabove : (o1 o2 : Object) → AboveObject o1 → BelowObject o2 → ValidRel rabove o1 o2
  validontop : (o1 o2 : Object) → OnTopObject o1 → BaseObject o2 → ValidRel rontopof o1 o2
  -- Coerce relations
  nexttoisbeside : (o1 o2 : Object) -> ValidRel rbeside o1 o2 -> ValidRel rnextto o1 o2
  leftofisbeside : (o1 o2 : Object) -> ValidRel rbeside o1 o2 -> ValidRel rleftof o1 o2
  rightofisbeside : (o1 o2 : Object) -> ValidRel rbeside o1 o2 -> ValidRel rrightof o1 o2
  ontopofisabove : (o1 o2 : Object) -> ValidRel rontopof o1 o2 -> ValidRel rabove o2 o1
  -- Special cases
  boxinhouse : ValidRel rin obox ohouse
  personinhouse : ValidRel rin operson ohouse
  treeinbox : ValidRel rin otree obox
```

Now we know which objects can be combined with which relation, but we still need to paint
them on our canvas, or at least place them on our grid. We have two objects and each of them
has x and y coordinates. The next type makes sure that the two positions are actually on the
grid, using the variables `maxx` and `maxy` we defined above. That already makes sure that
we don't place anything outside the grid. Here we extensively use our `IsLess` type for
the upper limit and have 0 as the lower limit because that is the smallest number we can express.

```
data InRange : Num -> Num -> Num -> Num -> Set where
  -- Restrictions on positions
  inrange : (x1 y1 x2 y2 : Num) -> IsLess x1 maxx -> IsLess x2 maxx -> IsLess y1 maxy -> IsLess y2 maxy -> InRange x1 y1 x2 y2
```

The next step is to also rule out all placements that don't match the meaning of the relations. So
we have to define what it means, if something is "in" something else, "next to" something and so on.
So far we settled on the following constraints:
- "in" means that the objects are in the same place, i.e. the x and y coordinates of the two objects are equal. Additionally,
  the objects have to be placed on the floor, i.e. on y coordinate 0.
- "left of" means that both objects are on the floor and the x coordinate of the first object is smaller than the one of the second object.
  This is potentially more restrictive than necessary because it could be acceptable that something is left of something else even if it is
  above it.
- "right of" is similar to "left of", except that the x coordinate of the second object is smaller than the one of the first object
- "next to" is split in the two cases, left of or right of. The difference to the two previous cases is, that we want to place the objects
  next to each other, i.e. the x coordinate should be exactly one more or less, depending if it should go to the left or the right
- For "above" we want to have the same x coordinate but the first object has a larger y coordinate than the first. And of course the
  second object is on the floor again.
- Finally, for "on top of", we want to have the same as above, but the y coordinate should be exactly one larger than the other

These constraints are pretty much ad-hoc, but they showcase how spatial relations can be translated into coordinates.
```
data ValidPos : Relation -> Num -> Num -> Num -> Num -> Set where
  validinpos : (x1 y1 x2 y2 : Num) -> IsEqual x1 x2 -> IsEqual y1 y2 -> IsEqual y1 z -> InRange x1 y1 x2 y2 -> ValidPos rin x1 y1 x2 y2
  validleftofpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsLess x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rleftof x1 y1 x2 y2
  validrightofpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsLess x2 x1 -> InRange x1 y1 x2 y2 -> ValidPos rrightof x1 y1 x2 y2
  validnexttoleftpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsEqual x2 (s x1) -> InRange x1 y1 x2 y2 -> ValidPos rnextto x1 y1 x2 y2
  validnexttorightpos : (x1 y1 x2 y2 : Num) -> IsEqual y1 y2 -> IsEqual y1 z -> IsEqual (s x2) x1 -> InRange x1 y1 x2 y2 -> ValidPos rnextto x1 y1 x2 y2
  validabovepos : (x1 y1 x2 y2 : Num) -> IsLess y2 y1 -> IsEqual y2 z -> IsEqual x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rabove x1 y1 x2 y2
  validontopofpos : (x1 y1 x2 y2 : Num) -> IsEqual (s y2) y1 -> IsEqual y2 z -> IsEqual x1 x2 -> InRange x1 y1 x2 y2 -> ValidPos rontopof x1 y1 x2 y2

```

Now we have all the parts and we can define how we can build a picture or a `Scene` from it.
We define a scene as a new simple type, but to construct it we need quite a bit of stuff:
As a start the two objects, their coordinates and the spatial relation. But then
we also have to make sure that the objects can be placed using this relation (`ValidRel`)
and the positions work for the relation (`ValidPos`). Only if we can give a proof for
these properties, we can create a complete picture.

```
data Scene : Set where
  constraintPlace : (o1 o2 : Object) -> (x1 y1 x2 y2 : Num) -> (r : Relation) -> ValidRel r o1 o2 -> ValidPos r x1 y1 x2 y2 -> Scene

```

Finally, we can give an example. It is a box in a house and both objects are at the coordinate (0,0). Translated into
a natural language description we would get the sentence "the box is in the house".

```
example : Scene
example = constraintPlace obox ohouse z z z z rin boxinhouse (validinpos z z z z (sequal z z (equal z)) (sequal z z (equal z)) (equal z) (inrange z z z z (lessz (s (s (s (s z))))) (lessz (s (s (s (s z))))) (lessz (s (s (s z)))) (lessz (s (s (s z))))))
```

The same dependent types are defined in GF as an abstract syntac in the file `Spatial.gf` and can be translated into either pictures using
the concrete syntax in [SpatialHTML.gf](SpatialHTML.gf) or natural language description in English in [SpatialEng.gf](SpatialEng.gf).

As an additional experiment, we can also use Agda to translate the data types we defined here into English. It is described in the file [SpatialEng.lagda.md](SpatialEng.lagda.md).
