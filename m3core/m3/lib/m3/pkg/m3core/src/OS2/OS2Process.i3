(*--------------------------------------------------------------------------*)
(* Copyright (C) 1997, Klaus Preschern                                      *)
(* All rights reserved.                                                     *)
(* See the file COPYRIGHT.KP for a full description.                        *)
(*--------------------------------------------------------------------------*)
INTERFACE OS2Process;

FROM OS2Def IMPORT ULONG, USHORT, LONG, PCHAR, TID, PTID, PID, PPID, PVOID,
                   PCSZ, PULONG, UCHAR;

CONST
 EXIT_THREAD  = 0;
 EXIT_PROCESS = 1;

<*EXTERNAL DosBeep*>
PROCEDURE DosBeep (ulFrequency: ULONG; ulDuration: ULONG): ULONG;
<*EXTERNAL DosExit*>
PROCEDURE DosExit (ulAction: ULONG; ulResult: ULONG);

CONST
  CREATE_READY           = 0;
  CREATE_SUSPENDED       = 1;

  STACK_SPARSE           = 0;
  STACK_COMMITTED        = 2;

  DCWA_PROCESS           = 0;
  DCWA_PROCESSTREE       = 1;

  DCWW_WAIT              = 0;
  DCWW_NOWAIT            = 1;

  DKP_PROCESSTREE        = 0;
  DKP_PROCESS            = 1;

  EXEC_SYNC              = 0;
  EXEC_ASYNC             = 1;
  EXEC_ASYNCRESULT       = 2;
  EXEC_TRACE             = 3;
  EXEC_BACKGROUND        = 4;
  EXEC_LOAD              = 5;
  EXEC_ASYNCRESULTDB     = 6;

  EXLST_ADD              = 1;
  EXLST_REMOVE           = 2;
  EXLST_EXIT             = 3;

  PRTYC_NOCHANGE         = 0;
  PRTYC_IDLETIME         = 1;
  PRTYC_REGULAR          = 2;
  PRTYC_TIMECRITICAL     = 3;
  PRTYC_FOREGROUNDSERVER = 4;

  PRTYD_MINIMUM          = (-31);
  PRTYD_MAXIMUM          = 31;

  PRTYS_PROCESS          = 0;
  PRTYS_PROCESSTREE      = 1;
  PRTYS_THREAD           = 2;

  TC_EXIT                = 0;
  TC_HARDERROR           = 1;
  TC_TRAP                = 2;
  TC_KILLPROCESS         = 3;
  TC_EXCEPTION           = 4;

TYPE
  PRESULTCODES = UNTRACED REF RESULTCODES;
  RESULTCODES = RECORD
    codeTerminate  : ULONG;
    codeResult     : ULONG;
  END;

  PTIB2 = UNTRACED REF TIB2;
  TIB2 = RECORD
    tib2_ultid: ULONG;
    tib2_ulpri: ULONG;
    tib2_version: ULONG;
    tib2_usMCCount: USHORT;
    tib2_fMCForceFlag: USHORT;
  END;

  PTIB = UNTRACED REF TIB;
  TIB = RECORD
    tib_pexchain: PVOID;
    tib_pstack: PVOID;
    tib_pstacklimit: PVOID;
    tib_ptib2: PTIB2;
    tib_version: ULONG;
    tib_ordinal: ULONG;
  END;

  PPIB = UNTRACED REF PIB;
  PIB = RECORD
    pib_ulpid: ULONG;
    pib_ulppid: ULONG;
    pib_hmte: ULONG;
    pib_pchcmd: PCHAR;
    pib_pchenv: PCHAR;
    pib_flstatus: ULONG;
    pib_ultype: ULONG;
  END;

PFNTHREAD   = PROCEDURE (ulThreadArg: ULONG);
PFNEXITLIST = PROCEDURE (ulArg: ULONG);


<* EXTERNAL DosAllocThreadLocalMemory *>
PROCEDURE DosAllocThreadLocalMemory (cb: ULONG; p: UNTRACED REF PULONG): ULONG;

