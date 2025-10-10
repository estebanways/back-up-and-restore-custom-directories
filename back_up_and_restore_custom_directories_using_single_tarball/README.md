# back-up-and-restore-scripts

Back up and Restore scripts for custom directories.

## File: back_up_and_restore_custom_directories_using_single_tarball.sh

Creates a single .tgz archive containing the specified directories and logs any errors encountered during the process.

Includes optional commands to copy the archive to a backup location and to restore directories from it.

Best suited for simple or smaller backup sets.

### Use

Copy the script to your user home directory.

Setup the files and directories you want to back up.

Run the script.

```shell
bash back_up_and_restore_custom_directories_using_single_tarball.sh
```
