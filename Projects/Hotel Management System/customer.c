#include <stdio.h>
#include <string.h>
#include "customer.h"
#include "utility.h"

void searchRooms();
void bookRoom();
void cancelBooking();
void viewReservationHistory();

void customerMenu() {
    int choice;
    do {
        printf("\n--- Customer Menu ---\n");
        printf("1. Search Rooms\n");
        printf("2. Book Room\n");
        printf("3. Cancel Booking\n");
        printf("4. View Reservation History\n");
        printf("0. Logout\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                searchRooms();
                break;
            case 2:
                bookRoom();
                break;
            case 3:
                cancelBooking();
                break;
            case 4:
                viewReservationHistory();
                break;
            case 0:
                printf("Logging out...\n");
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 0);
}

void searchRooms() {
    char buffer[256];
    FILE *file = fopen("rooms.txt", "r");
    if (!file) {
        printf("No rooms available.\n");
        return;
    }

    printf("\n--- Available Rooms ---\n");
    while (fgets(buffer, sizeof(buffer), file)) {
        printf("%s", buffer);
    }
    fclose(file);
}

void bookRoom() {
    char customerName[50], roomNumber[10], bookingStatus[20], bookingDate[20];
    FILE *file = fopen("bookings.txt", "a");

    if (!file) {
        printf("Error: Unable to open bookings file.\n");
        return;
    }

    printf("Enter customer name: ");
    scanf("%s", customerName);
    printf("Enter room number: ");
    scanf("%s", roomNumber);
    printf("Enter booking status (Pending/Checked-in/Checked-out): ");
    scanf("%s", bookingStatus);
    printf("Enter booking date (YYYY-MM-DD): ");
    scanf("%s", bookingDate);

    // Write booking details in formatted way
    fprintf(file, "%-15s %-12s %-12s %-15s\n", customerName, roomNumber, bookingStatus, bookingDate);
    fclose(file);

    printf("Booking added successfully.\n");
}

void cancelBooking() {
    char roomNumber[10], tempFile[] = "temp.txt", buffer[256];
    printf("Enter room number to cancel booking: ");
    scanf("%s", roomNumber);

    FILE *file = fopen("bookings.txt", "r");
    FILE *temp = fopen(tempFile, "w");
    int found = 0;

    if (!file || !temp) {
        printf("Error: Unable to access bookings.\n");
        return;
    }

    while (fgets(buffer, sizeof(buffer), file)) {
        if (strstr(buffer, roomNumber) && strstr(buffer, "Pending")) {
            found = 1;
            continue;
        }
        fprintf(temp, "%s", buffer);
    }

    fclose(file);
    fclose(temp);

    remove("bookings.txt");
    rename(tempFile, "bookings.txt");

    if (found) {
        printf("Booking successfully canceled.\n");
    } else {
        printf("No matching booking found to cancel.\n");
    }
}

void viewReservationHistory() {
    char customerName[50], buffer[256];
    printf("Enter your name to view reservation history: ");
    scanf("%s", customerName);

    FILE *file = fopen("bookings.txt", "r");
    if (!file) {
        printf("No reservation history found.\n");
        return;
    }

    printf("\n--- Reservation History ---\n");
    while (fgets(buffer, sizeof(buffer), file)) {
        if (strstr(buffer, customerName)) {
            printf("%s", buffer);
        }
    }
    fclose(file);
}

