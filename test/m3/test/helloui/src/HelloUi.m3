MODULE HelloUi EXPORTS Main;

IMPORT Trestle, TextVBT;

VAR v := TextVBT.New ("Hello Trestle");

<* FATAL ANY *>

BEGIN
  Trestle.Install (v);
  Trestle.AwaitDelete (v);
END HelloUi.
