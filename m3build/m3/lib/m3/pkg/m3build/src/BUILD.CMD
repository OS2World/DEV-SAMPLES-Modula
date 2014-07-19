gcc -c m3env.c
gcc m3build.c m3env.o
gcc m3ship.c  m3env.o
gcc m3where.c m3env.o
gcc m3mkdir.c
