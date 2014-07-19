MODULE VSplit EXPORTS Main;

IMPORT Trestle, TextVBT, BorderedVBT, HVSplit, Axis, HVBar;

<* FATAL ANY *>

VAR v :=
  BorderedVBT.New (
    HVSplit.Cons (Axis.T.Ver,
      BorderedVBT.New (TextVBT.New ("Top")),
      HVBar.New (size := 3.0),
      BorderedVBT.New (TextVBT.New ("Bottom"))),
    size := 3.0);

BEGIN
  Trestle.Install (v);
  Trestle.AwaitDelete (v);
END VSplit.
