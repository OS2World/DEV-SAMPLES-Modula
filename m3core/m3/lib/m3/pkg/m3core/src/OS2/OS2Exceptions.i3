(* Copyright (C) 1995, Klaus Preschern                       *)
(* All rights reserved.                                      *)
(*                                                           *)
INTERFACE OS2Exceptions;

FROM OS2Def IMPORT ULONG, PULONG, USHORT, PVOID, BOOL32, PID, TID;
IMPORT Word;

CONST
  CONTEXT_CONTROL        =         16_0001;
  CONTEXT_INTEGER        =         16_0002;
  CONTEXT_SEGMENTS       =         16_0004;
  CONTEXT_FLOATING_POINT =         16_0008;
  CONTEXT_FULL           =         Word.Or (CONTEXT_CONTROL,
                                     Word.Or (CONTEXT_INTEGER,
                                       Word.Or (CONTEXT_SEGMENTS,
                                                CONTEXT_FLOATING_POINT)));

  EH_NONCONTINUABLE      =        16_0001;
  EH_UNWINDING           =        16_0002;
  EH_EXIT_UNWIND         =        16_0004;
  EH_STACK_INVALID       =        16_0008;
  EH_NESTED_CALL         =        16_0010;

  SIG_UNSETFOCUS         =        0;
  SIG_SETFOCUS           =        1;

  UNWIND_ALL             =        0;

  XCPT_CONTINUE_SEARCH    =       16_00000000;
  XCPT_CONTINUE_EXECUTION =       16_ffffffff;
  XCPT_CONTINUE_STOP      =       16_00716668;

  XCPT_SIGNAL_INTR        =       1;
  XCPT_SIGNAL_KILLPROC    =       3;
  XCPT_SIGNAL_BREAK       =       4;

  XCPT_FATAL_EXCEPTION    =       16_c0000000;
  XCPT_SEVERITY_CODE      =       16_c0000000;
  XCPT_CUSTOMER_CODE      =       16_20000000;
  XCPT_FACILITY_CODE      =       16_1fff0000;
  XCPT_EXCEPTION_CODE     =       16_0000ffff;

  XCPT_UNKNOWN_ACCESS     =       16_00000000;
  XCPT_READ_ACCESS        =       16_00000001;
  XCPT_WRITE_ACCESS       =       16_00000002;
  XCPT_EXECUTE_ACCESS     =       16_00000004;
  XCPT_SPACE_ACCESS       =       16_00000008;
  XCPT_LIMIT_ACCESS       =       16_00000010;
  XCPT_DATA_UNKNOWN       =       16_ffffffff;

  XCPT_GUARD_PAGE_VIOLATION       = 16_80000001;
  XCPT_UNABLE_TO_GROW_STACK       = 16_80010001;
  XCPT_ACCESS_VIOLATION           = 16_c0000005;
  XCPT_IN_PAGE_ERROR              = 16_c0000006;
  XCPT_ILLEGAL_INSTRUCTION        = 16_c000001c;
  XCPT_INVALID_LOCK_SEQUENCE      = 16_c000001d;
  XCPT_NONCONTINUABLE_EXCEPTION   = 16_c0000024;
  XCPT_INVALID_DISPOSITION        = 16_c0000025;
  XCPT_UNWIND                     = 16_c0000026;
  XCPT_BAD_STACK                  = 16_c0000027;
  XCPT_INVALID_UNWIND_TARGET      = 16_c0000028;
  XCPT_ARRAY_BOUNDS_EXCEEDED      = 16_c0000093;
  XCPT_FLOAT_DENORMAL_OPERAND     = 16_c0000094;
  XCPT_FLOAT_DIVIDE_BY_ZERO       = 16_c0000095;
  XCPT_FLOAT_INEXACT_RESULT       = 16_c0000096;
  XCPT_FLOAT_INVALID_OPERATION    = 16_c0000097;
  XCPT_FLOAT_OVERFLOW             = 16_c0000098;
  XCPT_FLOAT_STACK_CHECK          = 16_c0000099;
  XCPT_FLOAT_UNDERFLOW            = 16_c000009a;
  XCPT_INTEGER_DIVIDE_BY_ZERO     = 16_c000009b;
  XCPT_INTEGER_OVERFLOW           = 16_c000009c;
  XCPT_PRIVILEGED_INSTRUCTION     = 16_c000009d;
  XCPT_DATATYPE_MISALIGNMENT      = 16_c000009e;
  XCPT_BREAKPOINT                 = 16_c000009f;
  XCPT_SINGLE_STEP                = 16_c00000a0;
  XCPT_PROCESS_TERMINATE          = 16_c0010001;
  XCPT_ASYNC_PROCESS_TERMINATE    = 16_c0010002;
  XCPT_SIGNAL                     = 16_c0010003;

