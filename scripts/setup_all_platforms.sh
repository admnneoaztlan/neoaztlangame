#!/usr/bin/env bash
set -euo pipefail

echo "Generating all Flutter platforms in current directory..."
flutter create . --platforms=android,ios,windows,macos,linux,web

echo "Done. Remember to remove the platform folders from .gitignore if you want to commit them."