#include <stdio.h>
#include "guest.h"
#include<string.h>

void viewRoomAvailability();
void searchRoomDetails();

void guestMenu() {
    int choice;
    do {
        printf("\n--- Guest Menu ---\n");
        printf("1. View Room Availability\n");
        printf("2. Search Room Details and Rates\n");
        printf("0. Exit Guest Menu\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                viewRoomAvailability();
                break;
            case 2:
                searchRoomDetails();
                break;
            case 0:
                printf("Exiting Guest Menu...\n");
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 0);
}

void viewRoomAvailability() {
    char roomNumber[10], roomType[20];
    int price;
    char buffer[256];

    FILE *file = fopen("rooms.txt", "r");
    if (!file) {
        printf("Error: Unable to open rooms file.\n");
        return;
    }

    printf("\n--- Available Rooms ---\n");
    printf("Room Number  Room Type       Price Per Night\n");
    printf("--------------------------------------------\n");

    // Skip the header lines if the file has them
    fgets(buffer, sizeof(buffer), file); // Skip first header line
    fgets(buffer, sizeof(buffer), file); // Skip separator line

    // Read and display room details
    while (fscanf(file, "%s %s %d", roomNumber, roomType, &price) != EOF) {
        printf("%-12s %-15s %-15d\n", roomNumber, roomType, price);
    }

    fclose(file);
}

void searchRoomDetails() {
    char searchRoomNumber[10];
    char fileRoomNumber[10], roomType[20];
    int price;
    int found = 0; // To track if the room is found

    printf("Enter room number to search: ");
    scanf("%s", searchRoomNumber);

    FILE *file = fopen("rooms.txt", "r");
    if (!file) {
        printf("Error: Unable to open rooms file.\n");
        return;
    }

    // Skip the header line if the file has a formatted structure
    char buffer[256];
    fgets(buffer, sizeof(buffer), file); // Skip header line
    fgets(buffer, sizeof(buffer), file); // Skip separator line

    // Search for the room in the file
    while (fscanf(file, "%s %s %d", fileRoomNumber, roomType, &price) != EOF) {
        if (strcmp(searchRoomNumber, fileRoomNumber) == 0) {
            printf("\n--- Room Details ---\n");
            printf("Room Number: %s\n", fileRoomNumber);
            printf("Room Type: %s\n", roomType);
            printf("Price Per Night: $%d\n", price);
            found = 1;
            break;
        }
    }

    fclose(file);

    if (!found) {
        printf("Room number %s not found.\n", searchRoomNumber);
    }
}

