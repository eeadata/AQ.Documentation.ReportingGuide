#!/bin/bash

set -Eeuo pipefail

EXPECTED_BRANCH="main"
EXPECTED_REMOTE="origin"
EXPECTED_REPO="MIH-aqteam/AQ_Guide_Pilot"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="$SCRIPT_DIR/docs"
PDF_SCRIPT="$SCRIPT_DIR/make_pdf.sh"
PDF_FILE="$SCRIPT_DIR/AQ_eReporting_Guide.pdf"
STATIC_PDF="$SCRIPT_DIR/source/_static/AQ_eReporting_Guide.pdf"
DOCS_PDF="$DOCS_DIR/_static/AQ_eReporting_Guide.pdf"
COMBINED_HTML="$DOCS_DIR/_pdf_reporting_guide.html"

cd "$SCRIPT_DIR"

clear 2>/dev/null || true

fail() {
    echo
    echo "ERROR: $1"
    echo "Publication cancelled."
    exit 1
}

confirm() {
    local answer
    read -r -p "$1 [y/N] " answer
    [[ "$answer" == "y" || "$answer" == "Y" ]]
}

echo "============================================================"
echo "     AQ eREPORTING GUIDE - PILOT PUBLICATION"
echo "============================================================"
echo
echo "Destination:"
echo "  Personal GitHub repository"
echo "  $EXPECTED_REPO"
echo
echo "This script will:"
echo "  1. Verify the project, branch and remote"
echo "  2. Show the current Git status"
echo "  3. Build the Sphinx documentation with warnings as errors"
echo "  4. Generate the complete PDF version"
echo "  5. Add the fresh PDF to the published website"
echo "  6. Show and stage all resulting changes"
echo "  7. Create one Git commit"
echo "  8. Push main to the personal pilot repository"
echo
echo "No commit or push occurs without a separate confirmation."
echo "Nothing has been changed yet."
echo

read -r -p "Press ENTER to begin verification, or Ctrl-C to abort."

echo
echo "------------------------------------------------------------"
echo "1. VERIFYING PROJECT AND DESTINATION"
echo "------------------------------------------------------------"
echo

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || \
    fail "This directory is not a Git repository."

[[ -f "$SCRIPT_DIR/source/conf.py" ]] || \
    fail "source/conf.py was not found. Run this script from the project copy."

grep -Fq 'project = "AQ eReporting Guide"' "$SCRIPT_DIR/source/conf.py" || \
    fail "source/conf.py does not identify the AQ eReporting Guide."

[[ -f "$PDF_SCRIPT" ]] || \
    fail "make_pdf.sh was not found next to publish.sh."

[[ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]] || \
    fail "Google Chrome was not found at the expected location."

/usr/bin/python3 -m sphinx --version >/dev/null 2>&1 || \
    fail "Sphinx is not available through /usr/bin/python3."

CURRENT_BRANCH="$(git branch --show-current)"

echo "Project        : $SCRIPT_DIR"
echo "Current branch : $CURRENT_BRANCH"

[[ "$CURRENT_BRANCH" == "$EXPECTED_BRANCH" ]] || \
    fail "Publication must be performed from branch '$EXPECTED_BRANCH', not '$CURRENT_BRANCH'."

git remote get-url "$EXPECTED_REMOTE" >/dev/null 2>&1 || \
    fail "Git remote '$EXPECTED_REMOTE' does not exist."

REMOTE_URL="$(git remote get-url "$EXPECTED_REMOTE")"

echo "Remote         : $EXPECTED_REMOTE"
echo "Remote URL     : $REMOTE_URL"

case "$REMOTE_URL" in
    "https://github.com/$EXPECTED_REPO"|\
    "https://github.com/$EXPECTED_REPO.git"|\
    "git@github.com:$EXPECTED_REPO.git")
        ;;
    *)
        fail "Remote '$EXPECTED_REMOTE' does not point exactly to '$EXPECTED_REPO'."
        ;;
esac

if git diff --name-only --diff-filter=U | grep -q .; then
    fail "Unresolved Git merge conflicts were detected."
fi

echo
echo "Current Git status:"
echo
git status --short

if [[ -z "$(git status --porcelain)" ]]; then
    echo "  Working tree is currently clean."
fi

echo
echo "Repository verification succeeded."
echo

read -r -p "Press ENTER to continue to the strict Sphinx build and PDF generation, or Ctrl-C to abort."

echo
echo "------------------------------------------------------------"
echo "2. BUILDING DOCUMENTATION"
echo "------------------------------------------------------------"
echo

echo "Removing the previous docs/ publication build..."
rm -rf -- "$DOCS_DIR"

