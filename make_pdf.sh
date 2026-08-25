#!/bin/bash
set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
DOCS="$ROOT/docs"
OUT="$ROOT/AQ_eReporting_Guide.pdf"
COMBINED="$DOCS/_pdf_reporting_guide.html"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

if [ ! -d "$DOCS" ]; then
  echo "ERROR: docs/ folder not found next to this script."
  exit 1
fi
if [ ! -x "$CHROME" ]; then
  echo "ERROR: Google Chrome not found at the expected location."
  exit 1
fi

# Important: v8 keeps the successful v1/v3 rendering method.
# It does NOT reconstruct the HTML with BeautifulSoup.  It keeps the original
# Sphinx/RTD head and content markup, then makes only small PDF-specific edits.
python3.13 - "$DOCS" "$COMBINED" <<'PY'
from pathlib import Path
from urllib.parse import urlsplit
import posixpath
import re
import sys

docs = Path(sys.argv[1])
out = Path(sys.argv[2])

# Include the real Tables index page as the first page of the tables section.
# Depending on the Sphinx source layout this is normally tables.html; the
# fallback keeps the script robust if a tables/index.html layout is used.
if (docs / "tables.html").exists():
    tables_index = "tables.html"
elif (docs / "tables/index.html").exists():
    tables_index = "tables/index.html"
else:
    raise SystemExit("ERROR: Could not find the built Tables index page (tables.html or tables/index.html).")

pages = [
    ("index.html", "landing", "Landing page"),
    ("introduction.html", "introduction", "Introduction"),
    ("diagram.html", "diagram", "Diagram"),
    (tables_index, "tables-index", "Tables"),
    ("tables/Authority.html", "authority", "Authority"),
    ("tables/MeasurementStation.html", "measurementstation", "MeasurementStation"),
    ("tables/SamplingPoint.html", "samplingpoint", "SamplingPoint"),
    ("tables/SamplingPointLocation.html", "samplingpointlocation", "SamplingPointLocation"),
    ("tables/SamplingProcess.html", "samplingprocess", "SamplingProcess"),
    ("tables/ModelObjectiveEstimation.html", "modelobjectiveestimation", "ModelObjectiveEstimation"),
    ("tables/ObservationMeasurementResult.html", "observationmeasurementresult", "ObservationMeasurementResult"),
    ("tables/MOEResultInline.html", "moeresultinline", "MOEResultInline"),
    ("tables/MOEResultExternal.html", "moeresultexternal", "MOEResultExternal"),
    ("tables/AssessmentRegimeZone.html", "assessmentregimezone", "AssessmentRegimeZone"),
    ("tables/ZoneGeometry.html", "zonegeometry", "ZoneGeometry"),
    ("tables/ComplianceAssessmentMethod.html", "complianceassessmentmethod", "ComplianceAssessmentMethod"),
    ("tables/SpatialRepresentativeness.html", "spatialrepresentativeness", "SpatialRepresentativeness"),
    ("tables/SRSInline.html", "srsinline", "SRSInline"),
    ("tables/SRSExternal.html", "srsexternal", "SRSExternal"),
    ("tables/PollutionLevelAdjustment.html", "pollutionleveladjustment", "PollutionLevelAdjustment"),
    ("tables/CompliancePlanLink.html", "complianceplanlink", "CompliancePlanLink"),
    ("tables/PlanScenario.html", "planscenario", "PlanScenario"),
    ("tables/SourceApportionment.html", "sourceapportionment", "SourceApportionment"),
    ("tables/ScenarioMeasure.html", "scenariomeasure", "ScenarioMeasure"),
    ("tables/Measure.html", "measure", "Measure"),
    ("tables/Documentation.html", "documentation", "Documentation"),
    ("tables/ObservationMeasurementResultPNSD.html", "observationmeasurementresultpnsd", "ObservationMeasurementResultPNSD"),
    ("identifiers.html", "identifiers", "Identifiers"),
    ("relationships/index.html", "relationships", "Table relationships"),
    ("relationships/physical-pk-fk.html", "physical-pk-fk", "Physical PK-FK relationships"),
    ("relationships/physical-summary.html", "physical-summary", "Physical relationships summary"),
    ("relationships/logical-relationships.html", "logical-relationships", "Logical relationships"),
    ("relationships/logical-summary.html", "logical-summary", "Logical relationships summary"),
    ("relationships/documentation-relationships.html", "documentation-relationships", "Documentation relationships"),
    ("relationships/summary.html", "relationships-summary", "Relationships summary"),
]

