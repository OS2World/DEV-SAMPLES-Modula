(* The example program declares a simple stable "counter" object.
*)
INTERFACE Counter;

TYPE T <: Public;
     Public = OBJECT
     METHODS

       init (newVal : INTEGER := 0) : T;
       initS(newVal : INTEGER);
       initT();

       inc (times : INTEGER := 1) : INTEGER;
       count() : INTEGER;
     END;

(* Here is the "STABLE" pragma that the stub generator needs: *)
     <*PRAGMA STABLE *><*STABLE UPDATE METHODS initS, inc *>

(* "initS" (init stable state) is the only initialization function that
   "stablegen" needs to see.  "init" is used for the unstable version of
   the object, and "initT" (init transient state) does not modify the
   stable state.
*)

(* The "Brand" is a convention used by all generic interfaces, including
   stable objects: *)
CONST Brand = "Counter";

END Counter.
