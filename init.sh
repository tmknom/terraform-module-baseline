#!/bin/bash
#
# Generate baseline

set -e

USAGE="Usage: $0 <target_dir>"
usage() {
  echo "${USAGE}"
}

# Check arguments
TARGET_DIR="${1}"
if [ ! "${TARGET_DIR}" ]; then
  usage
  exit 2
fi

# Copy files
mkdir -p "${TARGET_DIR}"
cp -r . "${TARGET_DIR}"

# Remove unused files
rm -rf "${TARGET_DIR}"/init.sh
rm -rf "${TARGET_DIR}"/.git
rm -rf "${TARGET_DIR}"/.idea
rm -rf "${TARGET_DIR}"/examples/basic/.terraform

# Change to empty
for file in "${TARGET_DIR}"/*.tf; do
  echo >"${file}"
done
for file in "${TARGET_DIR}"/examples/basic/*.tf; do
  echo >"${file}"
done

# Generate README
cat << EOF >"${TARGET_DIR}"/README.md
# $(basename "${TARGET_DIR}")

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
EOF
cd "${TARGET_DIR}"
make docs

# Init git
echo "v0.0.1" >"${TARGET_DIR}"/VERSION
git init
git add .
git commit -m "Initial commit"
git tag v0.0.1
