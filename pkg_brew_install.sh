#!/bin/bash

# Install dependencies for Zineify
# Requires Homebrew: https://brew.sh

set -e

echo "Installing Zineify dependencies..."

brew install ghostscript psutils pdftk-java

echo "Done."