#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "tiny-AES-c/aes.h"

#define N 128

const uint8_t* key = "2b7e151628aed2a6abf7158809cf4f3c";
char *iv = "SomeIVUsedAsInit";

int main()
{
	uint8_t out[N];
	struct AES_ctx ctx;
    AES_init_ctx_iv(&ctx, key, iv);

	uint8_t buf[N] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at massa mattis, auctor sem sit amet, consectetur quam. Etiam mi\0";

	size_t length = strlen(buf) + 1;

	memcpy(out, buf, length);
	
	// printf("content before encryption: %s\n", buf);
	// printf("length: %d\n", length);

	// Tiny AES require a buffer length which is a multiple of 16 bytes.
	assert(length % 16 == 0);

	AES_CBC_encrypt_buffer(&ctx, buf, length);

	// Reinitialize the context
    AES_init_ctx_iv(&ctx, key, iv);

	AES_CBC_decrypt_buffer(&ctx, buf, length);

	// printf("after decryption: %s\n", buf);

	// Assert decrypted is the same as the input
	assert(memcmp(buf, out, length) == 0);
}
