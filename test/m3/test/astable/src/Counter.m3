MODULE Counter;

IMPORT Wr, Stdio, Fmt;

REVEAL T = Public BRANDED OBJECT

(* stable state *)
  counterVal  : INTEGER;

(* transient state - just to have something *)
  oldVal  : INTEGER := 0;

(* The entire implementation of this object is in this module. *)
  OVERRIDES
    init   := Init;
    initS  := InitStable;
    initT  := InitTransient;
    inc    := Inc;
    count  := Count;
  END;

(* "Init" is used to initialize the unstable version of the object.
   It circumvents the stubs from "stablegen" and calls "InitStable"
   and "InitTransient" separately.  The procedure calls "InitStable"
   before calling "InitTransient", because (in general) the transient
   state might depend on the stable state but not vice versa.
*)

PROCEDURE OutT (t: TEXT) =
<* FATAL ANY *>
  BEGIN
    Wr.PutText (Stdio.stdout, t);
    Wr.Flush (Stdio.stdout);
  END OutT;

PROCEDURE Init(self : T; newVal : INTEGER := 0) : T =
  BEGIN
    InitStable(self, newVal);
    InitTransient(self);
    RETURN self;
  END Init;

(* "InitStable" initializes the stable state variables.
*)
PROCEDURE InitStable(self : T; newVal : INTEGER) =
  BEGIN
    self.counterVal  := newVal;
    OutT ("InitStable: " & Fmt.Int (self.counterVal) & "\n");
  END InitStable;

(* "InitTransient" always sets old value to zero. *)
PROCEDURE InitTransient(self : T) =
  BEGIN
    self.oldVal := 0;
  END InitTransient;

PROCEDURE Inc (self : T; times : INTEGER := 1) : INTEGER =
  BEGIN
    self.oldVal := self.counterVal;
    INC (self.counterVal, times);
    OutT ("Inc: " &
      Fmt.Int (self.oldVal)     & " + " &
      Fmt.Int (times)           & " = " &
      Fmt.Int (self.counterVal) & "\n");
    RETURN (self.counterVal);
  END Inc;

(* "Count" returns the current counter. *)
PROCEDURE Count(self : T) : INTEGER =
  BEGIN
    RETURN self.counterVal;
  END Count;

BEGIN
END Counter.
