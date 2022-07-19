# 0 "ns16550a.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "ns16550a.c"


# 1 "../include/femto.h" 1


       

# 1 "../include/stdio.h" 1
       





# 1 "../include/stdarg.h" 1
       

typedef __builtin_va_list va_list;
# 8 "../include/stdio.h" 2
# 1 "../include/stddef.h" 1
       

typedef long long int ptrdiff_t;
typedef long long unsigned int size_t;
typedef int wchar_t;
# 9 "../include/stdio.h" 2

int getchar(void);
int printf(const char *, ...);
int putchar(int);
int puts(const char *);
int snprintf(char *, size_t, const char *, ...);
int vprintf(const char *, va_list);
int vsnprintf(char *, size_t, const char *, va_list);
# 6 "../include/femto.h" 2
# 1 "../include/stdint.h" 1
       

typedef signed char int8_t;
typedef short int int16_t;
typedef int int32_t;
typedef long int int64_t;

typedef int int_fast8_t;
typedef int int_fast16_t;
typedef int int_fast32_t;
typedef long int int_fast64_t;

typedef short int int_least16_t;
typedef int int_least32_t;
typedef long int int_least64_t;
typedef signed char int_least8_t;

typedef long long int intmax_t;
typedef long long int intptr_t;

typedef unsigned char uint8_t;
typedef short unsigned int uint16_t;
typedef unsigned int uint32_t;
typedef long unsigned int uint64_t;

typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef long unsigned int uint_fast64_t;

typedef unsigned char uint_least8_t;
typedef short unsigned int uint_least16_t;
typedef unsigned int uint_least32_t;
typedef long unsigned int uint_least64_t;

typedef long long unsigned int uintmax_t;
typedef long long unsigned int uintptr_t;
# 7 "../include/femto.h" 2


# 1 "../include/stdlib.h" 1
       







__attribute__((noreturn)) void abort(void);
__attribute__((noreturn)) void exit(int status);
void* malloc(size_t size);
void free(void* ptr);
void _malloc_addblock(void* addr, size_t size);
# 10 "../include/femto.h" 2
# 1 "../include/stdbits.h" 1
       
# 31 "../include/stdbits.h"
int clz8(int8_t val);
int clz16(int16_t val);
int clz32(int32_t val);
int clz64(int64_t val);

int ctz8(int8_t val);
int ctz16(int16_t val);
int ctz32(int32_t val);
int ctz64(int64_t val);

static inline int ispow2(uintptr_t val)
{
    return val && !(val & (val-1));
}

static inline uintptr_t roundpow2(uintptr_t val)
{
    val--;
    val |= val >> 1;
    val |= val >> 2;
    val |= val >> 4;
    val |= val >> 8;
    val |= val >> 16;



    val++;
    return val;
}
# 11 "../include/femto.h" 2
# 1 "../include/string.h" 1
       







void *memchr(const void *s, int c, size_t n);
int memcmp(const void *, const void *, size_t);
void *memcpy(void *, const void *, size_t);
void *memset(void *, int, size_t);
char *strchr(const char *s, int c);
int strcmp(const char *, const char *);
size_t strlen(const char *);
int strncmp(const char *, const char *, size_t);
char *strncpy(char *, const char *, size_t);
# 12 "../include/femto.h" 2

# 1 "../include/auxval.h" 1


       





enum {
    HART0_CLOCK_FREQ = 0x00010000,
    UART0_CLOCK_FREQ = 0x00011000,
    UART0_BAUD_RATE = 0x00011100,
    NS16550A_UART0_CTRL_ADDR = 0x00030000,
    RISCV_HTIF_BASE_ADDR = 0x00050000,
    SIFIVE_CLINT_CTRL_ADDR = 0x55550000,
    SIFIVE_CLIC_CRTL_ADDR = 0x55550001,
    SIFIVE_TEST_CTRL_ADDR = 0x55550002,
    SIFIVE_UART0_CTRL_ADDR = 0x55550010,
    SIFIVE_GPIO0_CTRL_ADDR = 0x55550020,
    SIFIVE_SPI0_CTRL_ADDR = 0x55550030,
};

typedef struct auxval {
    unsigned long key;
    unsigned long val;
} auxval_t;

extern auxval_t __auxv[];

unsigned long getauxval(unsigned long key);
# 14 "../include/femto.h" 2
# 1 "../include/device.h" 1


       





typedef struct console_device {
    void (*init)();
    int (*getchar)();
    int (*putchar)(int);
} console_device_t;

typedef struct poweroff_device {
    void (*init)();
    void (*poweroff)(int);
} poweroff_device_t;

void register_console(console_device_t *dev);
void register_poweroff(poweroff_device_t *dev);

extern console_device_t *console_dev;
extern poweroff_device_t *poweroff_dev;

extern console_device_t console_none;
extern console_device_t console_htif;
extern console_device_t console_ns16550a;
extern console_device_t console_sifive_uart;
extern console_device_t console_semihost;

extern poweroff_device_t poweroff_none;
extern poweroff_device_t poweroff_htif;
extern poweroff_device_t poweroff_sifive_test;
extern poweroff_device_t poweroff_semihost;
# 15 "../include/femto.h" 2
# 4 "ns16550a.c" 2

enum {
    UART_RBR = 0x00,
    UART_THR = 0x00,
    UART_IER = 0x01,
    UART_DLL = 0x00,
    UART_DLM = 0x01,
    UART_FCR = 0x02,
    UART_LCR = 0x03,
    UART_MCR = 0x04,
    UART_LSR = 0x05,
    UART_MSR = 0x06,
    UART_SCR = 0x07,

    UART_LCR_DLAB = 0x80,
    UART_LCR_8BIT = 0x03,
    UART_LCR_PODD = 0x08,

    UART_LSR_DA = 0x01,
    UART_LSR_OE = 0x02,
    UART_LSR_PE = 0x04,
    UART_LSR_FE = 0x08,
    UART_LSR_BI = 0x10,
    UART_LSR_RE = 0x20,
    UART_LSR_RI = 0x40,
    UART_LSR_EF = 0x80,
};

static volatile uint8_t *uart;

static void ns16550a_init()
{
 uart = (uint8_t *)(void *)getauxval(NS16550A_UART0_CTRL_ADDR);
 uint32_t uart_freq = getauxval(UART0_CLOCK_FREQ);
 uint32_t baud_rate = getauxval(UART0_BAUD_RATE);
    uint32_t divisor = uart_freq / (16 * baud_rate);
    uart[UART_LCR] = UART_LCR_DLAB;
    uart[UART_DLL] = divisor & 0xff;
    uart[UART_DLM] = (divisor >> 8) & 0xff;
    uart[UART_LCR] = UART_LCR_PODD | UART_LCR_8BIT;
}

static int ns16550a_getchar()
{
    if (uart[UART_LSR] & UART_LSR_DA) {
        return uart[UART_RBR];
    } else {
        return -1;
    }
}

static int ns16550a_putchar(int ch)
{
    while ((uart[UART_LSR] & UART_LSR_RI) == 0);
    return uart[UART_THR] = ch & 0xff;
}

console_device_t console_ns16550a = {
    ns16550a_init,
    ns16550a_getchar,
    ns16550a_putchar
};