echo "Building documentation with the known Sphinx environment..."
/usr/bin/python3 -m sphinx \
    -W \
    --keep-going \
    -E \
    -a \
    -b html \
    source \
    docs

touch "$DOCS_DIR/.nojekyll"

echo
echo "HTML build completed successfully."
echo "No Sphinx warnings were detected."

echo
echo "------------------------------------------------------------"
echo "3. GENERATING PDF VERSION"
echo "------------------------------------------------------------"
echo

echo "Generating AQ_eReporting_Guide.pdf with the validated Chromium method..."
bash "$PDF_SCRIPT"

[[ -s "$PDF_FILE" ]] || \
    fail "The PDF was not generated or is empty."

mkdir -p "$SCRIPT_DIR/source/_static" "$DOCS_DIR/_static"

echo "Installing the fresh PDF in source/_static/..."
cp -f "$PDF_FILE" "$STATIC_PDF"

echo "Installing the fresh PDF in docs/_static/..."
cp -f "$PDF_FILE" "$DOCS_PDF"

# The combined HTML is only an intermediate file used by make_pdf.sh.
rm -f -- "$COMBINED_HTML"

# Avoid committing a duplicate copy at the project root.
rm -f -- "$PDF_FILE"

[[ -s "$STATIC_PDF" ]] || \
    fail "The source/_static PDF copy is missing or empty."

[[ -s "$DOCS_PDF" ]] || \
    fail "The docs/_static PDF copy is missing or empty."

echo
echo "PDF generation completed successfully."
echo "Published PDF:"
echo "  docs/_static/AQ_eReporting_Guide.pdf"

echo
echo "------------------------------------------------------------"
echo "4. REVIEWING AND STAGING CHANGES"
echo "------------------------------------------------------------"
echo

git status --short

if [[ -z "$(git status --porcelain)" ]]; then
    echo
    echo "No changes were detected. There is nothing to publish."
    exit 0
fi

echo
echo "Review the complete list above carefully."
echo "All listed changes, including deletions and new files, will be staged."
echo

if ! confirm "Stage all these changes?"; then
    echo
    echo "Publication cancelled before staging."
    exit 0
fi

git add -A

echo
echo "Files staged for the commit:"
echo
git status --short

echo
git --no-pager diff --cached --stat

if git diff --cached --quiet; then
    echo
    echo "Nothing is staged. There is nothing to publish."
    exit 0
fi

echo
echo "------------------------------------------------------------"
echo "5. CREATING THE COMMIT"
echo "------------------------------------------------------------"
echo

read -r -p "Commit message: " COMMITMSG

[[ -n "${COMMITMSG//[[:space:]]/}" ]] || \
    fail "No commit message was entered. Files remain staged."

echo
echo "Commit message:"
echo "  $COMMITMSG"
echo

if ! confirm "Create this commit?"; then
    echo
    echo "Commit cancelled. Files remain staged but nothing was committed or pushed."
    exit 0
fi

git commit -m "$COMMITMSG"

echo
echo "Commit created successfully:"
git --no-pager log -1 --oneline

if [[ -n "$(git status --porcelain)" ]]; then
    echo
    git status --short
    fail "The working tree changed during the commit. Review it before pushing."
fi

echo
echo "------------------------------------------------------------"
echo "6. FINAL PILOT PUBLICATION CHECK"
echo "------------------------------------------------------------"
echo

echo "Repository : $EXPECTED_REPO"
echo "Remote     : $EXPECTED_REMOTE"
echo "Branch     : $EXPECTED_BRANCH"
echo "Commit     : $(git log -1 --oneline)"
echo
echo "Command that will run:"
echo "  git push $EXPECTED_REMOTE $EXPECTED_BRANCH"
echo

if ! confirm "Publish this commit to the PERSONAL PILOT repository now?"; then
    echo
    echo "Publication stopped before the push."
    echo "The commit exists locally but has not been published."
    exit 0
fi

git push "$EXPECTED_REMOTE" "$EXPECTED_BRANCH"

echo
echo "============================================================"
echo "PILOT PUBLICATION COMPLETED SUCCESSFULLY"
echo "============================================================"
echo
echo "Repository: https://github.com/$EXPECTED_REPO"
echo "Website   : https://mih-aqteam.github.io/AQ_Guide_Pilot/"
echo
echo "The website now includes:"
echo "  - the HTML AQ eReporting Guide"
echo "  - the PDF version at _static/AQ_eReporting_Guide.pdf"
echo
echo "GitHub Pages must be set to:"
echo "  Branch: main"
echo "  Folder: /docs"
echo
echo "============================================================"