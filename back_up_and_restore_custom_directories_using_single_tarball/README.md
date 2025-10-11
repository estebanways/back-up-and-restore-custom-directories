# back-up-and-restore-scripts

Scripts for backing up and restoring custom directories, files, images, containers, and databases efficiently.

## File: back_up_custom_directories_using_single_tarball.sh

Creates a single .tgz archive containing the specified directories and logs any errors encountered during the process.

Best suited for simple or smaller backup sets.

### Use

Copy the script to your user home directory.

Setup the files and directories you want to back up.

Run the script.

```shell
bash back_up_custom_directories_using_single_tarball.sh
```

## File: restore_custom_directories_using_single_tarball.sh

### Use

Copy the restore script and the archive file to the root directory `/`.

Setup the archive you want to restore files and directories from in the restore script.

Run the script.

```shell
sudo bash restore_custom_directories_using_single_tarball.sh
```

or, if the script is executable:

```shell
sudo ./restore_dirs.sh
```

#### What Happens if You Don’t Use sudo

You’ll get errors like:

```output
tar: ./etc: Cannot mkdir: Permission denied
tar: ./root: Cannot open: Permission denied
tar: Exiting with failure status due to previous errors

```

and the restore will fail partially or entirely.
