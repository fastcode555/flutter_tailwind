#!/usr/bin/env bash
# Verify that doc/AI_REFERENCE.md still matches the real API.
#
# It analyzes the doc-coverage fixtures under example/lib/. Those files use ONLY
# tokens/terminators that doc/AI_REFERENCE.md promises, each traceable to a doc
# section. If a documented token is renamed/removed in lib/, `flutter analyze`
# fails here — the automated form of the "blind test" that caught the
# .maxLine(n) / dataBuilder-arg-order / topLeft-nullable doc bugs.
#
# Run after changing presets in lib/ OR editing doc/AI_REFERENCE.md.
# Usage:  tool/verify_ai_reference.sh
#
# Exit codes: 0 = docs match the API; non-zero = drift (read the analyzer output).

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT/example"

FIXTURES=(
  "lib/ai_reference_smoke_test.dart"  # broad coverage: every terminator + axis
  "lib/ai_blind_test.dart"            # realistic screen written from the doc alone
)

echo "==> Verifying doc/AI_REFERENCE.md against the real API"
echo "    (analyzing ${#FIXTURES[@]} doc-coverage fixture(s) in example/)"

# Ensure deps are resolved so analysis is meaningful.
if [ ! -d ".dart_tool" ]; then
  echo "==> example/ deps not resolved; running 'flutter pub get'"
  flutter pub get >/dev/null
fi

if flutter analyze "${FIXTURES[@]}"; then
  echo ""
  echo "✅ PASS — every token/terminator documented in doc/AI_REFERENCE.md compiles."
else
  echo ""
  echo "❌ FAIL — a documented token/terminator no longer matches the code."
  echo "   Fix EITHER the fixture (if the API legitimately changed) AND update"
  echo "   doc/AI_REFERENCE.md to match, OR the doc (if it was wrong)."
  exit 1
fi
