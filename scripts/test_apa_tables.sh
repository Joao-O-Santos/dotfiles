#!/usr/bin/env bash
# Regression test for the APA table Pandoc filter.

set -u

scripts_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_dir="$(cd -- "$scripts_dir/.." && pwd)"
filter="$config_dir/pandoc/filters/apa-tables.lua"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

if ! command -v pandoc >/dev/null 2>&1 || ! command -v unzip >/dev/null 2>&1; then
    echo "SKIP: APA table test requires both Pandoc and unzip"
    exit 0
fi

fixture="$tmp_dir/table.md"
docx="$tmp_dir/table.docx"
xml="$tmp_dir/document.xml"
cat > "$fixture" <<'EOF'
| **Name** | **Value** | **Description** |
|:---------|----------:|:----------------|
| A        | 12        | This description is longer than twenty characters. |
EOF

if ! pandoc "$fixture" --lua-filter="$filter" -o "$docx"; then
    echo "FAIL: Pandoc could not render the APA table fixture" >&2
    exit 1
fi
if ! unzip -p "$docx" word/document.xml > "$xml"; then
    echo "FAIL: could not extract generated DOCX XML" >&2
    exit 1
fi

python - "$xml" <<'PY'
import sys
import xml.etree.ElementTree as ET

ns = {"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}
root = ET.parse(sys.argv[1]).getroot()
table = root.find(".//w:tbl", ns)
if table is None:
    raise AssertionError("generated DOCX contains no table")
rows = table.findall("w:tr", ns)
if len(rows) != 2:
    raise AssertionError(f"expected one header and one body row, found {len(rows)}")

def paragraph(cell):
    result = cell.find("w:p", ns)
    if result is None:
        raise AssertionError("table cell contains no paragraph")
    return result

def alignment(cell):
    value = paragraph(cell).find("w:pPr/w:jc", ns)
    return value.get("{%(uri)s}val" % {"uri": ns["w"]}) if value is not None else None

header_cells = rows[0].findall("w:tc", ns)
body_cells = rows[1].findall("w:tc", ns)
if [alignment(cell) for cell in header_cells] != ["center"] * 3:
    raise AssertionError("header cells are not all centered")
for cell in header_cells:
    if paragraph(cell).find(".//w:rPr/w:b", ns) is None:
        raise AssertionError("header cell is not bold")
if [alignment(cell) for cell in body_cells] != ["center", "center", "left"]:
    raise AssertionError("body cell alignment does not match short/numeric/long columns")
PY

echo "✓ APA table filter alignment and bold-header regression"
