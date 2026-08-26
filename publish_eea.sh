#!/bin/bash
set -Eeuo pipefail

EXPECTED_BRANCH="main"

PILOT_REMOTE="origin"
PILOT_REPO="MIH-aqteam/AQ_Guide_Pilot"

EEA_REMOTE="eea"
EEA_REPO="eeadata/AQ.Documentation.ReportingGuide"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="$SCRIPT_DIR/docs"

STATIC_PDF="$SCRIPT_DIR/source/_static/AQ_eReporting_Guide.pdf"
DOCS_PDF="$DOCS_DIR/_static/AQ_eReporting_Guide.pdf"

CHECK_DIR="$SCRIPT_DIR/build/eea-check"
CHECK_PDF="$CHECK_DIR/_static/AQ_eReporting_Guide.pdf"

cd "$SCRIPT_DIR"

clear 2>/dev/null || true

fail() {
    echo
    echo "ERROR: $1"
    echo "EEA publication cancelled."
    exit 1
}

confirm() {
    local answer
    read -r -p "$1 [y/N] " answer
    [[ "$answer" == "y" || "$answer" == "Y" ]]
}

check_remote() {
    local remote_name="$1"
    local expected_repo="$2"
    local remote_url

    git remote get-url "$remote_name" >/dev/null 2>&1 || \
        fail "Git remote '$remote_name' does not exist."

    remote_url="$(git remote get-url "$remote_name")"

    echo "Remote $remote_name : $remote_url"

    case "$remote_url" in
        "https://github.com/$expected_repo"|\
        "https://github.com/$expected_repo.git"|\
        "git@github.com:$expected_repo.git")
            ;;
        *)
            fail "Remote '$remote_name' does not point exactly to '$expected_repo'."
            ;;
    esac
}

echo "============================================================"
echo "     AQ eREPORTING GUIDE - EEA PUBLICATION"
echo "============================================================"
echo
echo "This script publishes to EEA only the exact commit that:"
echo "  1. is on local branch main"
echo "  2. has already been pushed to the personal pilot"
echo "  3. has been visually validated on the pilot website"
echo "  4. contains the validated PDF publication files"
echo "  5. passes a fresh strict Sphinx build"
echo
echo "This script does not generate the PDF, stage files or create another commit."
echo "It publishes exactly the commit already validated on the personal pilot."
echo "Nothing has been changed yet."
echo

read -r -p "Press ENTER to begin verification, or Ctrl-C to abort."

echo
echo "------------------------------------------------------------"
echo "1. VERIFYING PROJECT, BRANCH AND REMOTES"
echo "------------------------------------------------------------"
echo

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || \
    fail "This directory is not a Git repository."

[[ -f "$SCRIPT_DIR/source/conf.py" ]] || \
    fail "source/conf.py was not found. Run this script from the project copy."

grep -Fq 'project = "AQ eReporting Guide"' "$SCRIPT_DIR/source/conf.py" || \
    fail "source/conf.py does not identify the AQ eReporting Guide."

/usr/bin/python3 -m sphinx --version >/dev/null 2>&1 || \
    fail "Sphinx is not available through /usr/bin/python3."

CURRENT_BRANCH="$(git branch --show-current)"

echo "Project        : $SCRIPT_DIR"
echo "Current branch : $CURRENT_BRANCH"

[[ "$CURRENT_BRANCH" == "$EXPECTED_BRANCH" ]] || \
    fail "EEA publication must be performed from branch '$EXPECTED_BRANCH', not '$CURRENT_BRANCH'."

check_remote "$PILOT_REMOTE" "$PILOT_REPO"
check_remote "$EEA_REMOTE" "$EEA_REPO"

if git diff --name-only --diff-filter=U | grep -q .; then
    fail "Unresolved Git merge conflicts were detected."
fi

if [[ -n "$(git status --porcelain)" ]]; then
    echo
    echo "Current Git status:"
    git status --short
    fail "The working tree is not clean. Publish and validate the pilot first."
fi

echo
echo "Project, branch and remote verification succeeded."

echo
echo "------------------------------------------------------------"
echo "2. VERIFYING PDF PUBLICATION FILES"
echo "------------------------------------------------------------"
echo

[[ -s "$STATIC_PDF" ]] || \
    fail "source/_static/AQ_eReporting_Guide.pdf is missing or empty."

[[ -s "$DOCS_PDF" ]] || \
    fail "docs/_static/AQ_eReporting_Guide.pdf is missing or empty."

cmp -s "$STATIC_PDF" "$DOCS_PDF" || \
    fail "The PDF copies in source/_static and docs/_static are not identical."

[[ -f "$DOCS_DIR/.nojekyll" ]] || \
    fail "docs/.nojekyll is missing."

git ls-files --error-unmatch "source/_static/AQ_eReporting_Guide.pdf" >/dev/null 2>&1 || \
    fail "source/_static/AQ_eReporting_Guide.pdf is not tracked by Git."

