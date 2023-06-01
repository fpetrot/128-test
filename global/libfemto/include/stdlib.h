#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>

extern __attribute__((noreturn)) void abort(void);
extern __attribute__((noreturn)) void exit(int status);
extern void* malloc(size_t size);
extern void *calloc(size_t nmemb, size_t size);
extern void free(void* ptr);
extern void _malloc_addblock(void* addr, size_t size);

#ifdef __cplusplus
}
#endif
