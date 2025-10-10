# back-up-and-restore-scripts

Back up and Restore scripts for custom directories.

## back_up_and_restore_custom_directories_using_single_tarball

Creates a single .tgz archive containing the specified directories and logs any errors encountered during the process.

Includes optional commands to copy the archive to a backup location and to restore directories from it.

Best suited for simple or smaller backup sets.

## back_up_and_restore_custom_directories_using_separate_tarballs

Creates individual .tgz archives for specified directories and logs any errors encountered during the process.

Ideal for handling large or complex backup sets that require separate, organized archives.

## back_up_and_restore_custom_directories_with_zstd

A comprehensive guide to creating, verifying, and restoring backups using Zstandard (zstd) for faster and more efficient compression. It covers command examples, integrity checks, error recovery, and advanced techniques like dictionary-based compression to improve speed and consistency in repeated backups.
