# bash-fileops - A collection of Bash Scripts for file operations and management
![License](https://img.shields.io/github/license/jamescherti/bash-fileops)

The `bash-fileops` project is a collection of helpful Bash scripts that simplify various file operations such as searching for files, performing operations on them, and modifying their contents.

## Installation

### System-wide installation

To install the `bash-fileops` scripts system-wide, use the following command:
```bash
sudo make install
```

### Alternative installation: Install in your home directory

If you prefer to install the scripts locally in your home directory, you can use the `~/.local/bin` directory. This method avoids requiring administrative privileges and keeps the installation isolated to your user environment.

Use the following command to install the scripts into the `~/.local/bin` directory:

```bash
PREFIX=~/.local make install
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

## Scripts

### Script: rgfiles

The `rgfiles` bash script recursively search the specified directory and print the list of file paths to standard output. By default, the it ignores: `.git` directories, files that match `.gitignore` rules, and binary files.

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
Usage: sre [-h] [-i] <string-before> <string-after>

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

## License

Copyright (C) 2023-2024 [James Cherti](https://www.jamescherti.com)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.

## Links

- [bash-fileops @GitHub](https://github.com/jamescherti/bash-fileops)
