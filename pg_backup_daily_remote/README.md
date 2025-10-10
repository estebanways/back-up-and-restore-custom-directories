# back-up-and-restore-scripts

Scripts for backing up and restoring custom directories, files, images, containers, and databases efficiently.

## File: pg_backup_daily_remote.sh

It automatically backs up all PostgreSQL databases daily, with compression, timestamps, and automatic cleanup of old backups. Automatically uploads the PostgreSQL backup to a remote server via SSH (using rsync or scp) right after creating it.

### Use

Copy the script to your user home directory.

Setup the files and directories you want to back up.

Run the script.

```shell
bash back_up_custom_directories_using_single_tarball.sh
```
