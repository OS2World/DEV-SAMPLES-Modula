(* Copyright (C) 1994, Digital Equipment Corporation *)
(* All rights reserved.                              *)
(* See the file COPYRIGHT for a full description.    *)

(* This interface exports the configuration information
   used by m3build and quake.  These constants were defined
   when Modula-3 was installed. *)

INTERFACE M3Config;

CONST  (* misc. configuration *)
  TARGET    = "OS2unix";
  OS_TYPE   = "POSIX";
  WORD_SIZE = "32BITS";
  BUILD_DIR = "OS2unix";
  PATH_SEP  = "/";
  M3        = "h:/m3/lib/m3/OS2unix/m3.exe"; (* the compiler *)

CONST (* installation directories *)
  BIN_INSTALL   = "h:/m3/bin";
  LIB_INSTALL   = "h:/m3/lib/m3/OS2unix";
  DOC_INSTALL   = "h:/m3/lib/m3/doc";
  PKG_INSTALL   = "h:/m3/lib/m3/pkg";
  MAN_INSTALL   = "h:/m3/man";
  EMACS_INSTALL = "h:/m3/lib/elisp";
  HTML_INSTALL  = "h:/m3/lib/m3/www";

(* On some systems (e.g. AFS) you must install public files
   in a different place from where you use them.  The paths
   below specify where to find the installed files. *)

CONST
  BIN_USE   = "h:/m3/bin";
  LIB_USE   = "h:/m3/lib/m3/OS2unix";
  DOC_USE   = "h:/m3/lib/m3/doc";
  PKG_USE   = "h:/m3/lib/m3/pkg";
  MAN_USE   = "h:/m3/man";
  EMACS_USE = "h:/m3/lib/elisp";
  HTML_USE  = "h:/m3/lib/m3/www";

END M3Config.
