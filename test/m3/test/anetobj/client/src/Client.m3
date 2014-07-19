MODULE Client EXPORTS Main;

IMPORT NetObj, Example, Wr, Stdio, Fmt;

PROCEDURE OutT (t: TEXT) =
  <* FATAL ANY *>
  BEGIN
    Wr.PutText (Stdio.stdout, t);
    Wr.Flush(Stdio.stdout);
  END OutT;

VAR
  ExampleNetObj: Example.T;
  host: TEXT := "localhost";  (* host running netobjd *)
  agent: NetObj.Address;
  answer: TEXT;

BEGIN
  TRY
    agent := NetObj.Locate(host);
    ExampleNetObj := NetObj.Import ("ExampleNetObj", agent);

    IF ExampleNetObj = NIL THEN
      OutT ("Error: a server is not running on \"" & host & "\"\n");
    ELSE
      answer := ExampleNetObj.setText ("Hi, server!");
      OutT ("server returned: " & answer & "\n");
      FOR i := 0 TO 1000 DO
        answer := ExampleNetObj.setText (Fmt.Int (i));
        OutT ("sent: " & Fmt.Int (i) & " returned: " & answer & "\n");
      END (* for *);
      answer := ExampleNetObj.setText ("Good bye.");
      OutT ("Server returned: " & answer & "\n");
      answer := ExampleNetObj.setText (answer);
      OutT ("Server returned: " & answer & "\n");
      ExampleNetObj.sayGoodBye ();
    END (* if *);
  EXCEPT
  | NetObj.Error => OutT ("Netobj.error\n");
  ELSE
    OutT ("An unknown fatal error occurred.")
  END;
END Client.
