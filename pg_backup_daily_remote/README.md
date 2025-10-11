# back-up-and-restore-scripts

Scripts for backing up and restoring custom directories, files, images, containers, and databases efficiently.

## File: pg_backup_daily_remote.sh

It automatically backs up all PostgreSQL databases daily, with compression, timestamps, and automatic cleanup of old backups. Automatically uploads the PostgreSQL backup to a remote server via SSH (using rsync or scp) right after creating it.

### Setup Steps

Copy the file to the directory `/usr/local/bin/` and make it executable:

```shell
sudo chmod +x /usr/local/bin/pg_backup_daily_remote.sh
```

Create the backup directory:

```shell
sudo mkdir -p /var/backups/postgresql
sudo chown postgres:postgres /var/backups/postgresql
```

Generate an SSH key for passwordless upload:

```shell
sudo -u postgres ssh-keygen -t rsa -b 4096 -f /var/lib/postgresql/.ssh/id_rsa
sudo -u postgres ssh-copy-id -i /var/lib/postgresql/.ssh/id_rsa.pub backupuser@backup.example.com
```

Then test the connection:

```shell
sudo -u postgres ssh backupuser@backup.example.com
```

Test backup manually:

```shell
sudo /usr/local/bin/pg_backup_daily_remote.sh
```

Schedule it in cron (as the postgres user):

```shell
sudo crontab -e -u postgres
```

Add:

```output
0 2 * * * /usr/local/bin/pg_backup_daily_remote.sh
```

#### Result

Each night at 2 AM:

A full PostgreSQL backup is compressed and stored locally.

The backup is uploaded securely to your remote server via SSH.

Local backups older than 7 days are deleted.

All activity is logged in /var/backups/postgresql/pg_backup.log.

### Restore Example

To restore all databases from a backup:

```shell
gunzip -c /var/backups/postgresql/all_databases_YYYY-MM-DD_HH-MM-SS.sql.gz | sudo -u postgres psql
```

#### If You Omit `sudo -u postgres`

You’ll usually get:

```output
psql: error: connection to server at "localhost" failed: FATAL:  Peer authentication failed for user "root"
```

PostgreSQL on operating systems like Debian runs under the postgres system user, and local connections (via UNIX sockets) are typically authenticated using the peer method — meaning that only the OS user postgres can access the postgres role in the database without a password.

If you prefer to restore as a different user (e.g., root or your username), you can modify /etc/postgresql/<version>/main/pg_hba.conf to allow md5 or scram-sha-256 authentication for local connections — but for safety and simplicity, using sudo -u postgres is best.
