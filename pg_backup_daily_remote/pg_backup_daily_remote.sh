#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Script Name: PostgreSQL Daily Backup + Remote Upload
# Author:      Esteban Herrera Castro
# Email:       stv.herrera@gmail.com
# Date:        10/10/2025
# ------------------------------------------------------------------------------
# Description:
# It automatically backs up all PostgreSQL databases daily, with compression,
# timestamps, and automatic cleanup of old backups. Automatically uploads the
# PostgreSQL backup to a remote server via SSH (using rsync or scp) right after
# creating it.
# ------------------------------------------------------------------------------
