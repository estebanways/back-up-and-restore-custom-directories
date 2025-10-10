#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Script Name: Restore Custom Directories
# Author:      Esteban Herrera Castro
# Email:       stv.herrera@gmail.com
# Date:        10/10/2025
# ------------------------------------------------------------------------------
# Description:
# This script restores the directories from the archive.
#
# Steps
# 1. Copy the files _dir.tgz to the root directory "/".
# 2. Go to the root of the file system.
# 3. Extract the archives.
# ------------------------------------------------------------------------------

# Go to the root of the file system
cd / || exit

# Option 1
# To untar all .tgz archives in a directory. It extracts each archive one by one.
# Use a loop
#for f in *_dir.tgz; do
#  tar -xvzf "$f"
#done

# Option 2
# Add -C /destination/path if you want to extract them into a specific directory:
#for f in *_dir.tgz; do
#  tar -xvzf "$f" -C /backup/restore/
#done

# Option 3
# Use an array of excluded filenames (clean and scalable). This approach is
# recommended if you’ll add or remove excluded files often — it keeps your code
# clean and easy to maintain.
exclude_list=(
  "etc_dir.tgz"
  "/path/to/exclude2.tgz"
  "/path/to/exclude3.tgz"
)

for f in *_dir.tgz; do
  skip=false
  for ex in "${exclude_list[@]}"; do
    [[ "$f" == "$ex" ]] && skip=true && break  # exits the inner loop early since a match was found.
  done
  $skip && continue  # skip=false, the loop continues to the extraction step.

  tar -xvzf "$f"
done
