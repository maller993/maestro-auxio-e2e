#!/usr/bin/env bash
# Deja en el emulador únicamente el fixture indicado y pide a Android que lo indexe.
# Limitación: asume nombres de archivo sin espacios.
set -euo pipefail
name="${1:?Uso: ./scripts/setup-emulator.sh <no-metadata|full-metadata>}"
src="fixtures/${name}.mp3"
dest="/sdcard/Music"

[ -f "$src" ] || { echo "No existe $src"; exit 1; }
adb get-state >/dev/null || { echo "No hay un emulador encendido"; exit 1; }

scan() {
  adb shell am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d "file://$1" >/dev/null
}

# Borrar la música anterior y avisar a Android para que la saque de su índice
for old in $(adb shell ls "$dest" 2>/dev/null | tr -d '\r' || true); do
  adb shell rm -f "$dest/$old"
  scan "$dest/$old"
done

adb push "$src" "$dest/${name}.mp3" >/dev/null
scan "$dest/${name}.mp3"
echo "Fixture '$name' listo en el emulador"
