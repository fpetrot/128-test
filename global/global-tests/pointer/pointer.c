#include <stdio.h>
#include <stdlib.h>


#define UART0 0x10000000L
void print_uart(const char *s) {
    volatile char *uart = (char *)UART0;
    while (*s) {
        *uart = *s++;
    }
}



void extern_print() {
    // 16 letters
    //printf("aaaaaaaaaaaaaaaaa");
    print_uart("aaaaaaaaaaaaaaaaaaa");
}
int main(int argc, char **argv) {
    const size_t nelems = 10;
    const size_t elemsize = 128;
    char **t = malloc(sizeof(char *) * nelems);
    for (size_t i = 0; i < nelems; i++)
    {
        t[i] = malloc(elemsize);
        if (t[i] == NULL) {
            printf("Memory allocation failed for element");
        }
    }

    extern_print();
    extern_print();

    printf("\nbefore");
    
    for (size_t i = 0; i < nelems; i++)
    {
        free(t[i]);
    }
    free(t);
    printf("hello from main!\n");
    return 0;
}