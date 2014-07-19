
MODULE Hello EXPORTS Main;

IMPORT Wr, Stdio, Thread;
<* FATAL Wr.Failure, Thread.Alerted *>
BEGIN
  Wr.PutText (Stdio.stdout, "Hello OS/2 world - this is M3 !\n");
END Hello.


