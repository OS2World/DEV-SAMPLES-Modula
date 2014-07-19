/* Copyright (C) 1996, Klaus Preschern                         */
/* All rights reserved.                                        */
/* See the file COPYRIGHT.KP for a full description.           */

#include <stdlib.h>
#include "M3Env.h"

#define M3_ROOT          "M3_ROOT"
#define M3_TARGET        "M3_TARGET"

#define DEFAULT_ROOT     "/m3"
#define QUAKE            "/bin/quake"
#define LIBRARY_DIR      "/lib"
#define PACKAGE_DIR      "/lib/m3/pkg"
#define TEMPLATE_DIR     "/lib/m3/pkg/m3build/templates"
#define TEMPLATE         "OS2unix"
#define PATH_LEN         1024

static char quake        [PATH_LEN] = DEFAULT_ROOT QUAKE;
static char library_dir  [PATH_LEN] = DEFAULT_ROOT LIBRARY_DIR;
static char package_dir  [PATH_LEN] = DEFAULT_ROOT PACKAGE_DIR;
static char template_dir [PATH_LEN] = DEFAULT_ROOT TEMPLATE_DIR;
static char template     [PATH_LEN] = TEMPLATE;
static char build_dir    [PATH_LEN] = TEMPLATE;

static char *GetFromEnv (envname, value, append)
  char * envname;
  char * value;
  char * append;
  {
  char * found;

  found = getenv (envname);
  if (found != NULL)
    {
    strcpy (value, found);
    if (append != NULL)
      {
      strcat (value, append);
      }
    }

  return (value);
  }

static char * GetQuake (void)
  {
  return (GetFromEnv (M3_ROOT, quake, QUAKE));
  }

char * GetPackageDir (void)
  {
  return (GetFromEnv (M3_ROOT, package_dir, PACKAGE_DIR));
  }

char * GetLibraryDir (void)
  {
  return (GetFromEnv (M3_ROOT, library_dir, LIBRARY_DIR));
  }

static char * GetTemplateDir (void)
  {
  return (GetFromEnv (M3_ROOT, template_dir, TEMPLATE_DIR));
  }

static char * GetTemplate (void)
  {
  return (GetFromEnv (M3_TARGET, template, NULL));
  }

static char * GetBuildDir (void)
  {
  return (GetFromEnv (M3_TARGET, build_dir, NULL));
  }

void init_env (quake, template_dir, template, build_dir)
  char ** quake;
  char ** template_dir;
  char ** template;
  char ** build_dir;
  {
  *quake        = GetQuake ();
  *template_dir = GetTemplateDir ();
  *template     = GetTemplate ();
  *build_dir    = GetBuildDir ();
  }

/*
int main ()
  {
  printf ("quake        = %s\n", GetQuake ());
  printf ("template_dir = %s\n", GetTemplateDir ());
  printf ("template     = %s\n", GetTemplate ());
  printf ("build_dir    = %s\n", GetBuildDir ());
  return (0);
  }
*/
