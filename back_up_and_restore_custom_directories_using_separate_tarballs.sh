#!/usr/bin/env bash

# ------------------------------------------------------------
# Script Name: Backup and Restore Custom Directories
# Author:      Esteban Herrera Castro
# Email:       stv.herrera@gmail.com
# Date:        10/07/2025
# ------------------------------------------------------------
# Description:
# This script compresses specified directories into separate
# .tgz archive files and logs any errors encountered during the
# process. It also includes optional commands for copying the
# archives to a specified backup directory and for restoring
# the directories from the archives.
#
# BACK UP
# 1. Change to the directory where you want the TGZs and log file.
# 2. Add new directories or remove them as required from the list.
# 3. Compress the directories to new archive dirs dir.tgz.
# 4. Copy the archives to your storage drive(s).
#
# RESTORE
# 1. Go to the root of the file system.
# 2. Extract the archives.
# ------------------------------------------------------------

# BACK UP
# Change to the directory where you want the TGZs and log file to be stored
cd || exit

# Compress the specified directories into dirs _dir.tgz and log errors to dirs.log
# Current local user directories
sudo tar -cvzpf BraveSoftware_dir.tgz "$HOME"/.config/BraveSoftware/ 2>dirs.log
sudo tar -cvzpf config_dir.tgz "$HOME"/config/ 2>>dirs.log
sudo tar -cvzpf nvim_dir.tgz "$HOME"/.local/share/nvim/site/ 2>>dirs.log
sudo tar -cvzpf Dev_dir.tgz "$HOME"/Dev/ 2>>dirs.log
sudo tar -cvzpf DevDocs_dir.tgz "$HOME"/DevDocs/ 2>>dirs.log
sudo tar -cvzpf Documents_dir.tgz "$HOME"/Documents/ 2>>dirs.log
sudo tar -cvzpf Downloads_dir.tgz "$HOME"/Downloads/ 2>>dirs.log
sudo tar -cvzpf NextVideos_dir.tgz "$HOME"/NextVideos/ 2>>dirs.log
# Docker stacks directories
sudo tar -cvzpf arcane_dir.tgz "$HOME"/Stacks/arcane/ 2>>dirs.log
sudo tar -cvzpf commbase_dir.tgz "$HOME"/Stacks/commbase/ 2>>dirs.log
sudo tar -cvzpf devstation_dir.tgz "$HOME"/Stacks/devstation/ 2>>dirs.log
sudo tar -cvzpf multiple-dev-container-vscode_dir.tgz "$HOME"/Stacks/multiple-dev-container-vscode/ 2>>dirs.log
# Share directories
sudo tar -cvzpf Syncthing_dir.tgz "$HOME"/Sync/ 2>>dirs.log
# Local root user directories
sudo tar -cvzpf etc_dir.tgz /etc/ 2>>dirs.log
sudo tar -cvzpf root_dir.tgz /root/ 2>>dirs.log

# Copy the archives to your storage drive(s) (uncomment and set the correct paths)
#cp -dpR *dir.tgz /path/to/a/backup/directory

# RESTORE
# Go to the root of the file system (uncomment and run as needed)
#cd /

# Extract the archives (uncomment and set the correct path)
#tar -xvzpf /path/to/*dir.tgz
