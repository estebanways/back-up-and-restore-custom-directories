# back-up-and-restore-scripts

Back up and Restore scripts for custom directories.

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

Copy the script to the root directory `/`.

Setup the archive you want to restore files and directories from.

Run the script.

```shell
bash restore_custom_directories_using_single_tarball.sh
```
