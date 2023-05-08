# Dejagnu testsuite

Réalisé par Paul Vernin, Emmanuel Fezeu Youmbi, Wiam Karmouni
Date : 2023

`make test` va lancer la commande `runtest riscv.exp` de Dejagnu. Le script va tester tous les fichiers `*.s` des sous dossiers de testsuite.

`make clean` pour delete les fichiers compilés et les fichiers générés par objdump.