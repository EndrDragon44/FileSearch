# File Search Application

This is a command-line file search application originally written in C, now written with Rust. The application searches for a specified filename or subdirectory in a directory and all its subdirectories and provides a list of matching files or subdirectories. It supports threading, logfiles, wildcards, case-sensitivity, and more.

### OS Support
#### Windows
- [x] 64 bit
- [x] 32 bit
- [x] ARM64

#### Linux
- [x] 64 bit
- [x] 32 bit
- [x] ARM64

#### macOS
- [x] 64 bit
- [ ] ARM64 (M-series)

More support will need contributors, see the section below!


## Features

- Search for a specific file or subdirectory in a directory and its subdirectories.
- Display the paths of all matching files or subdirectories.
- Option to continue searching for more matching files or subdirectories.
- Cross-platform compatibility (Windows, Linux, and macOS).

## Installation and Usage

### Windows:

1. Download the version you want for Windows from the [releases](https://github.com/EndrDragon44/FileSearch/releases) page.

2. Extract `filesearch.exe` to your downloads folder, or wherever you prefer.

3. Move `filesearch.exe` from where you extracted it to the "System32" folder (`C:\Windows\System32`). This will need administrator priviledges to do.

4. Open a command prompt (Press `Win + R`, type `cmd`, and press Enter).

5. In the command prompt, type the following command to run the application for file search:

   ```
   filesearch.exe /FM "filename" [directory]
   ```

   To start a subdirectory search:

   ```
   filesearch.exe /SDM "subdirectory" [directory]
   ```

   Or to find both:

   ```
   filesearch.exe /BOTH "query" [directory]
   ```

   Replace "filename" or "subdirectory" with the name of the file or subdirectory you want to search for, and optionally specify the starting directory for the search (default is the current directory).
### Linux:

1. Download the version you want for Linux from the [releases](https://github.com/EndrDragon44/FileSearch/releases) page.

2. Extract the zip folder and extract the `filesearch` binary to your Downloads folder or wherever you prefer.

3. Open a terminal and navigate to the folder you extracted to. run `chmod a+rx ./filesearch` to allow every user permissions to read and execute, then run `sudo mv ./filesearch /bin` and authenticate to globally install filesearch. 

4. In the terminal, type the following command to run the application for file search:

   ```
   ./filesearch /FM "filename" [directory]
   ```

   To start a subdirectory search:

   ```
   ./filesearch /SDM "subdirectory" [directory]
   ```
   
   Or to find both:

   ```
   filesearch /BOTH "query" [directory]
   ```

   Replace "filename" or "subdirectory" with the name of the file or subdirectory you want to search for, and optionally specify the starting directory for the search (default is the current directory).
### Linux:

1. Download the version you want for macOS from the [releases](https://github.com/EndrDragon44/FileSearch/releases) page.

2. Extract the zip folder and extract the `filesearch` binary to your Downloads folder or wherever you prefer.

3. Open a terminal and navigate to the folder you extracted to. run `chmod a+rx ./filesearch` to allow every user permissions to read and execute, then run `sudo mv ./filesearch /bin` and authenticate to globally install filesearch. 

4. In the terminal, type the following command to run the application for file search:

   ```
   ./filesearch /FM "filename" [directory]
   ```

   To start a subdirectory search:

   ```
   ./filesearch /SDM "subdirectory" [directory]
   ```
   
   Or to find both:

   ```
   filesearch /BOTH "query" [directory]
   ```

   Replace "filename" or "subdirectory" with the name of the file or subdirectory you want to search for, and optionally specify the starting directory for the search (default is the current directory).

## Notes:
### Errors
Errors that appear from threads that state it has insufficent permissions, or that the directory it tried to access was invalid, indicate that you do not have access to that directory. To try fixing this, you can run the command using administrative rights by running it in an elevated command prompt in Windows, or by running it using `sudo` on Linux and macOS like so: `sudo filesearch [mode] "query" [directory]`
### Limits
When on Windows and use WSL to run the Linux version, running a search in `/` or `/mnt/` may produce many permission errors, regardless of how you run it. This is caused by how WSL mounts Windows drive letters (C:\, D:\, etc) to the container, and how NTFS permssions for system files and directories are enforced to WSL even when read with superuser. The only way to avoid the log clutter from Windows drives is either to unmount the drives with `sudo umount /mnt/[ltr] -f` and try again, or just use the Windows version to access Windows filesystems.

## Contribution

This project welcomes contributions from macOS and Linux users who can help test and build versions of the application for these platforms. If you are interested in contributing, please follow the steps mentioned in the "Contribution" section of this README.

We do have a contributer for ARM (M-Series) builds for macOS!

## Attribution

Contributors who help test and build versions for macOS and Linux will be credited for their contributions in this README and the project's GitHub repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or need further assistance, feel free to open an issue in the repository.

We appreciate your support in making this application accessible and functional on multiple platforms! Your contributions will be acknowledged and will help improve the project for all users. Happy searching!
