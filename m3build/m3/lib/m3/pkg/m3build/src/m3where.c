/* Copyright (C) 1994, Digital Equipment Corporation           */
/* All rights reserved.                                        */
/* See the file COPYRIGHT for a full description.              */

/* Last modified on Wed Nov 30 13:59:11 PST 1994 by kalsow     */

/*   original shell script written by Bill Kalsow (1993)       */
/*   translated to C by Klaus Preschen (1994)                  */
/*      (Postfach 38, A-9170 Ferlach, Austria)                 */
/*      (e-mail: Preschern@edvz.uni-klagenfurt.ada.at)         */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "M3env.h"
#ifdef WIN32
#  include <process.h>
#  include <direct.h>
#  include <io.h>
#  define  S_ISDIR(m) ((m & _S_IFMT) == _S_IFDIR)
#  define  dircmp(a,b) _stricmp((a),(b))
#else
#  define  dircmp(a,b) strcmp((a),(b))
#endif
#ifdef NeXT
#  define  S_ISDIR(m) ((m & _S_IFMT) == _S_IFDIR)
#  include "../src/tempnam.c"
#  include "../src/getcwd.c"
#endif

#define DEBUG       0
#define PATH_LEN    1024
#define MAX_ARGS    256

typedef struct {
  int   count;
  char *args[MAX_ARGS];
  } ArgList;

#if DEBUG
#define DPRINTF(args) printf args;
#else
#define DPRINTF(args)
#endif

static char *quake         = "h:/m3/bin/quake";
static char *template_dir  = "h:/m3/lib/m3/pkg/m3build/templates";

static char *template      = "OS2unix";
static char *build_dir     = "OS2unix";
static char *start_dir     = ".";
static char *show_hidden   = "";
static char *base;
static char *parent;
static char *package_dir;
static char *package;
static char *query;
static char *unit;

static ArgList units;
static ArgList quake_args;
static ArgList quake_cmd;

static char verbose = 0;
static char quiet   = 0;

static int is_dir (name)
  char *name;
  {
    struct stat statbuf;

    DPRINTF(("is_dir (%s)\n", name))
    if (stat (name, &statbuf) < 0) {
      return 0;
    }
    return S_ISDIR(statbuf.st_mode);
  }

static int readable (name)
  char *name;
  {
    /* we do not check for readability, just for existence */
    struct stat statbuf;
    DPRINTF(("readable (%s)\n", name))
    return (!(stat (name, &statbuf) < 0));
  }

static char * concat (s1, s2)
  char *s1;
  char *s2;
  {
    int   len1 = strlen (s1);
    int   len2 = strlen (s2);
    char *new  = (char*)malloc (len1 + len2 + 1);
    strcpy (new, s1);
    strcat (new, s2);
    DPRINTF (("concat (%s, %s) => %s\n", s1, s2, new))
    return new;
  }

static char * dircat (dir1, dir2)
  char *dir1;
  char *dir2;
  {
    int   len1 = strlen (dir1);
    int   len2 = strlen (dir2);
    char *new  = (char*)malloc (len1 + len2 + 2);
    strcpy (new, dir1);
    strcat (new, "/");
    strcat (new, dir2);
    DPRINTF (("dircat (%s, %s) => %s\n", dir1, dir2, new))
    return new;
  }

static void add_arg (list, arg)
  ArgList *list;
  char *arg;
  {
    if (list->count >= MAX_ARGS) {
      printf("m3where: argument list too long.\n");
      exit (-1);
    }
    list->args[list->count++] = arg;
    list->args[list->count] = 0;
  }

