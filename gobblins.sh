#!/bin/sh
printf '\033c\033]0;%s\a' gobblins
base_path="$(dirname "$(realpath "$0")")"
"$base_path/gobblins.x86_64" "$@"
