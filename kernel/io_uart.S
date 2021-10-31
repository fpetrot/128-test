#include "insns.S"
#include "multisize_helper.S"
#include "utils_defs.S"

#define UART_BASE                   0x10000000
#define UART_TXFIFO                 0

#define UART_IER                    1
#define UART_IER_ERBFI              (1 << 0)
#define UART_IER_ETBEI              (1 << 1)

#define UART_FCR                    2
#define UART_FCR_FIFO_ENABLE        (1 << 0)
#define UART_FCR_FIFO_RESET_RX      (1 << 1)
#define UART_FCR_FIFO_RESET_TX      (1 << 2)

#define UART_LCR                    3
#define UART_LCR_WLS0               (1 << 0)
#define UART_LCR_WLS1               (1 << 1)
#define UART_LCR_STB                (1 << 2)

#define UART_LSR                    5
#define UART_LSR_DR                 (1 << 0)

.global putchar
putchar:
    andi t0, a0, 0xff
    li t1, UART_BASE
    li t2, UART_TXFIFO
    add t1, t1, t2
    sb t0, 0(t1)

    ret

.global getchar
getchar:
    li t1, UART_BASE
    li t2, UART_LSR
    add t1, t1, t2
.Lwait_for_input:
    lb t0, 0(t1)
    andi t0, t0, UART_LSR_DR
    beqz t0, .Lwait_for_input

    li t1, UART_BASE
    li t2, UART_TXFIFO
    add t1, t1, t2
    lb a0, 0(t1)

    ret

.global setup_console_io
setup_console_io:
    // Set word length to 8-bit.
    li t0, UART_BASE
    li t1, UART_LCR
    add t0, t0, t1

    lbu t1, 0(t0)
    ori t1, t1, UART_LCR_WLS0 | UART_LCR_WLS1
    sb t1, 0(t0)

    // Enable and reset FIFO
    li t0, UART_BASE
    li t1, UART_FCR
    add t0, t0, t1

    li t1, UART_FCR_FIFO_ENABLE | UART_FCR_FIFO_RESET_RX | UART_FCR_FIFO_RESET_TX

    sb t1, 0(t0)

    // Enable receive interrupts
    /*li t0, UART_BASE
    li t1, UART_IER
    add t0, t0, t1

    li t1, UART_IER_ERBFI
    sb t1, 0(t0)*/

    ret