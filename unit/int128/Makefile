check : main-native main-emul
	./main-native > 1
	./main-emul > 2
	diff 1 2

main-native : main.c
	$(CC) -DCONFIG_INT128 $< -o $@
main-emul : main.c
	$(CC) -UCONFIG_INT128 $< -o $@
clean:
	$(RM) main-native main-emul 1 2
