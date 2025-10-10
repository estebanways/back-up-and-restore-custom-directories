# back-up-and-restore-custom-directories

Compresses specified directories into .tgz archive(s) and logs errors. It includes optional commands for copying the archive(s) to a backup location and restoring directories from the archive(s).

## Back Up and Restore Issues

For the most part, you can simply back up directories and restore them to another computer. However, there is one very important detail to ensure everything works smoothly, especially for your saved passwords.

### SSH and GPG Keys (`~/.ssh`, `~/.gnupg`)

These will work perfectly after being copied over.

The only potential issue is file permissions.

When you run `ls -hal .ssh`, you must see something like this:

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

After you restore your `~/.ssh` directory, you should immediately run the following commands to make sure your private keys are secure. SSH will refuse to use keys that have overly permissive settings.

```shell
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*        # private keys
chmod 644 ~/.ssh/*.pub       # public keys
chmod 644 ~/.ssh/known_hosts # optional, if exists
chmod 644 ~/.ssh/config      # optional, if you have one

```

It’s unnecessary to restrict the .pub files that much; you can safely set them to 644 (owner read/write, everyone else read).

### Password Keyrings (`~/.local/share/keyrings/`)

This is the part that requires attention. The `login.keyring` file, which stores your application and network passwords, is **encrypted using your user login password**.

👍 **If you use the same login password on the new computer**: Everything will work automatically. When you log in, the system will use your password to unlock the keyring just like on your old machine. This is the easiest method.

⚠️ **If you use a different login password on the new computer**: The automatic unlock will fail. The first time an application tries to access a stored password, a prompt will appear asking for the password to unlock the keyring. You will need to **enter your OLD password** from your previous computer to unlock it. You can then use the "Passwords and Keys" application to change the keyring's password to match your new login password.

### Summary & Best Practice

For the smoothest experience:

Use the exact same user login password on the new computer as you did on the old one.

After restoring the files, fix the permissions on your `~/.ssh` directory.

Remember to transport your backup (e.g., on a USB drive) securely, as it contains all your private credentials. 🔒