<* EXTERNAL DosCreateThread *>
PROCEDURE DosCreateThread (ptidThreadID: PTID; pfnThreadAddr: PFNTHREAD;
    ulThreadArg: ULONG; ulFlags: ULONG; ulStackSize: ULONG): ULONG;

<* EXTERNAL DosEnterCritSec *>
PROCEDURE DosEnterCritSec (): ULONG;

<* EXTERNAL DosExecPgm *>
PROCEDURE DosExecPgm (pObjname: PCHAR; lObjnameLength: LONG; ulFlagS: ULONG;
    pszArg: PCSZ; pszEnv: PCSZ; pReturnCodes: PRESULTCODES; pszName: PCSZ): ULONG;

<* EXTERNAL DosExitCritSec *>
PROCEDURE DosExitCritSec (): ULONG;

<* EXTERNAL DosExitList *>
PROCEDURE DosExitList (ulOrder: ULONG; pfn: PFNEXITLIST): ULONG;

<* EXTERNAL DosFreeThreadLocalMemory *>
PROCEDURE DosFreeThreadLocalMemory (p: PULONG): ULONG;

<* EXTERNAL DosGetInfoBlocks *>
PROCEDURE DosGetInfoBlocks (ptib: UNTRACED REF PTIB; ppib: UNTRACED REF PPIB): ULONG;

<* EXTERNAL DosKillProcess *>
PROCEDURE DosKillProcess (ulAction: ULONG; pid: PID): ULONG;

<* EXTERNAL DosKillThread *>
PROCEDURE DosKillThread (tid: TID): ULONG;

<* EXTERNAL DosResumeThread *>
PROCEDURE DosResumeThread (tid: TID): ULONG;

<* EXTERNAL DosSetPriority *>
PROCEDURE DosSetPriority (ulScope: ULONG; ulClass: ULONG; lDelta: LONG; ulID: ULONG): ULONG;

<* EXTERNAL DosSleep *>
PROCEDURE DosSleep (ulInterval: ULONG): ULONG;

<* EXTERNAL DosSuspendThread *>
PROCEDURE DosSuspendThread (tid: TID): ULONG;

<* EXTERNAL DosVerifyPidTid *>
PROCEDURE DosVerifyPidTid (pid: PID; tid: TID): ULONG;

<* EXTERNAL DosWaitChild *>
PROCEDURE DosWaitChild (ulAction: ULONG; ulWait: ULONG; pReturnCodes: PRESULTCODES;
    ppidOut: PPID; pidIn: PID): ULONG;

<* EXTERNAL DosWaitThread *>
PROCEDURE DosWaitThread (ptid: PTID; ulWait: ULONG): ULONG;

(*--------------------------------------------------------------------------*)
(* DEBUGGING SUPPORT                                                        *)
(*--------------------------------------------------------------------------*)

