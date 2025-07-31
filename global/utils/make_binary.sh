#!/bin/bash

# Chemin vers objcopy (modifiable si nécessaire)
OBJCOPY=riscv128-unknown-elf-objcopy

# Extension cible (par défaut .elf, modifiable)
INPUT_EXT=".x"

# Dossier o� se trouve les binaires
DIR=$HOME/128-test/global/build/bin/global-tests/newlib/

# Dossier de output
OUT=cva6/
mkdir -p $HOME/128-test/global/build/bin/global-tests/$OUT

# Vérifie si objcopy est installé
if ! command -v $OBJCOPY &> /dev/null; then
    echo "Erreur : $OBJCOPY n'est pas installé ou introuvable."
    exit 1
fi

cd $DIR
# Pour chaque fichier .elf dans le répertoire courant
for file in *$INPUT_EXT; do
    # Vérifie que le fichier existe
    [ -e "$file" ] || continue

    # Nom de sortie en remplaçant .elf par .bin
    output="${file%$INPUT_EXT}.bin"

    echo "Conversion de $file vers $output..."
    $OBJCOPY -O binary "$file" "../$OUT/$output"

    if [ $? -ne 0 ]; then
        echo "Échec de la conversion de $file"
    fi
done

echo "Conversion terminée."