page_to_anchor = {rel: f"pdf-{anchor}" for rel, anchor, _ in pages}

missing = [rel for rel, _, _ in pages if not (docs / rel).exists()]
if missing:
    raise SystemExit("ERROR: Missing HTML page(s): " + ", ".join(missing))

# Keep the complete <head> from the original landing page.  This is the key
# to preserving exactly the styling that made v1 look so good.
first = (docs / "index.html").read_text(encoding="utf-8")
head = re.search(r"<head\b[^>]*>(.*?)</head>", first, re.I | re.S)
if not head:
    raise SystemExit("ERROR: Could not read the HTML <head> from docs/index.html")


def extract_main(text: str, rel: str) -> str:
    # Same extraction strategy as v1: preserve the site's original markup.
    m = re.search(
        r'<div\s+role="main"\s+class="document"[^>]*>(.*?)\n\s*</div>\s*</div>\s*</div>',
        text,
        re.I | re.S,
    )
    if not m:
        m = re.search(
            r'<div\s+role="main"\s+class="document"[^>]*>(.*?)(?=<footer|<div\s+class="rst-footer-buttons")',
            text,
            re.I | re.S,
        )
    if not m:
        raise SystemExit(f"ERROR: Could not isolate main content in {rel}")
    return m.group(1)


def normalize_target(current_rel: str, href_path: str):
    """Return target path relative to docs/, or None if it escapes docs/."""
    if not href_path:
        return current_rel
    base = posixpath.dirname(current_rel)
    norm = posixpath.normpath(posixpath.join(base, href_path))
    if norm == ".." or norm.startswith("../"):
        return None
    return norm


def rewrite_links(body: str, current_rel: str) -> str:
    """Rewrite links between included HTML pages to PDF-internal anchors.

    External URLs, mailto links, downloads and ordinary same-page fragments are
    left alone.  This intentionally avoids broad HTML rewriting.
    """
    href_re = re.compile(r'(?P<prefix>\bhref\s*=\s*)(?P<q>["\'])(?P<url>.*?)(?P=q)', re.I)

    def repl(m):
        url = m.group("url")
        low = url.lower()
        if low.startswith(("http://", "https://", "mailto:", "tel:", "javascript:", "data:")):
            return m.group(0)
        if url.startswith("#"):
            return m.group(0)

        parts = urlsplit(url)
        target = normalize_target(current_rel, parts.path)
        if target in page_to_anchor:
            # For this prototype, cross-page links go to the beginning of the
            # included source page.  This is reliable and avoids duplicate
            # Sphinx ids such as #attributes across several table pages.
            new_url = "#" + page_to_anchor[target]
            return f'{m.group("prefix")}{m.group("q")}{new_url}{m.group("q")}'
        return m.group(0)

    return href_re.sub(repl, body)


sections = []
for i, (rel, short, label) in enumerate(pages):
    text = (docs / rel).read_text(encoding="utf-8")
    body = extract_main(text, rel)

    # v1's small path correction, required because all content is now hosted in
    # docs/_pdf_test_v8.html rather than in docs/tables/*.html.
    if rel.startswith("tables/"):
        body = body.replace('src="../', 'src="').replace("src='../", "src='")
        body = body.replace('href="../', 'href="').replace("href='../", "href='")

    body = rewrite_links(body, rel)

    # Relationship pages use sphinx-design <details> dropdowns. On screen they
    # are intentionally collapsed, but a PDF must contain the full second-level
    # relationship descriptions. Open them only in this temporary PDF HTML.
    if rel.startswith("relationships/"):
        def open_details(m):
            tag = m.group(0)
            if re.search(r"\bopen(?:\s*=|\s|>)", tag, re.I):
                return tag
            return tag[:-1] + ' open="open">'
        body = re.sub(r"<details\b[^>]*>", open_details, body, flags=re.I)

    # A separate zero-height break marker is intentionally used rather than
    # relying on the section's own page-break property.  Chrome handles this
    # more reliably with the slightly irregular RTD-generated markup.
    if i:
        sections.append('<div class="pdf-hard-break" aria-hidden="true"></div>')
    sections.append(
        f'<a id="{page_to_anchor[rel]}" class="pdf-page-anchor"></a>'
        f'<section class="pdf-source-page" data-source="{rel}" data-label="{label}">{body}</section>'
    )

