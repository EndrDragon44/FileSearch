# File Search Application

This is a command-line file search application written in C. The application searches for a specified filename or subdirectory in a directory and all its subdirectories and provides a list of matching files or subdirectories.

## Features

- Search for a specific file or subdirectory in a directory and its subdirectories.
- Display the paths of all matching files or subdirectories.
- Option to continue searching for more matching files or subdirectories.
- Cross-platform compatibility (Windows, Linux, and macOS).

## Installation and Usage

### Windows:

1. Download the executable "FileSearch.exe" for Windows from the [releases](https://github.com/EndrDragon44/FileSearch/releases) page.

2. If not already installed, install VS Redist from Microsoft: (Links Below)

      [VS Redist x86 Download](https://aka.ms/vs/17/release/vc_redist.x86.exe)
      [VS Redist x64 Download](https://aka.ms/vs/17/release/vc_redist.x64.exe)
      **No ARM VS Redist because I never compiled for ARM anyway.**
   
3. Move the downloaded "FileSearch.exe" to the "System32" folder (`C:\Windows\System32`).

4. Open a command prompt (Press `Win + R`, type `cmd`, and press Enter).

5. In the command prompt, type the following command to run the application for file search:

   ```
   FileSearch.exe /FM "filename" [directory]
   ```

   Or for subdirectory search:

   ```
   FileSearch.exe /SDM "subdirectory" [directory]
   ```

   Replace "filename" or "subdirectory" with the name of the file or subdirectory you want to search for, and optionally specify the starting directory for the search (default is the current directory).
   Oh, and if for whatever reason you are using this in WSL (Windows Subsystem for Linux, basically Linux in Windows, but by Microsoft), it'll still work. Follow the steps for Linux and it works the same! (That's how I tested and compiled the Linux release...)

### Linux and macOS:

1. Download the executable "file_search" for Linux and macOS from the [releases](https://github.com/EndrDragon44/FileSearch/releases) page.

2. Open a terminal.

3. Navigate to the directory containing the downloaded "filesearch" executable.

4. In the terminal, type the following command to run the application for file search:

   ```
   ./filesearch /FM "filename" [directory]
   ```

   Or for subdirectory search:

   ```
   ./filesearch /SDM "subdirectory" [directory]
   ```

   Replace "filename" or "subdirectory" with the name of the file or subdirectory you want to search for, and optionally specify the starting directory for the search (default is the current directory).

## Notes:

If you get an error saying "[directory/file] was not found." that means you don't have access to it or it is a Windows compatiblility junction/symlink. (like the 'Documents and Settings' folder on the C:\ root that links to 'C:\Users' for compatibility with Windows XP applications as in XP it was called 'C:\Documents and Settings' instead of 'C:\Users')
It does not search in these folders. Run the tool as SYSTEM user or as an ADMIN to TRY bypassing it.

## Contribution

This project welcomes contributions from macOS and Linux users who can help test and build versions of the application for these platforms. If you are interested in contributing, please follow the steps mentioned in the "Contribution" section of this README.

## Attribution

Contributors who help test and build versions for macOS and Linux will be credited for their contributions in this README and the project's GitHub repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or need further assistance, feel free to contact the project maintainers or open an issue in the GitHub repository.

We appreciate your support in making this application accessible and functional on multiple platforms! Your contributions will be acknowledged and will help improve the project for all users. Happy searching!