CONST
  DBG_C_Null                    = 0;
  DBG_C_ReadMem                 = 1;
  DBG_C_ReadMem_I               = 1;
  DBG_C_ReadMem_D               = 2;
  DBG_C_ReadReg                 = 3;
  DBG_C_WriteMem                = 4;
  DBG_C_WriteMem_I              = 4;
  DBG_C_WriteMem_D              = 5;
  DBG_C_WriteReg                = 6;
  DBG_C_Go                      = 7;
  DBG_C_Term                    = 8;
  DBG_C_SStep                   = 9;
  DBG_C_Stop                    = 10;
  DBG_C_Freeze                  = 11;
  DBG_C_Resume                  = 12;
  DBG_C_NumToAddr               = 13;
  DBG_C_ReadCoRegs              = 14;
  DBG_C_WriteCoRegs             = 15;
  DBG_C_ThrdStat                = 17;
  DBG_C_MapROAlias              = 18;
  DBG_C_MapRWAlias              = 19;
  DBG_C_UnMapAlias              = 20;
  DBG_C_Connect                 = 21;
  DBG_C_ReadMemBuf              = 22;
  DBG_C_WriteMemBuf             = 23;
  DBG_C_SetWatch                = 24;
  DBG_C_ClearWatch              = 25;
  DBG_C_RangeStep               = 26;
  DBG_C_Continue                = 27;
  DBG_C_AddrToObject            = 28;
  DBG_C_XchngOpcode             = 29;
  DBG_C_LinToSel                = 30;
  DBG_C_SelToLin                = 31;

  DBG_N_Success                 = 0;
  DBG_N_Error                   = (-1);
  DBG_N_ProcTerm                = (-6);
  DBG_N_Exception               = (-7);
  DBG_N_ModuleLoad              = (-8);
  DBG_N_CoError                 = (-9);
  DBG_N_ThreadTerm              = (-10);
  DBG_N_AsyncStop               = (-11);
  DBG_N_NewProc                 = (-12);
  DBG_N_AliasFree               = (-13);
  DBG_N_Watchpoint              = (-14);
  DBG_N_ThreadCreate            = (-15);
  DBG_N_ModuleFree              = (-16);
  DBG_N_RangeStep               = (-17);

  DBG_D_Thawed                  = 0;
  DBG_D_Frozen                  = 1;

  DBG_T_Runnable                = 0;
  DBG_T_Suspended               = 1;
  DBG_T_Blocked                 = 2;
  DBG_T_CritSec                 = 3;

  DBG_L_386                     = 1;

  DBG_LEN_387                   = 108;

  DBG_CO_387                    = 1;

  DBG_O_OBJMTE                  = 16_10000000;

  DBG_W_Global                  = 16_00000001;
  DBG_W_Local                   = 16_00000002;
  DBG_W_Execute                 = 16_00010000;
  DBG_W_Write                   = 16_00020000;
  DBG_W_ReadWrite               = 16_00030000;

  DBG_X_PRE_FIRST_CHANCE        = 16_00000000;
  DBG_X_FIRST_CHANCE            = 16_00000001;
  DBG_X_LAST_CHANCE             = 16_00000002;
  DBG_X_STACK_INVALID           = 16_00000003;

TYPE
  TStat_t = RECORD
    DbgState:  UCHAR;
    TState:    UCHAR;
    TPriority: USHORT;
  END (* record *);

  uDB_t = RECORD
    Pid:    ULONG;
    Tid:    ULONG;
    Cmd:    LONG;
    Value:  LONG;
    Addr:   ULONG;
    Buffer: ULONG;
    Len:    ULONG;
    Index:  ULONG;
    MTE:    ULONG;
    EAX:    ULONG;
    ECX:    ULONG;
    EDX:    ULONG;
    EBX:    ULONG;
    ESP:    ULONG;
    EBP:    ULONG;
    ESI:    ULONG;
    EDI:    ULONG;
    EFlags: ULONG;
    EIP:    ULONG;
    CSLim:  ULONG;
    CSBase: ULONG;
    CSAcc:  UCHAR;
    CSAtr:  UCHAR;
    CS:     USHORT;
    DSLim:  ULONG;
    DSBase: ULONG;
    DSAcc:  UCHAR;
    DSAtr:  UCHAR;
    DS:     USHORT;
    ESLim:  ULONG;
    ESBase: ULONG;
    ESAcc:  UCHAR;
    ESAtr:  UCHAR;
    ES:     USHORT;
    FSLim:  ULONG;
    FSBase: ULONG;
    FSAcc:  UCHAR;
    FSAtr:  UCHAR;
    FS:     USHORT;
    GSLim:  ULONG;
    GSBase: ULONG;
    GSAcc:  UCHAR;
    GSAtr:  UCHAR;
    GS:     USHORT;
    SSLim:  ULONG;
    SSBase: ULONG;
    SSAcc:  UCHAR;
    SSAtr:  UCHAR;
    SS:     USHORT;
  END (* record *);

<* EXTERNAL DosDebug *>
PROCEDURE DosDebug (pDebugBuffer: UNTRACED REF uDB_t): ULONG;

END OS2Process.
