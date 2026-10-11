#!/bin/sh
# Runs the Dart SDK of the Flutter version pinned in .fvmrc.
#
# Used by .mcp.json so Claude Code's MCP servers ("dart mcp-server", "bond mcp") never pick up
# another Dart from PATH. Prefers the raw Dart binary of the Flutter SDK: Flutter's bin/dart
# wrapper can print setup messages to stdout, which would corrupt the MCP stdio stream.
set -eu
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

version=$(sed -n 's/.*"flutter"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' .fvmrc 2>/dev/null)
if [ -z "$version" ]; then
  echo "tool/mcp/dart.sh: no Flutter version found in .fvmrc" >&2
  exit 1
fi

for root in ".fvm/versions/$version" ".fvm/flutter_sdk" "${FVM_CACHE_PATH:-$HOME/fvm}/versions/$version"; do
  for dart in "$root/bin/cache/dart-sdk/bin/dart" "$root/bin/dart"; do
    if [ -x "$dart" ]; then
      FLUTTER_ROOT=$(cd "$root" && pwd)
      export FLUTTER_ROOT
      exec "$dart" "$@"
    fi
  done
done

# Fallback: the flutter on PATH, but only if it is exactly the pinned version.
flutter_bin=$(command -v flutter 2>/dev/null || true)
if [ -n "$flutter_bin" ]; then
  root=$(dirname "$(dirname "$(readlink -f "$flutter_bin")")")
  if grep -q "\"frameworkVersion\": *\"$version\"" "$root/bin/cache/flutter.version.json" 2>/dev/null ||
    [ "$(cat "$root/version" 2>/dev/null)" = "$version" ]; then
    FLUTTER_ROOT=$root
    export FLUTTER_ROOT
    exec "$root/bin/cache/dart-sdk/bin/dart" "$@"
  fi
fi

echo "tool/mcp/dart.sh: Flutter $version (pinned in .fvmrc) is not installed" >&2
exit 1
