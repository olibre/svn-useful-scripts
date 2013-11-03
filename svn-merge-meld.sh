#!/bin/bash -x
# svn merge-tool wrapper for meld
# original file = https://github.com/olibre/svn-useful-scripts/blob/master/svn-merge-meld.sh

# Copyright 2013 oLibre@Lmap.org

# Fair license - http://en.wikipedia.org/wiki/Fair_License
# Usage of the works is permitted provided that this instrument is retained with the works, so that any entity that uses the works is notified of this instrument. DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

# (french translation)
# License Équitable - http://french.stackexchange.com/questions/7034
# Toute utilisation des œuvres est permise à condition que cette mention légale soit conservée avec les œuvres, afin que tout autre utilisateur des œuvres soit informé de cette mention légale. AVERTISSEMENT : LES ŒUVRES N'ONT PAS DE GARANTIE.

base=${1?1st argument is 'base' file}
theirs=${2?2nd argument is 'theirs' file}
mine=${3?3rd argument is 'mine' file}
merged=${4?4th argument is 'merged' file}
concerned_file=$5 #Fifth argument is not used by meld

version=$(meld --version | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/' )

if [[ "$version" < 1.7 ]]
then
  #old meld version 1.6.* and before = three input files
  cat "$mine" > "$merged"
  meld --label="Base=${base##*/}"           "$base"   \
       --label="Mine->Merged=${merged##*/}" "$merged" \
       --label="Theirs=${theirs##*/}"       "$theirs"
else
  # recent meld versions 1.7.* 1.8.* and above = four input files
  meld --label="Base=${base##*/}"           "$base"   \
       --label="Mine=${mine##*/}"           "$mine"   \
       --label="Merged=${merged##*/}"       "$merged" \
       --label="Theirs=${theirs##*/}"       "$theirs"
fi
