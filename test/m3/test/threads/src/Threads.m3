MODULE Threads EXPORTS Main;

IMPORT Wr, Stdio, Thread, Fmt, Text;
<* FATAL Wr.Failure, Thread.Alerted *>

CONST LIMIT = 100;
      THREADS = 7;

TYPE MyClosure = Thread.Closure OBJECT
		   n: INTEGER;
		 OVERRIDES
		   apply := ThreadProc;
		 END (* object *);
		 
VAR threads: ARRAY [1..THREADS] OF Thread.T;

PROCEDURE ThreadProc (self: MyClosure): REFANY =
  VAR t: TEXT := "";
  BEGIN
    FOR j := 1 TO self.n DO
      t := Text.Cat (t, "         ");
    END (* for *);
    t := Text.Cat (t, "Thread " & Fmt.Int (self.n) & "\n");
    FOR i := 1 TO LIMIT DO
      Wr.PutText (Stdio.stdout, t);
      Wr.Flush (Stdio.stdout);
    END (* for *);
    RETURN NIL;
  END ThreadProc;

BEGIN
  Wr.PutText (Stdio.stdout, "Start Threads\n");
  Wr.Flush (Stdio.stdout);
  FOR i := 1 TO THREADS DO
    threads [i] := Thread.Fork (NEW (MyClosure, n := i));
  END (* for *);
  FOR i := 1 TO LIMIT DO
    Wr.PutText (Stdio.stdout, "Thread 0\n");
    Wr.Flush (Stdio.stdout);
  END (* for *);
  FOR i := 1 TO THREADS DO
    EVAL Thread.Join (threads [i]);
  END (* for *);
  Wr.PutText (Stdio.stdout, "End Threads\n");
  Wr.Flush (Stdio.stdout);
END Threads.
