#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dirent.h"

// List to keep track of already-found files
char **found_files = NULL;
int found_files_size = 0;

// Search for a file in a directory and all its subdirectories
char **search_file(char *directory, char *filename) {
    char **paths = NULL;
    int paths_size = 0;

    DIR *dir = opendir(directory);
    if (!dir) {
        printf("Directory '%s' not found.\n", directory);
        return NULL;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {
            char subdir[1024];
            snprintf(subdir, sizeof(subdir), "%s/%s", directory, entry->d_name);
            char **subpaths = search_file(subdir, filename);
            if (subpaths) {
                int subpaths_size = 0;
                while (subpaths[subpaths_size]) {
                    paths_size++;
                    paths = realloc(paths, sizeof(char*) * paths_size);
                    paths[paths_size-1] = subpaths[subpaths_size];
                    subpaths_size++;
                }
            }
        }
        else if (entry->d_type == DT_REG && strcmp(entry->d_name, filename) == 0) {
            char path[1024];
            snprintf(path, sizeof(path), "%s/%s", directory, entry->d_name);
            int i;
            for (i = 0; i < found_files_size; i++) {
                if (strcmp(found_files[i], path) == 0) {
                    break;
                }
            }
            if (i == found_files_size) {
                paths_size++;
                paths = realloc(paths, sizeof(char*) * paths_size);
                paths[paths_size-1] = strdup(path);
                found_files_size++;
                found_files = realloc(found_files, sizeof(char*) * found_files_size);
                found_files[found_files_size-1] = strdup(path);
                printf("Found file: %s\n", path);
            }
        }
    }

    closedir(dir);
    return paths;
}

// Main function
int main(int argc, char **argv) {
    // Check if filename argument is provided
    if (argc < 2) {
        printf("Usage: %s filename [directory]\n", argv[0]);
        return 1;
    }
    char *filename = argv[1];

    // Set default directory if not specified
    char *directory = ".";
    if (argc >= 3) {
        directory = argv[2];
    }

    // Search for file
    char **results = search_file(directory, filename);

    // If no results found, print message
    if (!results) {
        printf("No file(s) in this directory tree matched your query. Make sure that you spelled the query filename correctly."
               " If your query filename contains spaces, you should have your query inside of double-quotes (\")"
               "(e.g. \"Secret notes.txt\"). Note: Query is CASE-SENSITIVE\n");
        return 0;
    }

    // Ask user if they want to continue searching for more of the same file
    char response[1024];
    while (1) {
        printf("Would you like to continue searching for more of the same file? (Y/N) ");
        fgets(response, sizeof(response), stdin);
        if (response[0] == 'Y' || response[0] == 'y') {
            results = search_file(directory, filename);
            if (results == NULL) {
                printf("No more files found.\n");
                return 0;
            }
        }
        else if (response[0] == 'N' || response[0] == 'n') {
            return 0;
        }
        else {
            printf("Invalid response. Please enter 'Y' or 'N'.\n");
        }
    }
}