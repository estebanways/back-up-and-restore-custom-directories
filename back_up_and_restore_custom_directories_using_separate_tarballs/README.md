# back-up-and-restore-scripts

Scripts for backing up and restoring custom directories, files, images, containers, and databases efficiently.

## File: back_up_custom_directories_using_separate_tarballs.sh

Creates individual .tgz archives for specified directories and logs any errors encountered during the process.

Ideal for handling large or complex backup sets that require separate, organized archives.

### Use

Copy the script to your user home directory.

Setup the files and directories you want to back up.

Run the script.

```shell
bash back_up_custom_directories_using_separate_tarballs.sh
```

Copy the archives to your storage drive(s) (set the correct paths).

```shell
sudo cp -dpR *dir.tgz /path/to/a/backup/directory
```

## File: restore_custom_directories_using_separate_tarballs.sh

### Use

Copy the script to the root directory `/`.

Setup the archives you want to restore files and directories from.

Run the script.

```shell
bash restore_custom_directories_using_separate_tarballs.sh
```

### Back Up and Restore Issues

For the most part, you can simply back up directories and restore them to another computer. However, there are some very important details to ensure everything works smoothly.

#### /etc/ Directory

The current backup version includes the entire `/etc/` directory. However, it can be made more granular by backing up only specific configuration files or subdirectories, such as `/etc/hosts`, `/etc/network/interfaces`, `/etc/postgresql/<version>/main/`, `/etc/ssh/`, `/etc/ssl/`.

Maintaining a single `/etc/` archive is often the best approach for managing system-level configurations. To use it, extract the /etc/ tarball to a location within your home directory. This allows you to browse individual configuration files and selectively update your system as needed.

It’s generally recommended to copy and paste the text contents of configuration files rather than copying the files themselves. This approach helps you avoid potential permission or ownership issues that can occur when directly overwriting system files.

#### Custom ~/config/ Directory

If the custom ~/config/ directory is in use, disorganized-configs_dir.tgz stores the disorganized symbolic links to ~/config/. If there is no backup copy of disorganized-configs_dir.tgz but still want to use ~/config/, you can recreate symbolic links to the correspondent files or directories under ~/config/.

Examples:

```shell
ln -s ~/config/.vimrc ~/.vimrc
ln -s ~/config/.vim/ ~/.vim/
```

#### SSH and GPG Keys (`~/.ssh`, `~/.gnupg`)

These will work perfectly after being copied over.

The only potential issue is file permissions.

When you run `ls -hal .ssh`, you should see something like this:

```output
drwx------  2 myusername myusername 4.0K Mar  1  2024 .
drwx------ 49 myusername myusername 4.0K Oct  9 18:32 ..
-rw-------  1 myusername myusername  571 Mar  1  2024 authorized_keys
-rw-------  1 myusername myusername  411 Jan  5  2024 id_ed25519
-rw-r--r--  1 myusername myusername  103 Jan  5  2024 id_ed25519.pub
-rw-------  1 myusername myusername 2.6K Mar  1  2024 id_rsa
-rw-r--r--  1 myusername myusername  571 Mar  1  2024 id_rsa.pub
-rw-------  1 myusername myusername 2.0K Feb 29  2024 known_hosts
-rw-------  1 myusername myusername 1.1K Feb 29  2024 known_hosts.old

```

If after restoring your `~/.ssh` directory you do not see the correct file permissions, you should immediately run the following commands to make sure your private keys are secure. SSH will refuse to use keys that have overly permissive settings.

```shell
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*        # private keys
chmod 644 ~/.ssh/*.pub       # public keys
chmod 644 ~/.ssh/known_hosts # optional, if exists
chmod 644 ~/.ssh/config      # optional, if you have one

```

It’s unnecessary to restrict the .pub files that much; you can safely set them to 644 (owner read/write, everyone else read).

#### Password Keyrings (`~/.local/share/keyrings/`)

This is the part that requires attention. The `login.keyring` file, which stores your application and network passwords, is **encrypted using your user login password**.

👍 **If you use the same login password on the new computer**: Everything will work automatically. When you log in, the system will use your password to unlock the keyring just like on your old machine. This is the easiest method.

⚠️ **If you use a different login password on the new computer**: The automatic unlock will fail. The first time an application tries to access a stored password, a prompt will appear asking for the password to unlock the keyring. You will need to **enter your OLD password** from your previous computer to unlock it. You can then use the "Passwords and Keys" application to change the keyring's password to match your new login password.

#### Summary & Best Practice

For the smoothest experience:

Use the exact same user login password on the new computer as you did on the old one.

After restoring the files, fix the permissions on your `~/.ssh` directory.

Remember to transport your backup (e.g., on a USB drive) securely, as it contains all your private credentials. 🔒
