MODULE Server EXPORTS Main;

IMPORT Example, NetObj, IO, Atom, Scheduler;

TYPE
  ExampleNetObjImpl = Example.T OBJECT
    lastMsg: TEXT := NIL;
    goodBye: BOOLEAN := FALSE;
  OVERRIDES
    setText := SetText;
    sayGoodBye := SayGoodBye;
  END;

PROCEDURE SetText (self: ExampleNetObjImpl; text: TEXT): TEXT
    RAISES {Example.Reject} =
  VAR answer: TEXT;
  BEGIN
    LOCK mu DO
      answer := self.lastMsg;
      IF text # NIL THEN
        self.lastMsg := text;
        RETURN answer;
      ELSE
        RAISE Example.Reject ("illegal text");
      END;
    END;
  END SetText;

PROCEDURE SayGoodBye (self: ExampleNetObjImpl) =
  BEGIN
    self.goodBye := TRUE;
  END SayGoodBye;

VAR
  myExampleNetObj := NEW (ExampleNetObjImpl, lastMsg := "No last message");
  mu := NEW(MUTEX);

BEGIN
  TRY
    NetObj.Export ("ExampleNetObj", myExampleNetObj);
    IO.Put ("Server is running - now start the client ...\n");
    WHILE (NOT myExampleNetObj.goodBye) DO
      Scheduler.Yield ();
    END (* while *);
    NetObj.Export ("ExampleNetObj", NIL);   (* remove object *)
    myExampleNetObj := NIL;
    IO.Put ("Server terminated\n");
  EXCEPT
  | NetObj.Error (atom) =>
      WHILE atom # NIL DO
        IO.Put ("***Error> " & Atom.ToText (atom.head) & "\n");
        atom := atom.tail;
      END;
  ELSE
    IO.Put ("an unknown exception occured\n");
  END;
END Server.
