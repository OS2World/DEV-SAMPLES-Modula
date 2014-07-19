/* Copyright (C) 1996, Klaus Preschern                         */
/* All rights reserved.                                        */
/* See the file COPYRIGHT.KP for a full description.           */
#ifndef _M3ENV_H_
#define _M3ENV_H_

void init_env (char **quake,
               char **template_dir,
               char **template,
               char **build_dir);

char * GetLibraryDir (void);
char * GetPackageDir (void);

#endif
