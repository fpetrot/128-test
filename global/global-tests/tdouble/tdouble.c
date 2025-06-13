#include <stdio.h>

#define UART_BASE 0x10000000L
#define UART_THR (volatile char *)(UART_BASE)

void putchar_uart(char c) {
    *UART_THR = c;
}

void print_uart(const char *s) {
    while (*s) {
        putchar_uart(*s++);
    }
}

// Converts an integer to string
void itoa(int value, char *buffer) {
    char temp[16];
    int i = 0;
    int is_negative = 0;

    if (value == 0) {
        buffer[0] = '0';
        buffer[1] = '\0';
        return;
    }

    if (value < 0) {
        is_negative = 1;
        value = -value;
    }

    while (value != 0) {
        temp[i++] = (value % 10) + '0';
        value /= 10;
    }

    if (is_negative) {
        temp[i++] = '-';
    }

    int j = 0;
    while (i--) {
        buffer[j++] = temp[i];
    }
    buffer[j] = '\0';
}

// Print float with fixed 3-digit precision
void print_uart_float(float f) {
    char buffer[32];

    // Handle negative
    if (f < 0) {
        putchar_uart('-');
        f = -f;
    }

    int int_part = (int)f;
    float fractional = f - (float)int_part;
    int frac_part = (int)(fractional * 1000);  // 3 digits

    itoa(int_part, buffer);
    print_uart(buffer);
    putchar_uart('.');
    
    // Handle leading zeros in fractional part
    if (frac_part < 100) putchar_uart('0');
    if (frac_part < 10) putchar_uart('0');

    itoa(frac_part, buffer);
    print_uart(buffer);
}

int main() {
    double value = 3.14159645465165165;
    printf("The value of double is: %lf\n", value);

    double* floatPtr = &value;
    printf("The value of float pointer is: %f\n", *floatPtr);

    *floatPtr *= 2.7182865161681968;
    printf("The updated value of double is: %f\n", value);

    print_uart_float(value);
    return 0;
}