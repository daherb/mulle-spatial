# The English module for the Spatial dependent types

In a simular way to [SpatialEng.lagda.md](SpatialEng.lagda.md), we can define
a translation from "abstract" data types to natural language description.
But for German it is actually a bit more interesting.

For English we just had to map objects and relations onto strings and glue
them together. For German we actually have to implement inflection for determiners.

Before we dive into that, we start by defining our new module and load the
common "abstract" syntax and the built-in strings.

```
module SpatialGer where

open import SpatialAbs
open import Data.String
```

Our first step is to define our grammatical features we need for inflection
in the simple fragment of German, we need to describe our scenes: gender and
case. We need all three genders (feminine, masculine and neuter), but only
nominative and accusative case.

```
data Gender : Set where
  fem : Gender
  masc : Gender
  neutr : Gender

data Case : Set where
  nom : Case
  acc : Case
```

When translating to English we could just map from the relevant data types
to strings. Now we use, in the GF tradition, linearization types. For the types `Relation` and `Object` we define
new types `LinRelation` and `LinObject`. For `Scene` we don't define a new type because
we just use strings, exactly as with English. But in addition, we need to represent determiners, so we also add `LinDet`.

For the linearization types we use records with one field containing the string representation.
Names of record fields have to be unique in Agda, so we use `relS` for relations and `objS` for objects.
For relations we only need the string, for objects we also have to know the gender. We add another record field
`objG` storing the gender. For each of the records we also define a constructor, which we can use later with
pattern matching to get the separate record fields.

```
record LinRelation : Set where
  constructor linrelation
  field
    relS : String

record LinObject : Set where
  constructor linobject
  field
    objS : String
    objG : Gender
```

Determiners are different, insofar that their form is inflected by gender and case. So we define
the field `detS` as a function from gender to case to string.

```
record LinDet : Set where
  constructor lindet
  field
    detS : Gender → Case → String
```

The only determiner we use is the definite article which we now define. By using
anonymous functions and pattern matching, we can get nice inflection tables:

```
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
```

To be honest, we could have defined the linearization of relations
just as plain strings. But using records gives us a more uniform way
to handle the translation. And it is much more similar to GF when
everything is basically records, even when only storing a single string.

But here is our linearization function for relations, building a record and
packing the concrete string into the `relS` field:
```
linRelation : Relation → LinRelation
linRelation rbeside = record { relS = "neben" }
linRelation rleftof = record { relS = "links von" }
linRelation rrightof = record { relS = "rechts von" }
linRelation rin = record { relS = "in" }
linRelation rabove = record { relS = "über" }
linRelation rontopof = record { relS = "auf" }
linRelation rnextto = record { relS = "direkt neben" }
```

The treatment of objects is pretty similar but we also have the second field
for the gender:

```
linObject : Object → LinObject
linObject otree = record { objS = "Baum" ; objG = masc }
linObject ohouse = record { objS = "Haus" ; objG = neutr }
linObject osun = record { objS = "Sonne" ; objG = fem }
linObject operson = record { objS = "Person" ; objG = fem }
linObject otable = record { objS = "Tisch" ; objG = masc }
linObject obox = record { objS = "Kiste" ; objG = fem }
linObject oball = record { objS = "Ball" ; objG = masc }
```

And we are already close to the final step of translating a scene
into a German sentence. But because we are a bit lazy and/or spoiled
by GF, we define a new concatenation operator that puts a space between
the two strings.

```
_+++_ : String → String → String
_+++_ s1 s2 = s1 ++ " " ++ s2

infixl 6 _+++_
```

Now we are at the final step, we get the scene as a parameter
and we can pattern match on the constructor `constraintPlace`
to get the objects and relation. But now it gets a bit tricky.
We can call the linearization function `linObject` and `linRelation` on
the objects and relation to get objects of the linearization types,
the records we defined before. To get the record fields out, we
use pattern matching on the constructors we defined together with
the records. This gives  us the strings (`o1s` and `o2s`) and genders
(`o1g` and `o2g`) of the objects, the string for the relation `rs` and
the "inflection table" for the determiner (`ds`). Finally, we can concatenate
these parts using our own concatenation operator `+++`. But to get the correct
string for the determiners we apply `ds` as a function to the gender of the object
as well as nominative for the subject and accusative case for the object of the sentence.

```
linScene : Scene → String
linScene (constraintPlace o1 o2 x1 y1 x2 y2 r x x₁) =
  let
    (linobject o1s o1g) = linObject o1
    (linobject o2s o2g) = linObject o2
    (linrelation rs) = linRelation r
    (lindet ds) = linDet
  in ds o1g nom +++ o1s +++ "ist" +++ rs +++ ds o2g acc +++ o2s
```

And here is the translation of our example. You can use C-c C-n germanExample
in Emacs to see the result.

```
-- "die Kiste ist in dem Haus"
germanExample : String
germanExample = linScene example
