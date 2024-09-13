# bash-stdops - A collection of Bash helper scripts that facilitate operations
![License](https://img.shields.io/github/license/jamescherti/bash-stdops)

The `bash-stdops` project is a collection of helpful Bash scripts, written by [James Cherti](https://www.jamescherti.com/), that simplify various operations, including file searching, text replacement, and content modification.

The author uses these scripts in conjunction with text editors like Emacs and Vim to automate tasks, including managing Tmux sessions, replacing text across a Git repository, securely copying and pasting from the clipboard by prompting the user before executing commands in Tmux, fix permissions, among other operations.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [bash-stdops - A collection of Bash helper scripts that facilitate operations](#bash-stdops---a-collection-of-bash-helper-scripts-that-facilitate-operations)
    - [Install bash-stdops scripts](#install-bash-stdops-scripts)
        - [System-wide installation](#system-wide-installation)
        - [Alternative installation: Install in your home directory](#alternative-installation-install-in-your-home-directory)
    - [Install dependencies](#install-dependencies)
        - [Install dependencies on Debian/Ubuntu based systems](#install-dependencies-on-debianubuntu-based-systems)
        - [Install dependencies on RedHat/CentOS/Fedora based systems](#install-dependencies-on-redhatcentosfedora-based-systems)
        - [Install dependencies on Gentoo based systems](#install-dependencies-on-gentoo-based-systems)
        - [Install dependencies on Arch Linux based systems](#install-dependencies-on-arch-linux-based-systems)
    - [Scripts](#scripts)
        - [Script category: tmux](#script-category-tmux)
            - [Script: tmux-cbpaste](#script-tmux-cbpaste)
            - [Script: tmux-run](#script-tmux-run)
            - [Script: tmux-session](#script-tmux-session)
        - [Script category: files, paths, and strings](#script-category-files-paths-and-strings)
            - [Script: allfiles](#script-allfiles)
            - [Script: allfiles-run](#script-allfiles-run)
            - [Script: sre](#script-sre)
            - [Script: git-sre](#script-git-sre)
            - [Scripts: path-tr, path-uppercase, path-lowercase](#scripts-path-tr-path-uppercase-path-lowercase)
            - [Script: autoperm](#script-autoperm)
            - [Script: path-is](#script-path-is)
        - [Script category: git](#script-category-git)
            - [git-dcommit](#git-dcommit)
            - [git-squash](#git-squash)
        - [Script category: ssh](#script-category-ssh)
            - [Script: sshwait](#script-sshwait)
        - [Script category: Misc](#script-category-misc)
            - [Scripts: cbcopy, cbpaste](#scripts-cbcopy-cbpaste)
            - [Script: outonerror](#script-outonerror)
            - [Script: largs](#script-largs)
            - [Script: xargs-loop](#script-xargs-loop)
    - [License](#license)
    - [Links](#links)

<!-- markdown-toc end -->

## Install bash-stdops scripts

### System-wide installation

To install the `bash-stdops` scripts system-wide, use the following command:
```bash
sudo make install
```

### Alternative installation: Install in your home directory

If you prefer to install the scripts locally in your home directory, you can use the `~/.local/bin` directory. This method avoids requiring administrative privileges and keeps the installation isolated to your user environment.

Use the following command to install the scripts into the `~/.local/bin` directory:

```bash
PREFIX=~/.local make install
```

Ensure that `~/.local/bin` is included in your `$PATH` by adding the following line to your `~/.bashrc`:
```
export PATH=$PATH:~/.local/bin
```

## Install dependencies

Instructions for installing dependencies are provided below. Note that not all of these dependencies are mandatory for every script.

### Install dependencies on Debian/Ubuntu based systems

```
# Requirements
sudo apt-get install coreutils parallel ripgrep sed

# Git
sudo apt-get install git

# SSH
sudo apt-get install openssh-client

# Clipboard
sudo apt-get install xclip
```

### Install dependencies on RedHat/CentOS/Fedora based systems

```
# Requirements
sudo dnf install coreutils parallel ripgrep sed git openssh-clients

# Git
sudo dnf install git

# SSH
sudo dnf install openssh-clients

# Clipboard
sudo dnf install xclip
```

### Install dependencies on Gentoo based systems

```
# Requirements
sudo emerge sys-apps/coreutils sys-process/parallel sys-apps/ripgrep sys-apps/sed

# Git
sudo emerge dev-vcs/git

# SSH
sudo emerge net-misc/openssh

# Clipboard
sudo emerge x11-misc/xclip
```

### Install dependencies on Arch Linux based systems

```
# Requirements
sudo pacman -S coreutils parallel ripgrep sed

# Git
sudo pacman -S git

# SSH
sudo pacman -S openssh

# Clipboard
sudo pacman -S xclip
```

## Scripts

### Script category: tmux

#### Script: tmux-cbpaste

The `tmux-cbpaste`: script enables pasting clipboard content into the current `tmux` window. It ensures safety by requiring user confirmation before pasting, preventing accidental insertion of data.

#### Script: tmux-run

This script executes a command in a new `tmux` window, which functions similarly to a tab in other applications.

- If run within an existing `tmux` session, it creates a new window in the same session.
- If run outside of `tmux`, it creates a new window in the first available `tmux` session.
- If the environment variable `TMUX_RUN_SESSION_NAME` is set, the script will create the new window in the specified `tmux` session.

Usage:
```
  tmux-run <command> [args...]
```

Example:
```
tmux-run bash
```

Example 2:
```
tmux-run bash -c htop
```

#### Script: tmux-session

The `tmux-session` script attempts to attach to an existing `tmux` session. If the session does not exist, it creates a new session with that name.

If no session name is provided, it defaults to creating or attaching to a session named "0".

### Script category: files, paths, and strings

#### Script: allfiles

The `allfiles` bash script recursively search the specified directory and print the list of file paths to standard output. By default, the it ignores: ".git" directories, files that match ".gitignore" rules, and binary files.

#### Script: allfiles-run

Recursively execute a command on all files listed by the `rg --files` command. For example, to recursively `cat` all text files in `/etc`, use the following command:
```
allfiles-run /etc cat {}
```

(`{}` is replaced with the path to each file.)

Here is an example of how you can combine `allfiles-run` and `sed` to replace "Text1" with "Text2" in a Git repository:
```
allfiles-run /path/to/git-repository/ sed -i -e "s/Text1/Text2/g" {}
```

#### Script: sre

The `sre` script replaces occurrences of a specified string or regular expression pattern with support for exact string matching, regular expressions, and case-insensitive matching. Unlike `sed`, which uses a single argument for replacements, this script allows specifying the text-to-find and text-to-replace as two distinct arguments.

To replace text in the standard input and output the result to the standard output:
```
echo "text-before" | sre "text-before" "text-after"
```

To replace text directly in a file (overwriting the file):
```
sre "text-before" "text-after" file
```

Here are the `sre` options:
```
Usage: sre [-ierdh] <string-before> <string-after>

  -i    Ignore case when comparing files
  -e    Use regular expressions instead of exact strings.
  -r    Use extended regular expressions.
  -d    Show the sed command
  -h    Show this help message and exit
```

Here is an example of how you can combine `allfiles-run` and `sre` to replace `Text1` with `Text2` in a Git repository:
```
allfiles-run /path/to/git-repository/ sre Text1 Text2 {}
```

#### Script: git-sre

Execute `sre` at the root directory of a Git repository.

(The `sre` script replaces occurrences of a specified string or regular expression pattern with support for exact string matching, regular expressions, and case-insensitive matching.)

Example usage:
```
git sre TextBefore TextAfter /path/to/git/repo
```

(sre also supports regular expressions.)

#### Scripts: path-tr, path-uppercase, path-lowercase

- `path-tr`: This script processes a given file path, extracts the directory and filename, converts the filename using the specified `tr` options (e.g., to lowercase), and prints the modified full path. Example usage: `path-tr /Path/TO/FILE '[:upper:]' '[:lower:]'` This will convert the filename to lowercase, producing: `/Path/TO/file`.

- `path-uppercase`: This script processes a given file path, extracts the directory and filename, converts the filename to uppercase. Example usage: `path-uppercase /Path/TO/FILE` This will convert the filename to uppercase, producing: `/Path/to/FILE`.

- `path-lowercase`: This script processes a given file path, extracts the directory and filename, converts the filename to lowercase. Example usage: `path-lowercase /Path/TO/FILE`. This will convert the filename to lowercase, producing: `/Path/TO/file`.

#### Script: autoperm

This script sets permissions for files or directories:
- If it's a directory: 755
- If it's a file with a shebang (e.g., "#!/bin/bash"): 755
- If it's a file: 644

Usage:
```
autoperm /path/to/file-or-directory
```

#### Script: path-is

Print the Path to stdout and exit with the code 0 if it is a binary or text file.

Example usage:
``` bash
path-is /Path/TO/FILE binary
path-is /Path/TO/FILE text
```

### Script category: git

#### git-dcommit

Script to automate common Git commit tasks:
- Automatically add untracked files (prompted),
- Display git diff to the user before committing,
- Commit changes to the Git repository,
- Optionally reuse the previous Git commit message if available.

Usage:
```
./script_name.sh
```

Run this script from within a Git repository to automate adding, reviewing, and committing changes.

#### git-squash

A script to squash new Git commits between the current branch and a specified branch.

```
Usage:
  ./script_name.sh <other-git-branch>
```

Features:
- Compares the current branch with the specified branch.
- Displays a summary of new commits to be squashed.
- Prompts for confirmation if there are more than 4 commits.
- Automatically squashes all new commits into one, retaining the message of
  the first commit.


### Script category: ssh

#### Script: sshwait

This script repeatedly attempts to check the availability of the SSH server on the host provided as the first argument. It exits with a 0 status upon successfully establishing a connection at least once. Note that it only verifies if the SSH server is reachable and does not provide a shell prompt or execute any commands on the remote host.

Usage:
```
./script_name.sh <host>
```

### Script category: Misc

#### Scripts: cbcopy, cbpaste

- `cbcopy`: This script copies the content of stdin to the clipboard.
- `cbpaste`: This script reads the contents of the system clipboard and writes it to stdout.

#### Script: outonerror

The `outonerror` script redirects the command's output to stderr only if the command fails (non-zero exit code). No output is shown when the command succeeds.

Here is an example of how to use this script: [How to make cron notify the user about a failed command by redirecting its output to stderr only when it fails (non-zero exit code)](https://www.jamescherti.com/cron-email-output-failed-commands-only/).

#### Script: largs

This script reads from standard input and executes a command for each line, replacing `{}` with the content read from stdin. It expects `{}` to be passed as one of the arguments and will fail if `{}` is not provided.

This script is an alternative to xargs.
``` bash
{ echo "file1"; echo "file2"; } | largs ls {}
```

#### Script: xargs-loop

The `xargs-loop` script processes lines from standard input, executing a specified command for each line and replacing `{}` in the command with the current line of input. This provides flexibility by using `{}` as a placeholder, similar to `xargs -I {}`, but with the ability to handle each line individually. Unlike `xargs`, which has mutually exclusive `-L 1` and `-I {}` options, `xargs-loop` combines the benefits of both by enabling placeholder substitution and line-by-line processing.

Usage:
```
cat input_file | xargs-loop command '{}'
```

Options:
- The script reads lines from stdin and replaces '{}' with each line in the command.
- The script exits with status 1 if the command does not include '{}' or if any command execution fails.

## License

Copyright (C) 2012-2024 [James Cherti](https://www.jamescherti.com)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.

## Links

- [bash-stdops @GitHub](https://github.com/jamescherti/bash-stdops)
