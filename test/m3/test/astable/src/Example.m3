MODULE Example EXPORTS Main;

IMPORT Wr, Stdio, Fmt, StableCounter, Pathname, StableError, Params;

<*FATAL ANY*>

PROCEDURE Main() =
  VAR
    stablePath : Pathname.T;
    recovered : BOOLEAN;
    myCounter : StableCounter.T;
  BEGIN
    (* Get the pathname or emit a usage error: *)
    IF (Params.Count = 2) THEN
      stablePath := Params.Get(1) (* one command-line argument: the path *)
    ELSE
      Wr.PutText(Stdio.stdout, "usage: example <path of stable storage>\n");
      RETURN;
    END;

    TRY

(* Initialize the stable storage: *)
      myCounter := NEW(StableCounter.T).init(stablePath, recovered);

(* Only initialize the stable state if it is not recovered from the given path: *)
      IF (recovered) THEN
        Wr.PutText(Stdio.stdout,
                   "recovered counter from " & stablePath &
                   " with value " & Fmt.Int (myCounter.count()) & "\n");
      ELSE
        myCounter.initS(0);
        Wr.PutText(Stdio.stdout, "brand new counter\n");
      END (* if *);

(* Always initialize the transient state.  This initialization is
   performed after recovering or initializing the stable state,
   because the transient state might depend on the stable state. *)
      myCounter.initT();

      EVAL myCounter.inc ();              (* increment the counter *)
      Wr.PutText (Stdio.stdout, "Counter value is now: " &
        Fmt.Int (myCounter.count ()) & "\n");
    EXCEPT
      StableError.E => Wr.PutText(Stdio.stderr, "stable storage error\n");
    END;
  END Main;

BEGIN
  Main();
END Example.