static void print_usage ()
  {
    printf ("usage: m3where [options] [units]\n");
    printf ("  -b <dir>   build with template <dir> in directory <dir> (default='%s')\n", build_dir);
    printf ("  -d <dir>   start in directory <dir> (default='%s')\n", start_dir);
    printf ("  -F <file>  prepend the quake code in <file>\n");
    printf ("  -T <dir>   use templates in directory <dir>\n");
    printf ("               (default='%s')\n", template_dir);
    printf ("  -q         quiet\n");
    printf ("  -v         verbose\n");
    printf ("  -h         show hidden\n");
    printf ("  -help      print this messsage\n");
    printf ("  -version   print version\n");
    printf ("  -<arg>     pass -<arg> to quake\n");
    printf ("  <unit>     call quake with each <unit>\n");
    printf ("\n");
  }

static void parse_command_line (argc, argv)
  int   argc;
  char **argv;
  {
    int i = 1;
    while (i < argc) {
      if (strcmp (argv [i], "-b") == 0) {
        if (i++ >= argc) break;
        build_dir = argv [i];
        template  = argv [i];
      } else if (strcmp (argv [i], "-T") == 0) {
        if (i++ >= argc) break;
        template_dir = argv [i];
      } else if (strcmp (argv [i], "-F") == 0) {
        if (i++ >= argc) break;
        add_arg (&quake_args, argv[i]);
      } else if (strcmp (argv [i], "-d") == 0) {
        if (i++ >= argc) break;
        start_dir = argv [i];
      } else if (strcmp (argv [i], "-q") == 0) {
        quiet = 1;  verbose = 0;
      } else if (strcmp (argv [i], "-v") == 0) {
        quiet = 0;  verbose = 1;
      } else if (strcmp (argv [i], "-h") == 0) {
        show_hidden = "show_hidden";
      } else if (strcmp (argv [i], "-version") == 0) {
        printf ("m3where: SRC Modula-3 version 3.5 (February 1, 1995)\n");
        exit (0);
      } else if (strcmp (argv [i], "-help") == 0) {
        print_usage ();
        exit (0);
      } else if (strcmp (argv [i], "-?") == 0) {
        print_usage ();
        exit (0);
      } else if (argv [i] [0] == '-') {
        add_arg (&quake_args, argv[i]);
      } else { /* units */
        add_arg (&units, argv[i]);
      }
      i++;
    }
    DPRINTF((" --------------------------- \n"))
    for (i = 0; i < argc; i++) {
      DPRINTF((" argv [%d] = %s\n", i, argv [i]))
    }
    DPRINTF((" --------------------------- \n"))
  }

static char * basename (name)
  char *name;
  {
    int i, len;
    char *p, *base, *last_sep = name-1;
    for (p = name; *p; p++) {
      if (*p == '/') last_sep = p;
    };
    last_sep++;
    len = p - last_sep;
    base = (char*)malloc (len + 1);
    strcpy (base, last_sep);
    DPRINTF(("basename (%s) = %s\n", name, base))
    return base;
  }

static char * pathhead (name)
  char *name;
  {
    int i, len;
    char *p, *head, *last_sep = name-1;
    for (p = name; *p; p++) {
      if (*p == '/') last_sep = p;
    };
    len = last_sep - name;
    head = (char*)malloc (len + 1);
    strncpy (head, name, len);
    head[len] = 0;
    DPRINTF(("pathhead (%s) = %s\n", name, head))
    return head;
  }

static void goto_initial_directory ()
  {
    char cur [PATH_LEN];
    chdir (start_dir);
    getcwd (cur, PATH_LEN);
    start_dir = concat (cur, "");
    base = basename (cur);
    parent = pathhead (cur);
    DPRINTF(("start_dir = %s\n", cur))
    DPRINTF(("parent = %s\n", parent))
    DPRINTF(("base = %s\n", base))
  }


static goto_build_dir (dir)
  char *dir;
  {
    if (is_dir (dir)) {
      if (!quiet) printf ("--- searching in %s ---\n", dir);
      chdir (dir);
    } else {
      printf ("m3where: cannot locate build directory %s\n", template);
      exit (-1);
    }
  }

