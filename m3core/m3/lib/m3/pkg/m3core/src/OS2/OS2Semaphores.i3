(* Copyright (C) 1996, Klaus Preschern                       *)
(* All rights reserved.                                      *)
(*                                                           *)
INTERFACE OS2Semaphores;

IMPORT OS2Def;

CONST
  DC_SEM_SHARED =            1;
  DCMW_WAIT_ANY =            2;
  DCMW_WAIT_ALL =            4;

  SEM_INDEFINITE_WAIT  =    -1;
  SEM_IMMEDIATE_RETURN =     0;

TYPE
  HEV  = OS2Def.ULONG;
  PHEV = UNTRACED REF HEV;

  SEMRECORD = RECORD
                hsemCur:  OS2Def.HSEM;
                ulUser:   OS2Def.ULONG;
              END;
  PSEMRECORD = UNTRACED REF SEMRECORD;

<* EXTERNAL DosCloseEventSem *>
PROCEDURE DosCloseEventSem  (hev: HEV): OS2Def.ULONG;
<* EXTERNAL DosCreateEventSem *>
PROCEDURE DosCreateEventSem (pszName : OS2Def.PCSZ;
                             phev    : PHEV;
                             ulAttr  : OS2Def.ULONG;
                             fState  : OS2Def.BOOL32): OS2Def.ULONG;
<* EXTERNAL DosOpenEventSem *>
PROCEDURE DosOpenEventSem  (pszName: OS2Def.PCSZ; phev: PHEV): OS2Def.ULONG;
<* EXTERNAL DosPostEventSem *>
PROCEDURE DosPostEventSem  (hev: HEV): OS2Def.ULONG;
<* EXTERNAL DosQueryEventSem *>
PROCEDURE DosQueryEventSem (hev: HEV; pulCount: OS2Def.PULONG): OS2Def.ULONG;
<* EXTERNAL DosResetEventSem *>
PROCEDURE DosResetEventSem (hev: HEV; pulCount: OS2Def.PULONG): OS2Def.ULONG;
<* EXTERNAL DosWaitEventSem *>
PROCEDURE DosWaitEventSem  (hev: HEV; ulTimeout: OS2Def.ULONG): OS2Def.ULONG;

<* EXTERNAL DosCloseMutexSem *>
PROCEDURE DosCloseMutexSem (hmtx: OS2Def.HMTX): OS2Def.ULONG;
<* EXTERNAL DosCreateMutexSem *>
PROCEDURE DosCreateMutexSem (pszName: OS2Def.PCSZ;
                             phmtx  : OS2Def.PHMTX;
                             ulAttr : OS2Def.ULONG;
                             fState : OS2Def.BOOL32): OS2Def.ULONG;
<* EXTERNAL DosOpenMutexSem *>
PROCEDURE DosOpenMutexSem (pszName  : OS2Def.PCSZ;
                           phmtx    : OS2Def.PHMTX): OS2Def.ULONG;
<* EXTERNAL DosQueryMutexSem *>
PROCEDURE DosQueryMutexSem (hmtx    : OS2Def.HMTX;
                            ppid    : OS2Def.PPID;
                            ptid    : OS2Def.PTID;
                            pulCount: OS2Def.PULONG): OS2Def.ULONG;
<* EXTERNAL DosReleaseMutexSem *>
PROCEDURE DosReleaseMutexSem (hmtx  : OS2Def.HMTX): OS2Def.ULONG;
<* EXTERNAL DosRequestMutexSem *>
PROCEDURE DosRequestMutexSem (hmtx     : OS2Def.HMTX;
                              ulTimeout: OS2Def.ULONG): OS2Def.ULONG;

<* EXTERNAL DosAddMuxWaitSem *>
PROCEDURE DosAddMuxWaitSem (hmux   : OS2Def.HMUX;
                            pSemRec: PSEMRECORD): OS2Def.ULONG;
<* EXTERNAL DosCloseMuxWaitSem *>
PROCEDURE DosCloseMuxWaitSem (hmux : OS2Def.HMUX): OS2Def.ULONG;
<* EXTERNAL DosCreateMuxWaitSem *>
PROCEDURE DosCreateMuxWaitSem (pszName  : OS2Def.PCSZ;
                               phmux    : OS2Def.PHMUX;
                               ulcSemRec: OS2Def.ULONG;
                               pSemRec  : PSEMRECORD;
                               ulAttr   : OS2Def.ULONG): OS2Def.ULONG;
<* EXTERNAL DosDeleteMuxWaitSem *>
PROCEDURE DosDeleteMuxWaitSem (hmux     : OS2Def.HMUX;
                               hSem     : OS2Def.HSEM): OS2Def.ULONG;
<* EXTERNAL DosOpenMuxWaitSem *>
PROCEDURE DosOpenMuxWaitSem (pszName    : OS2Def.PCSZ;
                             phmux      : OS2Def.PHMUX): OS2Def.ULONG;
<* EXTERNAL DosQueryMuxWaitSem *>
PROCEDURE DosQueryMuxWaitSem (hmux      : OS2Def.HMUX;
                              pulcSemRec: OS2Def.PULONG;
                              pSemRec   : PSEMRECORD;
                              pulAttr   : OS2Def.PULONG): OS2Def.ULONG;
<* EXTERNAL DosWaitMuxWaitSem *>
PROCEDURE DosWaitMuxWaitSem (hmux       : OS2Def.HMUX;
                             ulTimeout  : OS2Def.ULONG;
                             pulUser    : OS2Def.PULONG): OS2Def.ULONG;

END OS2Semaphores.
