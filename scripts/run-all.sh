#!/usr/bin/env bash
# Corre los flows de a uno y en orden: comparten un único emulador,
# así que no deben ejecutarse en simultáneo.
set -u
failed=0
for f in .maestro/[0-9]*.yaml; do
  echo ">> $f"
  maestro test "$f" || failed=$((failed+1))
done
echo "Flows fallidos: $failed"
exit $failed
