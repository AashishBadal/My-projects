#include <stdio.h>
#include <string.h>
#include "utility.h"

// Function to handle login based on username, password, and role
int login(const char *role) {
    char username[50], password[50];
    char fileUser[50], filePass[50], fileRole[20], fullName[100], address[150], citizenship[20];
    FILE *file = fopen("users.txt", "r");

    if (!file) {
        printf("Error: Users file not found.\n");
        return 0;
    }

    // Prompt user for login credentials
    printf("Enter username: ");
    scanf("%s", username);
    printf("Enter password: ");
    scanf("%s", password);

    // Skip the header lines in the file
    char buffer[256];
    fgets(buffer, sizeof(buffer), file); // Skip header row
    fgets(buffer, sizeof(buffer), file); // Skip separator row

    // Read each user entry in the file
    while (fscanf(file, "%15s %15s %10s %20[^\n] %30[^\n] %15s",
                  fileUser, filePass, fileRole, fullName, address, citizenship) != EOF) {
        // Check for a match on username, password, and role
        if (strcmp(username, fileUser) == 0 && strcmp(password, filePass) == 0 && strcmp(role, fileRole) == 0) {
            fclose(file);
            return 1; // Login successful
        }
    }

    fclose(file);
    return 0; // Login failed
}




int isRoomAvailable(const char *roomNumber) {
    char buffer[256];
    char fileRoom[10], roomType[20];
    int price;
    FILE *file = fopen("rooms.txt", "r");

    if (!file) {
        printf("Error: Unable to open rooms file.\n");
        return 0; // Return false if file can't be opened
    }

    // Skip the header line if necessary
    fgets(buffer, sizeof(buffer), file);  // Skip the first header line
    fgets(buffer, sizeof(buffer), file);  // Skip separator line

    // Check if the room number exists
    while (fscanf(file, "%s %s %d", fileRoom, roomType, &price) != EOF) {
        if (strcmp(roomNumber, fileRoom) == 0) {
            fclose(file);
            return 1; // Room number already exists
        }
    }

    fclose(file);
    return 0; // Room number doesn't exist
}



int isUserExist(const char *username) {
    char fileUser[50], filePass[50], role[20];
    FILE *file = fopen("users.txt", "r");
    if (!file) return 0;

    while (fscanf(file, "%s %s %s", fileUser, filePass, role) != EOF) {
        if (strcmp(username, fileUser) == 0) {
            fclose(file);
            return 1;
        }
    }
    fclose(file);
    return 0;
}