extra_css = r'''
<style>
  /* PDF-only additions.  Deliberately conservative: preserve the v1/RTD look. */
  body { background: white !important; }
  .pdf-shell { max-width: 1100px; margin: 0 auto; padding: 24px 38px; }
  .pdf-page-anchor { display: block; position: relative; }
  .pdf-hard-break {
    display: block;
    height: 0;
    break-before: page;
    page-break-before: always;
  }

  @media print {
    @page {
      size: A4 portrait;
      margin: 8mm 8mm 12mm 8mm;

      @bottom-center {
        content: counter(page);
        font-size: 8pt;
        color: #666;
      }
    }
    .pdf-shell { max-width: none; margin: 0; padding: 0; }

    /* The RTD theme normally puts wide tables in a horizontally scrolling
       wrapper.  Paper cannot scroll, so let the table use the printable width. */
    .wy-table-responsive {
      overflow: visible !important;
      max-width: 100% !important;
    }
    .wy-table-responsive table,
    table.docutils,
    table {
      width: 100% !important;
      max-width: 100% !important;
      min-width: 0 !important;
    }

    /* v3 was visually good but the final column could still fall beyond the
       printable edge.  Chromium's zoom scales the complete table as a unit,
       preserving the RTD proportions and avoiding ugly mid-word splitting. */
    /* Attribute overview tables: readable rather than microscopic.
       Eight columns fit on A4 by giving them sensible widths and only
       allowing the genuinely long text columns to wrap. */
    table.docutils {
      table-layout: fixed !important;
      width: 100% !important;
      max-width: 100% !important;
      font-size: 7.0pt !important;
      line-height: 1.12 !important;
      box-sizing: border-box !important;
    }
    table.docutils th,
    table.docutils td,
    table.docutils th p,
    table.docutils td p,
    table.docutils th a,
    table.docutils td a {
      font-size: 7.0pt !important;
      line-height: 1.12 !important;
    }
    table.docutils th,
    table.docutils td {
      box-sizing: border-box !important;
      min-width: 0 !important;
      padding: 2px 2.5px !important;
      vertical-align: middle !important;
      text-align: center !important;
      word-break: normal !important;
      hyphens: none !important;
    }
    table.docutils th p,
    table.docutils td p {
      text-align: center !important;
      margin-left: auto !important;
      margin-right: auto !important;
    }

    /* Widths tuned for the 7-column Reporting attribute overview:
       Attribute Code | Attribute Name | Example | SQL type | R3 type | PK | CL. */
    table.docutils th:nth-child(1), table.docutils td:nth-child(1) { width: 10% !important; }
    table.docutils th:nth-child(2), table.docutils td:nth-child(2) { width: 20% !important; }
    table.docutils th:nth-child(3), table.docutils td:nth-child(3) { width: 22% !important; }
    table.docutils th:nth-child(4), table.docutils td:nth-child(4) { width: 14% !important; }
    table.docutils th:nth-child(5), table.docutils td:nth-child(5) { width: 14% !important; }
    table.docutils th:nth-child(6), table.docutils td:nth-child(6) { width: 10% !important; }
    table.docutils th:nth-child(7), table.docutils td:nth-child(7) { width: 10% !important; }

    /* The compact table list below the diagram has ample room on the page,
       so make it more comfortable to read than the dense attribute tables. */
    .pdf-source-page[data-source="diagram.html"] table.docutils,
    .pdf-source-page[data-source="diagram.html"] table.docutils th,
    .pdf-source-page[data-source="diagram.html"] table.docutils td,
    .pdf-source-page[data-source="diagram.html"] table.docutils th p,
    .pdf-source-page[data-source="diagram.html"] table.docutils td p,
    .pdf-source-page[data-source="diagram.html"] table.docutils th a,
    .pdf-source-page[data-source="diagram.html"] table.docutils td a {
      font-size: 9pt !important;
      line-height: 1.25 !important;
    }

    /* Keep genuinely short technical values intact. */
    table.docutils th:nth-child(1), table.docutils td:nth-child(1),
    table.docutils th:nth-child(4), table.docutils td:nth-child(4),
    table.docutils th:nth-child(5), table.docutils td:nth-child(5),
    table.docutils th:nth-child(6), table.docutils td:nth-child(6),
    table.docutils th:nth-child(7), table.docutils td:nth-child(7) {
      white-space: nowrap !important;
      overflow-wrap: normal !important;
    }
    /* Names and especially Example values can be long. Let Chromium wrap them
       inside the cell instead of allowing text to spill into adjacent columns. */
    table.docutils th:nth-child(2), table.docutils td:nth-child(2),
    table.docutils th:nth-child(3), table.docutils td:nth-child(3) {
      white-space: normal !important;
      overflow-wrap: anywhere !important;
      word-break: break-word !important;
    }

    /* Preserve all card backgrounds in print (including Reporting table cards). */
    *, *::before, *::after {
      -webkit-print-color-adjust: exact !important;
      print-color-adjust: exact !important;
    }

    /* Force the Tables index cards to keep their on-screen appearance in PDF.
       We do this explicitly here because Chromium print can otherwise flatten
       link backgrounds/borders even though the normal RTD screen CSS is loaded. */
    .reporting-table-grid {
      display: grid !important;
      grid-template-columns: repeat(6, minmax(0, 1fr)) !important;
      gap: 8px !important;
      margin-top: 16px !important;
      margin-bottom: 20px !important;
    }
    a.reporting-table-card {
      display: flex !important;
      flex-direction: column !important;
      min-width: 0 !important;
      height: 150px !important;
      padding: 7px !important;
      overflow: hidden !important;
      color: #333333 !important;
      background: #ffffff !important;
      border: 1px solid #d4d4d4 !important;
      border-radius: 5px !important;
      text-align: center !important;
      text-decoration: none !important;
      box-shadow: none !important;
    }
    .reporting-table-title {
      min-height: 30px !important;
      margin-bottom: 4px !important;
      font-size: 8pt !important;
      font-weight: 600 !important;
      line-height: 1.12 !important;
    }
    .reporting-table-image {
      display: flex !important;
      flex: 1 !important;
      align-items: center !important;
      justify-content: center !important;
      width: 100% !important;
      min-height: 0 !important;
      overflow: hidden !important;
    }
    .reporting-table-image img {
      display: block !important;
      width: 100% !important;
      height: 95px !important;
      max-width: 100% !important;
      object-fit: contain !important;
      border: 0 !important;
    }

    /* Long URLs/code should wrap rather than disappear beyond the right edge. */
    pre, code {
      max-width: 100% !important;
      overflow-wrap: break-word !important;
    }

    /* Identifier formats are deliberately long single-line patterns. The RTD
       code-block styling uses preformatted whitespace, which otherwise makes
       Chromium clip the right-hand end on A4. Wrap only for the PDF copy. */
    .pdf-source-page[data-source="identifiers.html"] .highlight,
    .pdf-source-page[data-source="identifiers.html"] .highlight-text {
      max-width: 100% !important;
      overflow: visible !important;
    }
    .pdf-source-page[data-source="identifiers.html"] .highlight pre,
    .pdf-source-page[data-source="identifiers.html"] .highlight pre span {
      white-space: pre-wrap !important;
      overflow-wrap: anywhere !important;
      word-break: break-word !important;
      max-width: 100% !important;
    }

    /* Ensure sphinx-design dropdown content is visible when we marked the
       relationship <details> elements open in the temporary PDF HTML. */
    .pdf-source-page[data-source^="relationships/"] details[open] > * {
      visibility: visible !important;
    }

    /* TEST v3: Reporting-specific hard overrides after inspecting the actual
       generated HTML. These intentionally come late so they beat RTD and
       sphinx-design print rules. */

    /* All ordinary PDF tables: centre content and keep text inside its cell. */
    .pdf-source-page table.docutils th,
    .pdf-source-page table.docutils td,
    .pdf-source-page table.docutils th p,
    .pdf-source-page table.docutils td p {
      text-align: center !important;
      vertical-align: middle !important;
    }

    /* The Example tables contain long realistic values. Never let them paint
       over the neighbouring cell: wrapping is preferable in the PDF. */
    .pdf-source-page[data-source^="tables/"] section#example table.docutils {
      table-layout: fixed !important;
      width: 100% !important;
    }
    .pdf-source-page[data-source^="tables/"] section#example table.docutils th,
    .pdf-source-page[data-source^="tables/"] section#example table.docutils td,
    .pdf-source-page[data-source^="tables/"] section#example table.docutils th p,
    .pdf-source-page[data-source^="tables/"] section#example table.docutils td p,
    .pdf-source-page[data-source^="tables/"] section#example table.docutils a {
      white-space: normal !important;
      overflow-wrap: anywhere !important;
      word-break: break-word !important;
      min-width: 0 !important;
    }

    /* Identifier format lines are preformatted by Pygments. Force the actual
       PRE element to wrap on A4 instead of clipping at the printable edge. */
    .pdf-source-page[data-source="identifiers.html"] div.highlight,
    .pdf-source-page[data-source="identifiers.html"] div.highlight-text,
    .pdf-source-page[data-source="identifiers.html"] div.highlight pre {
      width: 100% !important;
      max-width: 100% !important;
      box-sizing: border-box !important;
      overflow: visible !important;
    }
    .pdf-source-page[data-source="identifiers.html"] div.highlight pre,
    .pdf-source-page[data-source="identifiers.html"] div.highlight pre span {
      white-space: pre-wrap !important;
      overflow-wrap: anywhere !important;
      word-break: break-all !important;
    }

    /* sphinx-design hides .sd-summary-content while a dropdown is collapsed.
       The temporary HTML already adds open="open"; this explicit display rule
       guarantees the second-level material is printable even if theme CSS wins. */
    .pdf-source-page[data-source^="relationships/"] details.sd-dropdown > .sd-summary-content,
    .pdf-source-page[data-source^="relationships/"] .sd-dropdown .sd-summary-content {
      display: block !important;
      visibility: visible !important;
      height: auto !important;
      max-height: none !important;
      overflow: visible !important;
    }

    /* TEST v4: the Reporting Attributes overview is NOT the same 7-column
       layout as the Example tables. Its columns are:
       Code | Name | SQL type | ReportNet3 type | Properties | Code list | Related table(s).
       Give the relationship column enough room and explicitly allow its long
       linked table names to wrap inside the cell. */
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils {
      table-layout: fixed !important;
      width: 100% !important;
    }
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(1),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(1) { width: 10% !important; }
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(2),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(2) { width: 18% !important; }
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(3),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(3) { width: 13% !important; }
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(4),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(4) { width: 15% !important; }
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(5),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(5) { width: 11% !important; }
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(6),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(6) { width: 11% !important; }
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(7),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(7) { width: 22% !important; }

    /* Override the earlier generic nowrap rule for the text-bearing columns of
       the Attributes overview. This is the key fix for Related table(s). */
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(2),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(2),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(6),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(6),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils th:nth-child(7),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(7),
    .pdf-source-page[data-source^="tables/"] section#attributes table.docutils td:nth-child(7) a {
      white-space: normal !important;
      overflow-wrap: anywhere !important;
      word-break: break-word !important;
      min-width: 0 !important;
    }

    img, svg {
      max-width: 100% !important;
      height: auto !important;
    }

    h1, h2, h3, h4 {
      break-after: avoid-page;
      page-break-after: avoid;
    }
  }
</style>
'''

html = (
    '<!DOCTYPE html><html><head>'
    + head.group(1)
    + extra_css
    + '</head><body><div class="pdf-shell rst-content">'
    + "\n".join(sections)
    + '</div></body></html>'
)
out.write_text(html, encoding="utf-8")
print("Created temporary combined HTML:", out)
PY

echo
echo "Creating AQ eReporting Guide TEST v4 PDF with Chrome..."
"$CHROME" \
  --headless \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf="$OUT" \
"$COMBINED" \
2>/dev/null
echo
echo "SUCCESS"
echo "PDF created at:"
echo "$OUT"
echo "The guide source files were not modified."