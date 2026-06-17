#include <stdio.h>

int real_main(int argc, char **argv)
{
	printf("%s\n", argv[0]);
}

int main()
{
	char *argv = "128bits";
	return real_main(1, &argv);
}
