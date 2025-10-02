#!/usr/bin/env bash
set -euo pipefail

REMOTO=${REMOTO:-origin}
PREFIJO=${PREFIJO:-brainrot/}

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

PROTEGIDAS=("master" "main" "develop" "release")

echo "==> Borrando ramas brainrot en local y en remoto '$REMOTO'..."

git fetch --prune "$REMOTO" || true

for nombre in "${RAMAS[@]}"; do
  rama="${PREFIJO}${nombre}"

  # evitar borrar ramas críticas
  for p in "${PROTEGIDAS[@]}"; do
    if [[ "$rama" == "$p" ]]; then
      echo "⚠️  Saltando rama protegida: $rama"
      continue 2
    fi
  done

  echo "Borrando rama: $rama"

  # remoto
  git push "$REMOTO" --delete "$rama" 2>/dev/null \
    && echo "  - Remota eliminada" \
    || echo "  - No existe en remoto"

  # local
  if git show-ref --verify --quiet "refs/heads/$rama"; then
    git branch -D "$rama" && echo "  - Local eliminada"
  else
    echo "  - No existe localmente"
  fi
done

git fetch --prune "$REMOTO"

echo "==> Hecho. Revisa con 'git branch' y 'git branch -r'."
