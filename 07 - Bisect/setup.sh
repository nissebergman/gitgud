#!/bin/bash
# Wrapper that calls the setup script in the parent directory
# (kept outside this folder's git history on purpose)
bash "$(dirname "$0")/../setup_bisect.sh"
