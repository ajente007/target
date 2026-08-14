#!/bin/bash
     F="$HOME/.config/bin/target"
     mkdir -p "$(dirname "$F")"
     [ -f "$F" ] || : > "$F"
     if [ $# -eq 0 ]; then
       echo "Uso: target <IP> <HOST> | target clear"
       exit 0
     fi
     case "$1" in
       clear|cls)
         : > "$F"
         echo "\nlimpio"
         ;;
       add)
         [ $# -ge 3 ] || { echo "Uso: target add <IP> <HOST>"; exit 1; }
         h=$(echo "$3" | tr '[:upper:]' '[:lower:]')
         out=$(awk -v hh="$h" '$2!=hh' "$F"; echo "$2 $h")
         printf '%s\n' "$out" > "$F"
         echo "Aniadido: $2 $h"
         ;;
       *)
         [ $# -ge 2 ] || { echo "Uso: target <IP> <HOST>"; exit 1; }
         h=$(echo "$2" | tr '[:upper:]' '[:lower:]')
         printf '%s %s\n' "$1" "$h" > "$F"
         echo "Target: $1 $h"
         ;;
     esac
