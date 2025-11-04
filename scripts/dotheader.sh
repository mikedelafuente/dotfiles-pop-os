#!/usr/bin/env bash
set -euo pipefail

echo "Sourcing dotheader.sh..."
echo "Current user: $(whoami)"
echo "Real user: ${SUDO_USER:-$(whoami)}" 

# Set a USER_HOME_DIR variable and export it for use in other scripts
export USER_HOME_DIR="$(eval echo ~${SUDO_USER:-$(whoami)})"
echo "USER_HOME_DIR is set to: $USER_HOME_DIR"

# use parameter expansion to avoid "unbound variable" with set -u
if [ -z "${DF_SCRIPT_DIR:-}" ]; then
    DF_SCRIPT_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
    echo "DF_SCRIPT_DIR is $DF_SCRIPT_DIR"
else
    echo "DF_SCRIPT_DIR is already set to $DF_SCRIPT_DIR"
fi

# Source common library functions
if [ -r "$DF_SCRIPT_DIR/fn-lib.sh" ]; then
  # shellcheck source=/dev/null
  source "$DF_SCRIPT_DIR/fn-lib.sh"
else
  echo "Missing required library: $DF_SCRIPT_DIR/fn-lib.sh"
  exit 1
fi