static void goto_dir_with_derived_objects ()
  {
    if (dircmp (base, "src") == 0) {
      package_dir = parent;
      goto_build_dir (dircat ("..", build_dir));
    } else if (dircmp (base, build_dir) == 0) {
      package_dir = parent;
    } else {
      package_dir = start_dir;
      goto_build_dir (build_dir);
    }
    package = basename (package_dir);
    DPRINTF(("package_dir = %s\n", package_dir))
    DPRINTF(("build_dir = %s\n", build_dir))
    DPRINTF(("package = %s\n", package))
  }

static void check_for_exportsfile ()
  {
    char tmp [PATH_LEN];
    if (! readable (".M3EXPORTS")) {
      getcwd (tmp, PATH_LEN);
      printf ("m3where: missing .M3EXPORTS file in %s\n", tmp);
      exit (-1);
    }
  }

static void build_query (argc, argv)
  int    argc;
  char **argv;
  {
    FILE * fd; int i;
    query = tempnam (getenv ("TEMP"), "m3");
    if (query == NULL) {
      printf ("m3where: cannot find temporary file name\n");
      exit (-1);
    };
    if ((fd = fopen (query, "w")) == NULL) {
      printf ("m3where: cannot create %s\n", query);
      exit (-1);
    };
    fprintf (fd, "%% ");
    for (i = 0; i < argc; i++) {
      fprintf (fd, "%s ", argv [i]);
    }
    fprintf (fd, "\n");

    if (units.count == 0) {
      fprintf (fd, "enum_units (\"%s\")\n", show_hidden);
    } else {
      for (i = 0; i < units.count; i++) {
        fprintf (fd, "find_unit (%s, \"%s\")\n", units.args[i], show_hidden);
      }
    }
    fclose (fd);
  }

static void run (cmd)
  char ** cmd;
  {
     int i, status;

     if (verbose) {
       for (i = 0; cmd[i]; i++) {
         if (i) printf (" ");
         printf (cmd[i]);
       };
       printf("\n");
     };

     fflush(stdout);
     fflush(stderr);

#ifdef WIN32
     status = spawnvp (_P_WAIT, cmd[0], cmd);
#else
     if (fork () == 0) {
       /* child */
       if (execvp (cmd[0], cmd) < 0) {
         printf ("m3where: cannot execute %s\n", cmd[0]);
         exit (-1);
       }
     }
     /* parent */
     wait (&status);
#endif

     if (status != 0) {
       printf ("m3where: %s failed (status = %d)\n", cmd[0], status);
       unlink (query);  /* rm -f $query */
       exit (-1);
     };
  }

static build_quake_cmd ()
  {
     int i;

     add_arg (&quake_cmd, quake);
     if (quiet) add_arg (&quake_cmd, "-D_quiet");
     add_arg (&quake_cmd, concat ("-DPACKAGE_DIR=", package_dir));
     add_arg (&quake_cmd, concat ("-DPACKAGE=", package));
     add_arg (&quake_cmd, concat ("-DBUILD_DIR=", build_dir));
     add_arg (&quake_cmd, dircat (template_dir, template));

     for (i = 0; i < quake_args.count; i++ ) {
       add_arg (&quake_cmd, quake_args.args[i]);
     }

     add_arg (&quake_cmd, ".M3EXPORTS");
     add_arg (&quake_cmd, query);
     add_arg (&quake_cmd, dircat (template_dir, "CLEANUP"));
  }

int main (argc, argv, envp)
  int    argc;
  char **argv;
  char **envp;
  {
    init_env (&quake, &template_dir, &template, &build_dir);
    parse_command_line (argc, argv);
    goto_initial_directory ();
    goto_dir_with_derived_objects ();
    check_for_exportsfile ();
    build_query (argc, argv);
    build_quake_cmd ();
    run (quake_cmd.args);
    unlink (query); /* rm -f $query */
    return 0;
  }

