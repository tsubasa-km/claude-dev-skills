#!/usr/bin/env bash
# claude.ai の Skills 画面にアップロードする zip を、スキルごとに dist/ へ作る(python3 だけで動く)。
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf dist && mkdir -p dist
python3 - <<'PY'
import pathlib, zipfile
for skill in sorted(pathlib.Path("plugins").glob("*/skills/*/")):
    out = pathlib.Path("dist") / f"{skill.name}.zip"
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        for f in sorted(skill.rglob("*")):
            if f.is_file() and "__pycache__" not in f.parts and f.suffix != ".pyc":
                z.write(f, pathlib.Path(skill.name) / f.relative_to(skill))
    print(out)
PY
