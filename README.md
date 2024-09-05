# bash-fileops - A collection of Bash Scripts for file operations and management
![License](https://img.shields.io/github/license/jamescherti/bash-fileops)

The `bash-fileops` project is a collection of helpful Bash scripts that simplify various file operations such as searching for files, performing operations on them, and modifying their contents.

## Installation

### System-wide Installation

To install the `bash-fileops` scripts system-wide, follow these steps:

1. **Ensure you have the necessary permissions**: You will need administrative (root) privileges to install software system-wide. Use `sudo` if necessary.

2. **Run the installation command**:

```bash
   sudo make install
```

### Install in your home directory

If you prefer to install the scripts locally in your home directory, you can use the `~/.local/bin` directory. This method avoids requiring administrative privileges and keeps the installation isolated to your user environment. Follow these steps:

1. **Prepare the Installation Directory**:
   The scripts can installed into the `~/.local` directory, which is a common location for user-specific installations. The `~/.local/bin` directory will be used for executable files.

2. **Run the Installation Command**:
   Use the following command to install the scripts into the `~/.local/bin` directory:

```bash
PREFIX=~/.local make install
```

## Requirements

- rg
- make
- parallel

## Scripts

### rgfiles

The `rgfiles` bash script recursively search the specified directory and print the list of file paths to standard output. By default, the it ignores:
- `.git` directories,
- files that match `.gitignore` rules,
- and binary files.

## License

Copyright (C) 2023-2024 [James Cherti](https://www.jamescherti.com)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.

## Links

- [bash-fileops @GitHub](https://github.com/jamescherti/bash-fileops)
