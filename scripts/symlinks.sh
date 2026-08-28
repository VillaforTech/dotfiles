#!/usr/bin/env bash

# Compatibility wrapper. The destructive deletion mode was intentionally
# retired; scripts/link-config is the authoritative linker.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

create_symlinks() {
  "$script_dir/link-config" --apply "$@"
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  case "${1:-}" in
    --create)
      shift
      create_symlinks "$@"
      ;;
    --dry-run)
      shift
      "$script_dir/link-config" --dry-run "$@"
      ;;
    --delete)
      printf '%s\n' 'ERROR: deletion is not supported; restore or unlink an exact target manually.' >&2
      exit 2
      ;;
    --help|-h|'')
      "$script_dir/link-config" --help
      ;;
    *)
      printf 'ERROR: unknown option: %s\n' "$1" >&2
      exit 2
      ;;
  esac
fi
