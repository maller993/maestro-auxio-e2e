#!/usr/bin/env bash
# Corre los flows de a uno y en orden: comparten un único emulador.
# Si un flow declara "# fixture: <nombre>", se prepara el emulador antes de correrlo.
set -u
failed=0
for f in .maestro/[0-9]*.yaml; do
  fixture=$(grep -m1 '^# fixture:' "$f" | sed 's/^# fixture: *//' || true)
  if [ -n "$fixture" ]; then
    ./scripts/setup-emulator.sh "$fixture" || { echo "No se pudo preparar '$fixture'"; failed=$((failed+1)); continue; }
  fi
  echo ">> $f"
  maestro test "$f" || failed=$((failed+1))
done
echo "Flows fallidos: $failed"
exit $failed
