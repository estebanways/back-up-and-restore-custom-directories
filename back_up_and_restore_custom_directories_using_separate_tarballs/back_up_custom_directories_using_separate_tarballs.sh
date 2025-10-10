#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Script Name: Backup and Restore Custom Directories
# Author:      Esteban Herrera Castro
# Email:       stv.herrera@gmail.com
# Date:        10/07/2025
# ------------------------------------------------------------------------------
# Description:
# This script compresses specified directories into separate .tgz archive files
# and logs any errors encountered during the process. It also includes optional
# commands for copying the archives to a specified backup directory and for
# restoring the directories from the archives.
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
# ------------------------------------------------------------------------------

# ==============================================================================
# BACK UP
# ==============================================================================
# Change to the directory where you want the TGZs and log file to be stored
cd || exit

# Skip multiple password prompts
# sudo -v asks for the password once at the start
# The while loop in the background refreshes the sudo timestamp every 60 seconds
# so you won’t have to re-enter the password while the script runs.
# All the existing sudo tar ... commands remain unchanged (for copy and paste use).
# sudo -k at the end clears the cached sudo credentials for safety.
sudo -v
# Keep sudo alive
while true; do sudo -n true; sleep 60; kill -0 $$ || exit; done 2>/dev/null &

# Clean up the log file
: > dirs.log

# Compress the specified directories into dirs _dir.tgz and log errors to dirs.log

# Local user: current user
# ------------------------

# User configs
echo "=== BACKUP START: BraveSoftware_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf BraveSoftware_dir.tgz "$HOME"/.config/BraveSoftware/ 2>>dirs.log
echo "=== BACKUP START: sword-vim-nvim-site-only_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf sword-vim-nvim-site-only_dir.tgz "$HOME"/.local/share/nvim/site/ 2>>dirs.log
echo "=== BACKUP START: lazyvim-config-only.tgz ===" | tee -a dirs.log
sudo tar -cvzpf lazyvim-config-only.tgz "$HOME"/.config/nvim/ 2>>dirs.log

# Custom user configs
echo "=== BACKUP START: config_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf config_dir.tgz "$HOME"/config/ 2>>dirs.log
# If the custom ~/config/ directory is not in use, save a list of config files
# or directories to a single archive.
# tar preserves symlinks by default (it stores the link itself, not what it
# points to, and the symlink relationship is stored.)
echo "=== BACKUP START: disorganized-configs_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf disorganized-configs_dir.tgz "$HOME"/.bashrc "$HOME"/.tmux.conf.local "$HOME"/.vimrc "$HOME"/.wezterm.lua "$HOME"/.zshrc 2>>dirs.log

# User passwords and keys
# Password Keyrings & Stored Passwords. Also, Private Keys & Certificates
echo "=== BACKUP START: keyrings_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf keyrings_dir.tgz "$HOME"/.local/share/keyrings/ 2>>dirs.log
# Private Keys & Certificates (certificates used by applications like web
# browsers and email clients kept in a separate database)
echo "=== BACKUP START: pki_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf pki_dir.tgz "$HOME"/.pki/nssdb/ 2>>dirs.log
# Secure Shell (SSH) Keys
echo "=== BACKUP START: ssh_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf ssh_dir.tgz "$HOME"/.ssh/ 2>>dirs.log
# GnuPG GPG Keys
echo "=== BACKUP START: gnupg_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf gnupg_dir.tgz "$HOME"/.gnupg/ 2>>dirs.log
# Pash store (Requires gnupg keys from backup or exported and imported)
echo "=== BACKUP START: pash_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf pash_dir.tgz "$HOME"/.local/share/pash/ 2>>dirs.log

# Default user directories
echo "=== BACKUP START: Documents_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf Documents_dir.tgz "$HOME"/Documents/ 2>>dirs.log
echo "=== BACKUP START: Downloads_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf Downloads_dir.tgz "$HOME"/Downloads/ 2>>dirs.log

# Custom user directories
echo "=== BACKUP START: Dev_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf Dev_dir.tgz "$HOME"/Dev/ 2>>dirs.log
echo "=== BACKUP START: DevDocs_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf DevDocs_dir.tgz "$HOME"/DevDocs/ 2>>dirs.log
echo "=== BACKUP START: NextVideos_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf NextVideos_dir.tgz "$HOME"/NextVideos/ 2>>dirs.log

# Share directories
echo "=== BACKUP START: Syncthing_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf Syncthing_dir.tgz "$HOME"/Sync/ 2>>dirs.log

# Docker/Podman stack directories
echo "=== BACKUP START: arcane_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf arcane_dir.tgz "$HOME"/Docker/stacks/arcane/ 2>>dirs.log
echo "=== BACKUP START: commbase_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf commbase_dir.tgz "$HOME"/Docker/stacks/commbase/ 2>>dirs.log
echo "=== BACKUP START: devstation_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf devstation_dir.tgz "$HOME"/Docker/stacks/devstation/ 2>>dirs.log
echo "=== BACKUP START: multiple-dev-container-vscode_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf multiple-dev-container-vscode_dir.tgz "$HOME"/Docker/stacks/multiple-dev-container-vscode/ 2>>dirs.log

# Local user: root (sudo is required)
# -----------------------------------

# Root user directories
echo "=== BACKUP START: root_dir.tgz ===" | tee -a dirs.log
sudo tar -cvzpf root_dir.tgz /root/ 2>>dirs.log

# System configs (networking, services out of user spaces, etc.)
echo "=== BACKUP START: etc_dir.tgz  ===" | tee -a dirs.log
sudo tar -cvzpf etc_dir.tgz /etc/ 2>>dirs.log

# Pandoras universal chroot environment images
#echo "=== BACKUP START: pandoras-images_dir.tgz ===" | tee -a dirs.log
#sudo tar -cvzpf pandoras-images_dir.tgz /var/pandoras/images/ 2>>dirs.log

# Local user: user2
# -----------------

# Add more directories here...

# Optional: invalidate sudo cache at the end
sudo -k

# FURTHER STEPS

# Copy the archives to your storage drive(s) (uncomment and set the correct paths)
#cp -dpR *dir.tgz /path/to/a/backup/directory

# ==============================================================================
# RESTORE
# ==============================================================================
# Go to the root of the file system (uncomment and run as needed)
#cd /

# To extract a single archive (uncomment and set the correct path)
#tar -xvzpf /path/to/*dir.tgz

# To untar all .tgz archives in a directory. It extracts each archive one by one.
# Use a loop
#for f in /path/to/*_dir.tgz; do
#  tar -xvzf "$f"
#done

# Add -C /destination/path if you want to extract them into a specific directory:
#for f in /path/to/*dir.tgz; do
#  tar -xvzf "$f" -C /backup/restore/
#done

# Use an array of excluded filenames (clean and scalable)
#exclude_list=(
#  "/path/to/exclude1.tgz"
#  "/path/to/exclude2.tgz"
#  "/path/to/exclude3.tgz"
#)
#
#for f in /path/to/*.tgz; do
#  skip=false
#  for ex in "${exclude_list[@]}"; do
#    [[ "$f" == "$ex" ]] && skip=true && break
#  done
#  $skip && continue
#
#  tar -xvzf "$f"
#done

# This approach is recommended if you’ll add or remove excluded files often — it
# keeps your code clean and easy to maintain.
