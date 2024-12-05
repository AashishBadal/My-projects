#include <stdio.h>
#include <string.h>
#include "staff.h"
#include "utility.h"

void checkInGuest();
void checkOutGuest();
void viewBookings();
void viewRoomAvailability();

void staffMenu() {
    int choice;
    do {
        printf("\n--- Hotel Staff Menu ---\n");
        printf("1. View Bookings\n");
        printf("2. Check-in Guest\n");
        printf("3. Check-out Guest\n");
        printf("4.View Room Aviability\n");
        printf("0. Logout\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                viewBookings();
                break;
            case 2:
                checkInGuest();
                break;
            case 3:
                checkOutGuest();
                break;
            case 4:
            	viewRoomAvailability();
            	break;
            case 0:
                printf("Logging out...\n");
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 0);
}

void viewBookings() {
    char buffer[256];
    FILE *file = fopen("bookings.txt", "r");
    if (!file) {
        printf("No bookings found.\n");
        return;
    }

    printf("\n--- Booking History ---\n");
    while (fgets(buffer, sizeof(buffer), file)) {
        printf("%s", buffer);
    }
    fclose(file);
}

void checkInGuest() {
    char roomNumber[10];
    printf("Enter room number for check-in: ");
    scanf("%s", roomNumber);

    FILE *file = fopen("bookings.txt", "r+");
    if (!file) {
        printf("No bookings found.\n");
        return;
    }

    char buffer[256], tempFile[] = "temp.txt";
    FILE *temp = fopen(tempFile, "w");
    int found = 0;

    while (fgets(buffer, sizeof(buffer), file)) {
        if (strstr(buffer, roomNumber) && strstr(buffer, "Pending")) {
            found = 1;
            fprintf(temp, "%s", strtok(buffer, "\n"));
            fprintf(temp, " | Checked-in\n");
        } else {
            fprintf(temp, "%s", buffer);
        }
    }

    fclose(file);
    fclose(temp);

    remove("bookings.txt");
    rename(tempFile, "bookings.txt");

    if (found) {
        printf("Guest successfully checked in.\n");
    } else {
        printf("No matching booking found for check-in.\n");
    }
}

void checkOutGuest() {
    char roomNumber[10];
    printf("Enter room number for check-out: ");
    scanf("%s", roomNumber);

    FILE *file = fopen("bookings.txt", "r+");
    if (!file) {
        printf("No bookings found.\n");
        return;
    }

    char buffer[256], tempFile[] = "temp.txt";
    FILE *temp = fopen(tempFile, "w");
    int found = 0;

    while (fgets(buffer, sizeof(buffer), file)) {
        if (strstr(buffer, roomNumber) && strstr(buffer, "Checked-in")) {
            found = 1;
            fprintf(temp, "%s", strtok(buffer, "\n"));
            fprintf(temp, " | Checked-out\n");
        } else {
            fprintf(temp, "%s", buffer);
        }
    }

    fclose(file);
    fclose(temp);

    remove("bookings.txt");
    rename(tempFile, "bookings.txt");

    if (found) {
        printf("Guest successfully checked out.\n");
    } else {
        printf("No matching booking found for check-out.\n");
    }
}

