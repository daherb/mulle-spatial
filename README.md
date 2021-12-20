# Mulle Spatial

This is a simple demo creating both pictures and descriptions in parallel using Grammatical Framework.

The pictures are created by combining various objects on a grid.

An in-depth explanation is included in the [Agda Code](https://github.com/daherb/mulle-spatial/blob/master/grammar/SpatialAbs.lagda.md)
## Requirements
[Grammatical Framework](https://github.com/GrammaticalFramework/gf-core/) (Tested with Version 3.10 on Linux) or 
[Agda](https://wiki.portal.chalmers.se/agda/pmwiki.php)

## Building

To compile the grammar just run `bash grammar/build.sh` or run something like `gf -make Spatial*.gf`

## Usage:

Load the grammar file of one of the languages (Eng,Swe,Ger,Lat) for the description and SpatialHTML.gf for the images into GF and create random trees. These can be linearized into the languages an HTML in parallel to create both the pictures and the description.

To generate examples roughly similar to [examples.html](https://daherb.github.io/mulle-spatial/examples.html) you can run the command

```
gr -number=10 -depth=8 | l -treebank | wf -file="example.html"
```

(Requires some additional cleanup)

To convert a tree with constraints into a simple tree that can be edited e.g. using [MULLE](https://github.com/MUSTE-Project/MULLE) you can run

```
gr -depth=8 | l -lang=Eng | p -cat=EditScene -lang=Eng
```

Copyright (c) 2019 Herbert Lange
