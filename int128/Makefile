check : main-native main-emul
	./main-native > 1
	./main-emul > 2
	diff 1 2

main-native : main.c int128.h int128.c
	$(CC) -DCONFIG_INT128 $< -o $@
main-emul : main.c int128.h int128.c
	$(CC) -UCONFIG_INT128 $< -o $@
clean:
	$(RM) main-native main-emul 1 2
