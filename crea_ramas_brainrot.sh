#!/usr/bin/env bash
set -euo pipefail

# Configuración
REMOTO=${REMOTO:-origin}           # nombre del remoto
BASE=${BASE:-develop}              # rama base (por defecto develop)
PREFIJO=${PREFIJO:-brainrot/}      # prefijo opcional para distinguir

# Lista de nombres brainrot
RAMAS=(
  tralalero
  tralala
  skibidi
  gyatt
  rizzler
  sigma
  ohio
  fanum-tax
  npc
  goofy-ahh
  bing-chilling
  skibidi-toilet
  mewing
  sigma-grindset
  fanum
  ohio-final-boss
  bababooey
  kai-cenat
  rizzy
  sigma-rizz
  chad
  giga-chad
  goofy
  skibidi-rizz
  gyattlord
  fanum-bing
  npc-rizz
  rizzer
  goofy-sigma
)

echo "==> Creando ramas brainrot desde '$BASE' y empujando al remoto '$REMOTO'..."

git fetch "$REMOTO"
git checkout "$BASE"
git pull "$REMOTO" "$BASE"

for nombre in "${RAMAS[@]}"; do
  rama="${PREFIJO}${nombre}"
  echo "Creando rama: $rama"

  if git show-ref --verify --quiet "refs/heads/$rama"; then
    echo "  - La rama local $rama ya existe, saltando creación."
  else
    git checkout -b "$rama"
    git commit --allow-empty -m "chore: crear rama brainrot $rama"
  fi

  git push -u "$REMOTO" "$rama" || echo "  - No se pudo pushear $rama (¿protegida?)."

  git checkout "$BASE"
done

echo "==> Listo. Se han creado ${#RAMAS[@]} ramas brainrot."
