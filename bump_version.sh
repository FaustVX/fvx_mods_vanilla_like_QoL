#!/bin/bash
version=$1
message=$2

line=$(head -n "+2" "mod/changelog.txt" | tail -1)
if [[ "$line" != *"$version"* ]]; then
    echo "Invalid version in \`changelog.txt\`"
    exit 1
fi

line=$(head -n "+3" "mod/info.json" | tail -1)
if [[ "$line" != *"$version"* ]]; then
    echo "Invalid version in \`info.json\`"
    exit 1
fi
version="v$version"

if [ $# -eq 1 ]; then
    git commit -am "Bumped version \`$version\`"
elif [ $# -eq 2 ]; then
    git commit -am "Bumped version \`$version\`\n$message"
else
    echo "Exactly 1 or 2 argument must be provided"
    exit false
fi

git push
git tag "$version"
git push --tags
