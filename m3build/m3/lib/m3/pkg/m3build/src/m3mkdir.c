/* Copyright (C) 1994, Digital Equipment Corporation           */
/* All rights reserved.                                        */
/* See the file COPYRIGHT for a full description.              */

/* Last modified on Tue Nov 22 14:03:04 PST 1994 by kalsow     */

/*   original shell script written by Bill Kalsow (1993)       */
/*   translated to C by Klaus Preschen (1994)                  */
/*      (Postfach 38, A-9170 Ferlach, Austria)                 */
/*      (e-mail: Preschern@edvz.uni-klagenfurt.ada.at)         */

/*
 * "m3mkdir X/Y/Z"  will build directory X/Y/Z and
 * any missing intermediate directories.
 */

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#ifdef WIN32
#  include <direct.h>
#  define  S_ISDIR(m) ((m & _S_IFMT) == _S_IFDIR)
#endif
#ifdef NeXT
#  define  S_ISDIR(m) ((m & _S_IFMT) == _S_IFDIR)
#endif

#define DEBUG     0

#if DEBUG
#define DPRINTF(args) printf args;
#else
#define DPRINTF(args)
#endif

static char * progname;

static int already_done (path)
  char *path;
  {
    struct stat statbuf;

    if (path == NULL) return 1;
    if (stat (path, &statbuf) < 0) return 0;
    if (S_ISDIR(statbuf.st_mode)) return 1;
    printf ("%s: %s exists and is not a directory\n", progname, path);
    exit (-1);
  }

static char * pathhead (name)
  char *name;
  {
    int i, len;
    char *p, *head, *last_sep = name-1;
    if (name == NULL) return name;
    for (p = name; *p; p++) {
      if (*p == '/') last_sep = p;
    };
    len = last_sep - name;
    if (len <= 0) return NULL;
#ifdef WIN32
    if ((len > 1) && (name[len-1] == ':')) return NULL;
#endif
    head = (char*)malloc (len + 1);
    strncpy (head, name, len);
    head[len] = 0;
    DPRINTF(("pathhead (%s) = %s\n", name, head))
    return head;
  }

static void build (dir)
  char *dir;
  {
    int status;
    if (already_done (dir)) return;
    build (pathhead (dir));
    printf ("mkdir %s\n", dir);
#ifdef WIN32
    status = _mkdir (dir);
#else
    status = mkdir (dir, 0777);
#endif
    if (status != 0) {
      printf ("%s: cannot create %s\n", progname, dir);
      exit(-1);
    }
  }

int main (argc, argv)
  int    argc;
  char **argv;
  {
    progname = argv [0];

    if (argc != 2) {
      printf ("usage: %s directory_path\n", progname);
      exit (-1);
    }
    build (argv [1]);
    return 0;
  }

