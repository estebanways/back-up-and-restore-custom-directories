#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Script Name: Backup and Restore Custom Directories
# Author:      Esteban Herrera Castro
# Email:       stv.herrera@gmail.com
# Date:        10/10/2025
# ------------------------------------------------------------------------------
# Description:
# This script restores the directories from the archive.
#
# Steps
# 1. Copy the file dirs.tgz to the root directory "/".
# 2. Go to the root of the file system.
# 3. Extract the archive.
# ------------------------------------------------------------------------------

# Go to the root of the file system
cd / || exit

# Extract the archive
tar -xvzpf dirs.tgz
