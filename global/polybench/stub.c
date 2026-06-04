#include <errno.h>
#include <stdlib.h>

// Stub for polybench
int posix_memalign(void **memptr, size_t alignment, size_t size) {
    if (memptr == NULL) {
        return EINVAL;
    }

    // TODO respect alignement ?
    void *ptr = malloc(size);
    if (ptr == NULL) {
        return ENOMEM;
    }

    *memptr = ptr;
    return 0;
}
