# bash-stdops - A collection of Bash helper scripts that facilitate operations
![License](https://img.shields.io/github/license/jamescherti/bash-stdops)

The `bash-stdops` project is a collection of helpful Bash scripts, written by [James Cherti](https://www.jamescherti.com/), that simplify various operations, including file searching, text replacement, and content modification.

The author uses these scripts in conjunction with text editors like Emacs and Vim to automate tasks, including managing tmux sessions, replacing text across a Git repository, and securely copying and pasting from the clipboard by prompting the user before executing commands in tmux, among other operations.

## Installation

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

## Requirements

- rg
- parallel
- sed
- nproc

## Install requirements on Debian/Ubuntu based systems

```
sudo apt install coreutils parallel ripgrep sed
```

(coreutils installs nproc)

## Script category: tmux

### Scripts: cbcopy, cbpaste, and tmux-cbpaste

- `cbcopy`: This script copies content to the clipboard.
- `cbpaste`: Reads the contents of the system clipboard and writes it to standard output (stdout).

### Script: tmux-cbpaste

The `tmux-cbpaste`: script enables pasting clipboard content into the current `tmux` window. It ensures safety by requiring user confirmation before pasting, preventing accidental insertion of data.

### Script: tmux-run

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

### Script: tmux-session

The `tmux-session` script attempts to attach to an existing `tmux` session. If the session does not exist, it creates a new session with that name.

If no session name is provided, it defaults to creating or attaching to a session named "0".

## Script category: files, paths, and strings

### Script: rgfiles

The `rgfiles` bash script recursively search the specified directory and print the list of file paths to standard output. By default, the it ignores: ".git" directories, files that match ".gitignore" rules, and binary files.

### Script: rgfiles-run

Recursively execute a command on all files listed by the `rg --files` command. For example, to recursively `cat` all text files in `/etc`, use the following command:
```
rgfiles-run /etc cat {}
```

(`{}` is replaced with the path to each file.)

Here is an example of how you can combine `rgfiles-run` and `sed` to replace "Text1" with "Text2" in a Git repository:
```
rgfiles-run /path/to/git-repository/ sed -i -e "s/Text1/Text2/g" {}
```

### Script: sre

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

Here is an example of how you can combine `rgfiles-run` and `sre` to replace `Text1` with `Text2` in a Git repository:
```
rgfiles-run /path/to/git-repository/ sre Text1 Text2 {}
```

### rgfiles-sre

Recursively replace strings in all files listed by the `rgfiles` command using `sre`.

### Scripts: path-tr, path-uppercase, path-lowercase

- `path-tr`: This script processes a given file path, extracts the directory and filename, converts the filename using the specified `tr` options (e.g., to lowercase), and prints the modified full path. Example usage: `path-tr /Path/TO/FILE '[:upper:]' '[:lower:]'` This will convert the filename to lowercase, producing: `/Path/TO/file`.

- `path-uppercase`: This script processes a given file path, extracts the directory and filename, converts the filename to uppercase. Example usage: `path-uppercase /Path/TO/FILE` This will convert the filename to uppercase, producing: `/Path/to/FILE`.

- `path-lowercase`: This script processes a given file path, extracts the directory and filename, converts the filename to lowercase. Example usage: `path-lowercase /Path/TO/FILE`. This will convert the filename to lowercase, producing: `/Path/TO/file`.

### Script: autoperm

This script sets permissions for files or directories:
- If it's a directory: 755
- If it's a file with a shebang (e.g., "#!/bin/bash"): 755
- If it's a file: 644

Usage:
```
autoperm /path/to/file-or-directory
```

### Script: path-is

Print the Path to stdout and exit with the code 0 if it is a binary or text file.

Example usage:
``` bash
path-is /Path/TO/FILE binary
path-is /Path/TO/FILE text
```

## Script category: Misc

### Script: largs

This script reads from standard input and executes a command for each line, replacing `{}` with the content read from stdin. It expects `{}` to be passed as one of the arguments and will fail if `{}` is not provided.

This script is an alternative to xargs.
``` bash
{ echo "file1"; echo "file2"; } | largs ls {}
```

## License

Copyright (C) 2023-2024 [James Cherti](https://www.jamescherti.com)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.

## Links

- [bash-stdops @GitHub](https://github.com/jamescherti/bash-stdops)