TYPE
  FPREG = RECORD
            losig: ULONG;
            hisig: ULONG;
            signexp: USHORT;
          END (* record *);
  PFPREG = UNTRACED REF FPREG;

  CONTEXTRECORD = RECORD
                    ContextFlags: ULONG;
                    ctx_env:      ARRAY [0..5] OF ULONG;
                    ctx_stack:    ARRAY [0..6] OF FPREG;
                    ctx_SegGs:    ULONG;
                    ctx_SegFs:    ULONG;
                    ctx_SegEs:    ULONG;
                    ctx_SegDs:    ULONG;
                    ctx_RegEdi:   ULONG;
                    ctx_RegEsi:   ULONG;
                    ctx_RegEax:   ULONG;
                    ctx_RegEbx:   ULONG;
                    ctx_RegEcx:   ULONG;
                    ctx_RegEdx:   ULONG;
                    ctx_RegEbp:   ULONG;
                    ctx_RegEip:   ULONG;
                    ctx_SegCs:    ULONG;
                    ctx_EFlags:   ULONG;
                    ctx_RegEsp:   ULONG;
                    ctx_SegSs:    ULONG;
                  END (* record *);
  PCONTEXTRECORD = UNTRACED REF CONTEXTRECORD;

CONST
  EXCEPTION_MAXIMUM_PARAMETERS = 4;

TYPE
  EXCEPTIONREPORTRECORD = RECORD
                            ExceptionNum: ULONG;
                            fHandlerFlags: ULONG;
                            NestedExceptionReportRecord: PEXCEPTIONREPORTRECORD;
                            ExceptionAddress: PVOID;
                            cParameters: ULONG;
                            ExceptionInfo:
                              ARRAY [0..EXCEPTION_MAXIMUM_PARAMETERS - 1] OF ULONG;
                          END (* record *);
  PEXCEPTIONREPORTRECORD = UNTRACED REF EXCEPTIONREPORTRECORD;

  ERR = PROCEDURE (pReport:       PEXCEPTIONREPORTRECORD;
                   pRegistration: PEXCEPTIONREGISTRATIONRECORD;
                   pContext:      PCONTEXTRECORD;
                   pWhatever:     PVOID): ULONG;

  EXCEPTIONREGISTRATIONRECORD = RECORD
                                  prev_structure: PEXCEPTIONREGISTRATIONRECORD;
                                  ExceptionHandler: ERR;
                                END (* record *);
  PEXCEPTIONREGISTRATIONRECORD = UNTRACED REF EXCEPTIONREGISTRATIONRECORD;

CONST
  END_OF_CHAIN =           (-1);

<* EXTERNAL DosAcknowledgeSignalException *>
PROCEDURE DosAcknowledgeSignalException (ulSignal: ULONG): ULONG;

<* EXTERNAL DosEnterMustComplete *>
PROCEDURE DosEnterMustComplete (pulNesting: PULONG): ULONG;

<* EXTERNAL DosExitMustComplete *>
PROCEDURE DosExitMustComplete (pulNesting: PULONG): ULONG;

<* EXTERNAL DosQueryThreadContext *>
PROCEDURE DosQueryThreadContext (tid: TID;
                                 ulLevel: ULONG;
                                 pContext: PCONTEXTRECORD): ULONG;

<* EXTERNAL DosRaiseException *>
PROCEDURE DosRaiseException (pXRepRec: PEXCEPTIONREPORTRECORD): ULONG;

<* EXTERNAL DosSendSignalException *>
PROCEDURE DosSendSignalException (pid: PID; ulSignal: ULONG): ULONG;

<* EXTERNAL DosSetExceptionHandler *>
PROCEDURE DosSetExceptionHandler (pXRegRec: PEXCEPTIONREGISTRATIONRECORD): ULONG;

<* EXTERNAL DosSetSignalExceptionFocus *>
PROCEDURE DosSetSignalExceptionFocus (flag: BOOL32;  pulTimes: PULONG): ULONG;

<* EXTERNAL DosUnsetExceptionHandler *>
PROCEDURE DosUnsetExceptionHandler (pXRegRec: PEXCEPTIONREGISTRATIONRECORD): ULONG;

<* EXTERNAL DosUnwindException *>
PROCEDURE DosUnwindException (pXRegRec: PEXCEPTIONREGISTRATIONRECORD;
                              pJumpThere: PVOID;
                              pXRepRec: PEXCEPTIONREPORTRECORD): ULONG;

END OS2Exceptions.
