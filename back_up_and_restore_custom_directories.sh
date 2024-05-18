#!/usr/bin/env bash

# ------------------------------------------------------------
# Script Name: Backup and Restore Custom Directories
# Author:      Esteban Herrera Castro
# Email:       stv.herrera@gmail.com
# Date:        05/18/2024
# ------------------------------------------------------------
# Description:
# This script compresses specified directories into a single
# .tgz archive file and logs any errors encountered during the
# process. It also includes optional commands for copying the
# archive to a specified backup directory and for restoring
# the directories from the archive.
#
# BACK UP
# 1. Change to the directory where you want the TGZ and log files.
# 2. Add new directories or remove them as required from the list.
# 3. Compress the directories to a new archive dirs.tgz.
# 4. Copy the archive to your storage drive(s).
#
# RESTORE
# 1. Go to the root of the file system.
# 2. Extract the archive.
# ------------------------------------------------------------

# Ensure the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# BACK UP
# Change to the directory where you want the TGZ and log files to be stored
cd || exit

# Compress the specified directories into dirs.tgz and log errors to dirs.log
sudo tar -cvzpf dirs.tgz "$HOME"/.config/BraveSoftware/ "$HOME"/config/ "$HOME"/.local/share/nvim/site/ "$HOME"/Dev/ "$HOME"/DevDocs/ "$HOME"/Documents/ "$HOME"/Downloads/ /etc/ 2>dirs.log

# Copy the archive to your storage drive(s) (uncomment and set the correct path)
#cp -dpR dirs.tgz /path/to/a/backup/directory

# RESTORE
# Go to the root of the file system (uncomment and run as needed)
#cd /

# Extract the archive (uncomment and set the correct path)
#tar -xvzpf /path/to/dirs.tgz
