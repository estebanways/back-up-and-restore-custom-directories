# back-up-and-restore-custom-directories

Compresses specified directories into .tgz archive(s) and logs errors. It includes optional commands for copying the archive(s) to a backup location and restoring directories from the archive(s).

## Back Up and Restore Issues

For the most part, you can simply back up directories and restore them to another computer. However, there is one very important detail to ensure everything works smoothly, especially for your saved passwords.

### SSH and GPG Keys (`~/.ssh`, `~/.gnupg`)

These will work perfectly after being copied over.

The only potential issue is file permissions. After you restore your ~/.ssh directory, you should immediately run the following command to make sure your private keys are secure. SSH will refuse to use keys that have overly permissive settings.

```shell
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
```

### Password Keyrings (`~/.local/share/keyrings/`)

This is the part that requires attention. The `login.keyring` file, which stores your application and network passwords, is **encrypted using your user login password**.

👍 **If you use the same login password on the new computer**: Everything will work automatically. When you log in, the system will use your password to unlock the keyring just like on your old machine. This is the easiest method.

⚠️ **If you use a different login password on the new computer**: The automatic unlock will fail. The first time an application tries to access a stored password, a prompt will appear asking for the password to unlock the keyring. You will need to **enter your OLD password** from your previous computer to unlock it. You can then use the "Passwords and Keys" application to change the keyring's password to match your new login password.

### Summary & Best Practice

For the smoothest experience:

Use the exact same user login password on the new computer as you did on the old one.

After restoring the files, fix the permissions on your `~/.ssh` directory.

Remember to transport your backup (e.g., on a USB drive) securely, as it contains all your private credentials. 🔒
