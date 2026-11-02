#!/usr/bin/env bash
# Run from inside the github-setup folder. Needs: git + GitHub CLI (https://cli.github.com), then `gh auth login`
set -e
USER=Mihir1913

# 1) Portfolio site -> https://mihir1913.github.io/
cd site
git init -b main
git add .
git commit -m "Add portfolio site and CV"
gh repo create $USER/$USER.github.io --public --source=. --remote=origin --push
gh api -X POST repos/$USER/$USER.github.io/pages -f "source[branch]=main" -f "source[path]=/" || true
cd ..

# 2) Profile README -> github.com/Mihir1913
cd profile
git init -b main
git add .
git commit -m "Update profile README from CV"
gh repo create $USER/$USER --public --source=. --remote=origin --push
cd ..

# 3) Profile bio, location, website
gh api -X PATCH user \
  -f name="Mihir Almaula" \
  -f bio="Mobile App Developer (iOS · Flutter) · 5+ yrs · Team Lead @ IQ Infinite Technologies · 4 live apps on App Store & Google Play" \
  -f location="Gujarat, India" \
  -f blog="https://mihir1913.github.io/" \
  -f company="IQ Infinite Technologies"

echo "Done. Site: https://mihir1913.github.io/  Profile: https://github.com/$USER"
