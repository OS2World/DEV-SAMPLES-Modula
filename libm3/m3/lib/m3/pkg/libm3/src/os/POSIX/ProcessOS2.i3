(*--------------------------------------------------------------------------*)
(* Copyright (C) 1997, Klaus Preschern                                      *)
(* All rights reserved.                                                     *)
(* See the file COPYRIGHT.KP for a full description.                        *)
(*--------------------------------------------------------------------------*)
INTERFACE ProcessOS2;

IMPORT OS2Def, OSError, Pathname, Process, File, OS2Process;

(****************************************************************************)
(*      PROCEDURE DECLARATIONS                                              *)
(****************************************************************************)

PROCEDURE Execute
  (
  cmd:                  Pathname.T;
  READONLY params:      ARRAY OF TEXT;
  env:                  REF ARRAY OF TEXT := NIL;
  wd:                   Pathname.T := NIL;
  flags:                OS2Def.ULONG := OS2Process.EXEC_ASYNCRESULT;
  stdin,
  stdout,
  stderr:               File.T := NIL
  ):                    Process.T RAISES {OSError.E};

END ProcessOS2.
