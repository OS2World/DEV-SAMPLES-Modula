(* Copyright (C) 1990, Digital Equipment Corporation.         *)
(* All rights reserved.                                       *)
(* See the file COPYRIGHT for a full description.             *)

(* Last modified on Fri Feb 24 14:53:26 PST 1995 by kalsow            *)
(*      modified on Tue Feb 14 20:02:55 GMT 1995 by rrw1000@cam.ac.uk *)
(*      modified on Thu Jul 21 00:00:00 1994 by sims@usa.acsys.com    *)
(*      modified on Thu Nov 22 05:20:45 1990 by muller                *)

(* constant values taken from /emx/include/sys/errno.h by klausp@ping.at *)

INTERFACE Uerror;

FROM Ctypes IMPORT int, char_star;

(*** <errno.h> ***)

CONST
  EPERM           = 1;   (* Operation not permitted              *)
  ENOENT          = 2;   (* No such file or directory            *)
  ESRCH           = 3;   (* No such process                      *)
  EINTR           = 4;   (* Interrupted system call              *)
  EIO             = 5;   (* I/O error                            *)
  ENXIO           = 6;   (* No such device or address            *)
  E2BIG           = 7;   (* Arguments or environment too big     *)
  ENOEXEC         = 8;   (* Invalid executable file format       *)
  EBADF           = 9;   (* Bad file number                      *)
  ECHILD          = 10;  (* No child processes                   *)
  EAGAIN          = 11;  (* Resource temporarily unavailable     *)
  ENOMEM          = 12;  (* Not enough memory                    *)
  EACCES          = 13;  (* Permission denied                    *)
  EFAULT          = 14;  (* Bad address                          *)
  ENOLCK          = 15;  (* No locks available                   *)
  EBUSY           = 16;  (* Resource busy                        *)
  EEXIST          = 17;  (* File exists                          *)
  EXDEV           = 18;  (* Cross-device link                    *)
  ENODEV          = 19;  (* No such device                       *)
  ENOTDIR         = 20;  (* Not a directory                      *)
  EISDIR          = 21;  (* Is a directory                       *)
  EINVAL          = 22;  (* Invalid argument                     *)
  ENFILE          = 23;  (* Too many open files in system        *)
  EMFILE          = 24;  (* Too many open files                  *)
  ENOTTY          = 25;  (* Inappropriate ioctl                  *)
  EDEADLK         = 26;  (* Resource deadlock avoided            *)
  EFBIG           = 27;  (* File too large                       *)
  ENOSPC          = 28;  (* Disk full                            *)
  ESPIPE          = 29;  (* Invalid seek                         *)
  EROFS           = 30;  (* Read-only file system                *)
  EMLINK          = 31;  (* Too many links                       *)
  EPIPE           = 32;  (* Broken pipe                          *)
  EDOM            = 33;  (* Domain error                         *)
  ERANGE          = 34;  (* Result too large                     *)
  ENOTEMPTY       = 35;  (* Directory not empty                  *)
  EINPROGRESS     = 36;  (* Operation now in progress            *)
  ENOSYS          = 37;  (* Function not implemented             *)
  ENAMETOOLONG    = 38;  (* File name too long                   *)
  EDESTADDRREQ    = 39;  (* Destination address required         *)
  EMSGSIZE        = 40;  (* Message too long                     *)
  EPROTOTYPE      = 41;  (* Protocol wrong type for socket       *)
  ENOPROTOOPT     = 42;  (* Option not supported by protocol     *)
  EPROTONOSUPPORT = 43;  (* Protocol not supported               *)
  ESOCKTNOSUPPORT = 44;  (* Socket type not supported            *)
  EOPNOTSUPP      = 45;  (* Operation not supported on socket    *)
  EPFNOSUPPORT    = 46;  (* Protocol family not supported        *)
  EAFNOSUPPORT    = 47;  (* Address family not supported by protocol family *)
  EADDRINUSE      = 48;  (* Address already in use               *)
  EADDRNOTAVAIL   = 49;  (* Can't assigned requested address     *)
  ENETDOWN        = 50;  (* Network is down                      *)
  ENETUNREACH     = 51;  (* Network is unreachable               *)
  ENETRESET       = 52;  (* Network dropped connection on reset  *)
  ECONNABORTED    = 53;  (* Software caused connection abort     *)
  ECONNRESET      = 54;  (* Connection reset by peer             *)
  ENOBUFS         = 55;  (* No buffer space available            *)
  EISCONN         = 56;  (* Socket is already connected          *)
  ENOTCONN        = 57;  (* Socket is not connected              *)
  ESHUTDOWN       = 58;  (* Can't send after socket shutdown     *)
  ETOOMANYREFS    = 59;  (* Too many references: can't splice    *)
  ETIMEDOUT       = 60;  (* Connection timed out                 *)
  ECONNREFUSED    = 61;  (* Connection refused                   *)
  ELOOP           = 62;  (* Too many levels of symbolic links    *)
  ENOTSOCK        = 63;  (* Socket operation on non-socket       *)
  EHOSTDOWN       = 64;  (* Host is down                         *)
  EHOSTUNREACH    = 65;  (* No route to host                     *)
  EALREADY        = 66;  (* Operation already in progress        *)

  EWOULDBLOCK     = EAGAIN;

<*EXTERNAL*>
VAR
  errno: int;

(* Extension by mjordan *)
CONST
  Max = EALREADY; (* should be exported from Uerror *)

<*EXTERNAL*>
VAR
  sys_nerr: int;
  sys_errlist: ARRAY [0..Max] OF char_star;

PROCEDURE GetFrom_sys_errlist(n: INTEGER): char_star RAISES {};
(* returns entry 'n' of the 'sys_errlist' array; a checked runtime error
   unless 0 <= n <= sys_nerr. Its safer and more portable to use this
   procedure than to access the array directly.
*)

END Uerror.
