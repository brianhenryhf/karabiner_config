#!/bin/bash
shopt -s nullglob

echo "copying json files..." >&2
json_files=src/*.json
for file in $json_files
do
  cp "$file" "$HOME/.config/karabiner/assets/complex_modifications/"
done

echo "compiling jsonnet files..." >&2
jsonnet_files=src/*.jsonnet
for file in $jsonnet_files
do
  base_stem=$(basename "$file" .jsonnet)
  jsonnet "src/$base_stem.jsonnet" -o "$HOME/.config/karabiner/assets/complex_modifications/$base_stem.json" 
done
