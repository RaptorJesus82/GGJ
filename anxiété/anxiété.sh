#!/bin/sh
printf '\033c\033]0;%s\a' anxiété
base_path="$(dirname "$(realpath "$0")")"
"$base_path/anxiété.x86_64" "$@"
