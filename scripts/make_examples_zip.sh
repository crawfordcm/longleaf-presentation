#!/bin/sh
# Rebuild examples.zip from the examples/ folder. Quarto runs this before every
# render (see pre-render in _quarto.yml) and copies the result into docs/, so
# the site always serves a zip that matches the files on the pages.
set -e
cd "$(dirname "$0")/.."
rm -f examples.zip
# -X leaves out per-file metadata (access times, uid/gid) so the zip is
# byte-identical between renders unless an example file actually changes.
zip -q -r -X examples.zip examples \
  -x '*.DS_Store' '*/logs/*.out' '*/logs/*.err' '*/results/*.rds'
echo "examples.zip: $(unzip -l examples.zip | tail -n 1 | awk '{print $2}') entries"
