#include <stdio.h>
#include "admin.h"
#include "staff.h"
#include "customer.h"
#include "guest.h"
#include "utility.h"

void displayMenu();

int main() {
    int choice;
    do {
        displayMenu();
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch(choice) {
            case 1:
                if (login("admin")) adminMenu();
                else printf("Invalid login for Administrator.\n");
                break;
            case 2:
                if (login("staff")) staffMenu();
                else printf("Invalid login for Hotel Staff.\n");
                break;
            case 3:
                if (login("customer")) customerMenu();
                else printf("Invalid login for Customer.\n");
                break;
            case 4:
                guestMenu();
                break;
            case 0:
                printf("Exiting the system...\n");
                break;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 0);

    return 0;
}

void displayMenu() {
    printf("\n--- Hotel Management System ---\n");
    printf("1. Administrator\n");
    printf("2. Hotel Staff\n");
    printf("3. Customer\n");
    printf("4. Guest\n");
    printf("0. Exit\n");
}

