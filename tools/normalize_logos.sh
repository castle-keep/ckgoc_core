#!/usr/bin/env bash
# Normalize logo filenames under assets/images/logos to kebab-case
# Usage: ./tools/normalize_logos.sh

set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

find assets/images/logos -type f | while IFS= read -r f; do
  dir=$(dirname "$f")
  base=$(basename "$f")
  ext="${base##*.}"
  name="${base%.*}"
  # normalize: lowercase, replace non-alphanumeric with hyphen, collapse hyphens
  newname=$(echo "$name" | iconv -f utf8 -t ascii//TRANSLIT 2>/dev/null || echo "$name")
  newname=$(echo "$newname" | tr '[:upper:]' '[:lower:]')
  newname=$(echo "$newname" | sed -E 's/[^a-z0-9]+/-/g')
  newname=$(echo "$newname" | sed -E 's/^-+|-+$//g')
  newname=$(echo "$newname" | sed -E 's/-+/-/g')
  newpath="$dir/$newname.$ext"
  if [ "$f" != "$newpath" ]; then
    echo "Renaming: $f -> $newpath"
    mkdir -p "$(dirname "$newpath")"
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git mv -f -- "$f" "$newpath" || mv -f -- "$f" "$newpath"
    else
      mv -f -- "$f" "$newpath"
    fi
  fi
done

# Normalize directory names to lowercase
find assets/images/logos -depth -type d | while IFS= read -r d; do
  parent=$(dirname "$d")
  base=$(basename "$d")
  newbase=$(echo "$base" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')
  if [ "$base" != "$newbase" ]; then
    newdir="$parent/$newbase"
    echo "Renaming dir: $d -> $newdir"
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git mv -f -- "$d" "$newdir" || mv -f -- "$d" "$newdir"
    else
      mv -f -- "$d" "$newdir"
    fi
  fi
done

echo "Logo normalization complete. Review changes and run 'flutter pub get' if necessary."