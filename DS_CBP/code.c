#include <stdio.h>
#include <stdlib.h>
typedef struct Song {
    char title[100];
    struct Song* prev;
    struct Song* next;
} Song;

int main() {
    Song* head = NULL;
    Song* current = NULL;
    int choice;
    char title[100];

    while (1) {
        printf("\n--- Music Playlist Manager ---\n");
        printf("1. Add Song\n2. Remove Song\n3. Play Next\n4. Play Previous\n5. Display Playlist\n6. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);
        getchar(); // to consume newline after number input

        switch (choice) {
            case 1:
                printf("Enter song title: ");
                fgets(title, 100, stdin);
                title[strcspn(title, "\n")] = 0; // remove newline
                addSong(&head, title);
                if (current == NULL) current = head;
                break;
            case 2:
                printf("Enter song title to remove: ");
                fgets(title, 100, stdin);
                title[strcspn(title, "\n")] = 0;
                removeSong(&head, title);
                break;
            case 3:
                playNext(&current);
                break;
            case 4:
                playPrev(&current);
                break;
            case 5:
                displayPlaylist(head);
                break;
            case 6:
                printf("👋 Exiting... Goodbye!\n");
                return 0;
            default:
                printf("❗ Invalid choice!\n");
        }
    }
}
void addSong(Song** head, char title[]) {
    Song* newSong = (Song*)malloc(sizeof(Song));
    strcpy(newSong->title, title);
    newSong->next = NULL;
    newSong->prev = NULL;

    if (*head == NULL) {
        *head = newSong;
        return;
    }

    Song* temp = *head;
    while (temp->next != NULL)
        temp = temp->next;

    temp->next = newSong;
    newSong->prev = temp;
}
void displayPlaylist(Song* head) {
    Song* temp = head;
    printf("\n🎶 Current Playlist:\n");
    while (temp != NULL) {
        printf("🎵 %s\n", temp->title);
        temp = temp->next;
    }
}
void playNext(Song** current) {
    if (*current && (*current)->next) {
        *current = (*current)->next;
        printf("▶️ Now playing: %s\n", (*current)->title);
    } else {
        printf("⚠️ No next song.\n");
    }
}

void playPrev(Song** current) {
    if (*current && (*current)->prev) {
        *current = (*current)->prev;
        printf("▶️ Now playing: %s\n", (*current)->title);
    } else {
        printf("⚠️ No previous song.\n");
    }
}
void removeSong(Song** head, char title[]) {
    Song* temp = *head;

    while (temp != NULL && strcmp(temp->title, title) != 0)
        temp = temp->next;

    if (temp == NULL) {
        printf("❌ Song not found!\n");
        return;
    }

    if (temp->prev)
        temp->prev->next = temp->next;
    else
        *head = temp->next;

    if (temp->next)
        temp->next->prev = temp->prev;

    free(temp);
    printf("✅ Song '%s' removed from playlist.\n", title);
}