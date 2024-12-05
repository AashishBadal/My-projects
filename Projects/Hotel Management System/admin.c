#include <stdio.h>
#include <string.h>
#include "admin.h"
#include "utility.h"

void adminMenu();
void manageRooms();
void addRoom();
void updateRoom();
void deleteRoom();
void registerUser();
void viewAvailableRooms();

void adminMenu() {
    int choice;
    do {
        printf("\n--- Administrator Menu ---\n");
        printf("1. Manage Rooms\n");
        printf("2. Register New User\n");
        printf("3. Manage Existing Users\n");
        printf("0. Logout\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                manageRooms();
                break;
            case 2:
                registerUser();
                break;
            case 3:
                updateUserStatus(); // Call the new function
                break;
            case 0:
                printf("Logging out...\n");
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 0);
}


void manageRooms() {
    int choice;
    do {
        printf("\n--- Manage Rooms Menu ---\n");
        printf("1. Add New Room\n");
        printf("2. Update Existing Room\n");
        printf("3. Delete Room\n");
        printf("4. View Available Rooms\n");
        printf("0. Return to Admin Menu\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                addRoom();
                break;
            case 2:
                updateRoom();
                break;
            case 3:
                deleteRoom();
                break;
                case 4:
                viewAvailableRooms(); // Call the new function
                break;
            case 0:
                printf("Returning to Admin Menu...\n");
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 0);
}

void addRoom() {
    char roomNumber[10], roomType[20];
    int price;
    FILE *file = fopen("rooms.txt", "a");

    if (!file) {
        printf("Error: Unable to open rooms file.\n");
        return;
    }

    printf("Enter room number: ");
    scanf("%s", roomNumber);

    // Check if the room already exists
    if (isRoomAvailable(roomNumber)) {
        printf("Error: Room already exists.\n");
        fclose(file);
        return;
    }

    printf("Enter room type: ");
    scanf("%s", roomType);
    printf("Enter price per night: ");
    scanf("%d", &price);

    // Write the new room data into the file
    fprintf(file, "%-12s %-15s %-15d\n", roomNumber, roomType, price);
    fclose(file);

    printf("Room added successfully.\n");
}



void updateRoom() {
    char roomNumber[10], newRoomType[20], buffer[256];
    int newPrice, found = 0;

    printf("Enter the room number to update: ");
    scanf("%s", roomNumber);

    FILE *file = fopen("rooms.txt", "r");
    if (!file) {
        printf("Error: Unable to open rooms file.\n");
        return;
    }

    char tempFile[] = "temp.txt";
    FILE *temp = fopen(tempFile, "w");

    while (fgets(buffer, sizeof(buffer), file)) {
        char existingRoomNumber[10], existingRoomType[20];
        int existingPrice;

        sscanf(buffer, "%s %s %d", existingRoomNumber, existingRoomType, &existingPrice);

        if (strcmp(existingRoomNumber, roomNumber) == 0) {
            found = 1;
            printf("Enter new room type: ");
            scanf("%s", newRoomType);
            printf("Enter new price per night: ");
            scanf("%d", &newPrice);

            fprintf(temp, "%s %s %d\n", roomNumber, newRoomType, newPrice);
        } else {
            fprintf(temp, "%s", buffer);
        }
    }

    fclose(file);
    fclose(temp);

    if (found) {
        remove("rooms.txt");
        rename(tempFile, "rooms.txt");
        printf("Room updated successfully.\n");
    } else {
        remove(tempFile);
        printf("Error: Room not found.\n");
    }
}

void deleteRoom() {
    char roomNumber[10], buffer[256];
    int found = 0;

    printf("Enter the room number to delete: ");
    scanf("%s", roomNumber);

    // Open the file in read mode
    FILE *file = fopen("rooms.txt", "r");
    if (!file) {
        printf("Error: Unable to open rooms file.\n");
        return;
    }

    // Create a temporary file to store updated data
    FILE *temp = fopen("temp_rooms.txt", "w");
    if (!temp) {
        printf("Error: Unable to create temporary file.\n");
        fclose(file);
        return;
    }

    // Skip the header and separator lines
    fgets(buffer, sizeof(buffer), file);
    fprintf(temp, "%s", buffer); // Write header to temp file
    fgets(buffer, sizeof(buffer), file);
    fprintf(temp, "%s", buffer); // Write separator to temp file

    // Process the remaining lines
    while (fgets(buffer, sizeof(buffer), file)) {
        char fileRoomNumber[10];
        sscanf(buffer, "%s", fileRoomNumber);

        if (strcmp(fileRoomNumber, roomNumber) == 0) {
            found = 1; // Room to delete found, skip writing to temp file
        } else {
            fprintf(temp, "%s", buffer); // Write unchanged room data
        }
    }

    fclose(file);
    fclose(temp);

    if (found) {
        // Replace the old file with the updated file
        remove("rooms.txt");
        rename("temp_rooms.txt", "rooms.txt");
        printf("Room deleted successfully.\n");
    } else {
        // Remove the temporary file if no changes
        remove("temp_rooms.txt");
        printf("Error: Room number not found.\n");
    }
}



void registerUser() {
    char username[50], password[50], role[20];
    char fullName[100], address[150], citizenship[20];
    FILE *file = fopen("users.txt", "a");

    if (!file) {
        printf("Error: Unable to open users file.\n");
        return;
    }

    printf("\n--- Register New User ---\n");
    printf("Enter username: ");
    scanf("%s", username);

    if (isUserExist(username)) {
        printf("Error: Username already exists.\n");
        fclose(file);
        return;
    }

    printf("Enter password: ");
    scanf("%s", password);
    printf("Enter role (staff/customer): ");
    scanf("%s", role);

    // Collect additional details
    printf("Enter full name: ");
    getchar(); // Consume the leftover newline character from the previous input
    fgets(fullName, sizeof(fullName), stdin);
    fullName[strcspn(fullName, "\n")] = '\0'; // Remove trailing newline

    printf("Enter address: ");
    fgets(address, sizeof(address), stdin);
    address[strcspn(address, "\n")] = '\0'; // Remove trailing newline

    printf("Enter citizenship number: ");
    scanf("%s", citizenship);

    // Save data to the file in aligned format
    fprintf(file, "%-15s %-15s %-10s %-20s %-30s %-15s\n",
            username, password, role, fullName, address, citizenship);
    fclose(file);

    printf("User registered successfully.\n");
}


void updateUserStatus() {
    char username[50], buffer[256];
    int found = 0;

    printf("\n--- Manage Existing Users ---\n");
    printf("Enter the username to manage: ");
    scanf("%s", username);

    FILE *file = fopen("users.txt", "r");
    if (!file) {
        printf("Error: Unable to open users file.\n");
        return;
    }

    char tempFile[] = "temp_users.txt";
    FILE *temp = fopen(tempFile, "w");

    if (!temp) {
        printf("Error: Unable to create temporary file.\n");
        fclose(file);
        return;
    }

    while (fgets(buffer, sizeof(buffer), file)) {
        char fileUser[50], filePass[50], fileRole[20];
        sscanf(buffer, "%s %s %s", fileUser, filePass, fileRole);

        if (strcmp(fileUser, username) == 0) {
            found = 1;

            printf("\n--- Current User Details ---\n");
            printf("Username: %s\n", fileUser);
            printf("Password: %s\n", filePass);
            printf("Role: %s\n", fileRole);

            // Display sub-menu for managing the user
            int choice;
            printf("\nWhat would you like to do?\n");
            printf("1. Update User Data\n");
            printf("2. Delete User\n");
            printf("0. Cancel\n");
            printf("Enter your choice: ");
            scanf("%d", &choice);

            switch (choice) {
                case 1: {
                    // Update user details
                    char newPassword[50], newRole[20];
                    printf("Enter new password: ");
                    scanf("%s", newPassword);
                    printf("Enter new role (staff/customer/admin): ");
                    scanf("%s", newRole);

                    fprintf(temp, "%s %s %s\n", fileUser, newPassword, newRole);
                    printf("User updated successfully.\n");
                    break;
                }
                case 2:
                    // Delete user (do not write this user to the temp file)
                    printf("User deleted successfully.\n");
                    break;
                case 0:
                    // Cancel operation and retain original data
                    fprintf(temp, "%s", buffer);
                    printf("Operation canceled. No changes made.\n");
                    break;
                default:
                    printf("Invalid choice! Retaining original user data.\n");
                    fprintf(temp, "%s", buffer);
                    break;
            }
        } else {
            fprintf(temp, "%s", buffer); // Write unaffected users to temp file
        }
    }

    fclose(file);
    fclose(temp);

    if (found) {
        remove("users.txt");
        rename(tempFile, "users.txt");
    } else {
        remove(tempFile);
        printf("Error: Username not found.\n");
    }
}
void viewAvailableRooms() {
    FILE *file = fopen("rooms.txt", "r");
    char buffer[256];

    if (!file) {
        printf("Error: Unable to open rooms file.\n");
        return;
    }

    printf("\n--- Available Rooms ---\n");
    printf("-----------------------------------------\n");

    while (fgets(buffer, sizeof(buffer), file)) {
        char roomNumber[10], roomType[20];
        int price;

        sscanf(buffer, "%s %s %d", roomNumber, roomType, &price);
        printf("%-12s %-15s %-15d\n", roomNumber, roomType, price);
    }

    fclose(file);
}
