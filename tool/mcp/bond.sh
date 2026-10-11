#!/bin/sh
# Starts the Bond MCP server (`bond mcp`, from bond_cli) for Claude Code.
#
# Install bond_cli once with Dart 3.13 or newer:  dart install bond_cli
# `dart install` puts a compiled `bond` in $DART_DATA_HOME/install/bin; this
# script finds it there even when that folder is not on PATH.
set -eu

cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

for bond in \
  "${DART_DATA_HOME:-/nonexistent}/install/bin/bond" \
  "$HOME/Library/Application Support/Dart/install/bin/bond" \
  "${XDG_DATA_HOME:-$HOME/.local/share}/dart/install/bin/bond"; do
  if [ -x "$bond" ]; then
    exec "$bond" mcp "$@"
  fi
done

# `bond` on PATH, unless it is the `dart pub global activate` launcher: that
# one runs through pub, which can print to stdout and break the MCP stream.
bond=$(command -v bond 2>/dev/null || true)
case "$bond" in
  "" | */.pub-cache/bin/bond | *\\Pub\\Cache\\bin\\bond*) ;;
  *) exec "$bond" mcp "$@" ;;
esac

echo "tool/mcp/bond.sh: bond_cli is not installed; run: dart install bond_cli" >&2
exit 1