git ls-files --error-unmatch "docs/_static/AQ_eReporting_Guide.pdf" >/dev/null 2>&1 || \
    fail "docs/_static/AQ_eReporting_Guide.pdf is not tracked by Git."

echo "PDF source copy : source/_static/AQ_eReporting_Guide.pdf"
echo "PDF website copy: docs/_static/AQ_eReporting_Guide.pdf"
echo "The two PDF copies are present, tracked and identical."
echo

if ! confirm "Have you visually validated the current PILOT website, including the PDF link?"; then
    echo
    echo "EEA publication cancelled. Validate the pilot website and PDF first."
    exit 0
fi

echo
echo "------------------------------------------------------------"
echo "3. VERIFYING REMOTE COMMITS"
echo "------------------------------------------------------------"
echo

echo "Refreshing pilot and EEA branch information..."

git fetch --quiet "$PILOT_REMOTE" \
    "+refs/heads/$EXPECTED_BRANCH:refs/remotes/$PILOT_REMOTE/$EXPECTED_BRANCH"

git fetch --quiet "$EEA_REMOTE" \
    "+refs/heads/$EXPECTED_BRANCH:refs/remotes/$EEA_REMOTE/$EXPECTED_BRANCH"

HEAD_COMMIT="$(git rev-parse HEAD)"
PILOT_COMMIT="$(git rev-parse "$PILOT_REMOTE/$EXPECTED_BRANCH")"
EEA_COMMIT="$(git rev-parse "$EEA_REMOTE/$EXPECTED_BRANCH")"

echo "Local main : $(git rev-parse --short "$HEAD_COMMIT")"
echo "Pilot main : $(git rev-parse --short "$PILOT_COMMIT")"
echo "EEA main   : $(git rev-parse --short "$EEA_COMMIT")"

[[ "$HEAD_COMMIT" == "$PILOT_COMMIT" ]] || \
    fail "Local main is not identical to pilot main. Run ./publish.sh first."

if [[ "$HEAD_COMMIT" == "$EEA_COMMIT" ]]; then
    echo
    echo "EEA already contains this exact commit. There is nothing to publish."
    exit 0
fi

git merge-base --is-ancestor "$EEA_REMOTE/$EXPECTED_BRANCH" HEAD || \
    fail "EEA main contains different commits. A safe fast-forward is not possible."

echo
echo "Commits that will be added to EEA:"
echo
git --no-pager log --oneline "$EEA_REMOTE/$EXPECTED_BRANCH..HEAD"

echo
echo "Remote commit verification succeeded."

echo
read -r -p "Press ENTER to run the final strict Sphinx check, or Ctrl-C to abort."

echo
echo "------------------------------------------------------------"
echo "4. FINAL STRICT SPHINX AND PDF CHECK"
echo "------------------------------------------------------------"
echo

rm -rf -- "$CHECK_DIR"

echo "Building documentation with the same Sphinx environment used by publish.sh..."

/usr/bin/python3 -m sphinx \
    -W \
    --keep-going \
    -E \
    -a \
    -b html \
    source \
    "$CHECK_DIR"

[[ -s "$CHECK_PDF" ]] || \
    fail "The strict validation build does not contain _static/AQ_eReporting_Guide.pdf."

cmp -s "$STATIC_PDF" "$CHECK_PDF" || \
    fail "The PDF copied by the strict validation build differs from source/_static/AQ_eReporting_Guide.pdf."

echo
echo "Strict Sphinx build completed with no warnings."
echo "The validation build contains the expected PDF."

if [[ -n "$(git status --porcelain)" ]]; then
    echo
    git status --short
    fail "The working tree changed during validation."
fi

echo
echo "------------------------------------------------------------"
echo "5. FINAL EEA PUBLICATION CHECK"
echo "------------------------------------------------------------"
echo

echo "Repository : $EEA_REPO"
echo "Remote     : $EEA_REMOTE"
echo "Branch     : $EXPECTED_BRANCH"
echo "Commit     : $(git log -1 --oneline)"
echo
echo "Command that will run:"
echo "  git push $EEA_REMOTE $EXPECTED_BRANCH:$EXPECTED_BRANCH"
echo

if ! confirm "Publish this validated pilot commit to the EEA repository now?"; then
    echo
    echo "EEA publication stopped before the push. Nothing was changed."
    exit 0
fi

git push "$EEA_REMOTE" "$EXPECTED_BRANCH:$EXPECTED_BRANCH"

echo
echo "============================================================"
echo "EEA PUBLICATION COMPLETED SUCCESSFULLY"
echo "============================================================"
echo
echo "Repository: https://github.com/$EEA_REPO"
echo "Website   : https://eeadata.github.io/AQ.Documentation.ReportingGuide/"
echo
echo "The EEA website now includes:"
echo "  - the HTML AQ eReporting Guide"
echo "  - the PDF version at _static/AQ_eReporting_Guide.pdf"
echo
echo "GitHub Actions will now deploy the updated EEA website."
echo "============================================================"
