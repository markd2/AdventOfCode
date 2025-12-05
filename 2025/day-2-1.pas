(* NEEDING TO DO 64-BIT, or use STR$ add-one-to-string because
some ranges are like 9797966713-9797988709 *)

PROGRAM AOC_DAY_2_1 (INFILE, OUTPUT);


TYPE
    STR255 = STRING(255);
    INTSIZE = INTEGER;

VAR
    INFILE: TEXT;
    { LINE: STR255; }

    RANGE_LOW: INTEGER;
    RANGE_HIGH: INTEGER;
    COMMA_NOM: CHAR;

    SCAN: INTSIZE;
    INVALID_SUM: INTSIZE;

FUNCTION IS_VALID_ID(ID: INTSIZE) : BOOLEAN;
VAR
    S: VARYING [20] OF CHAR;
    HALF: INTSIZE;
    LEN: INTSIZE;
    LEFT: STRING(20);
    RIGHT: STRING(20);

BEGIN
    IF ID < 10 THEN BEGIN
        IS_VALID_ID := TRUE;
        RETURN;
    END;

    WRITEV(S, ID: 0);
    LEN := LENGTH(S);
    HALF := TRUNC(LEN / 2);
 WRITELN(ID, " half ", HALF);
    LEFT := S[1 .. HALF];
WRITELN("  blah");
    RIGHT := S[HALF + 1 .. LEN];
WRITELN("  teleblah");
    IS_VALID_ID := LEFT <> RIGHT;
END;


(* MAIN *)
BEGIN
    RESET(INFILE);
    INVALID_SUM := 0;
    REPEAT
        READLN(INFILE, RANGE_LOW, COMMA_NOM, RANGE_HIGH);

{        WRITELN(RANGE_LOW, RANGE_HIGH);}

        FOR SCAN := RANGE_LOW TO RANGE_HIGH DO BEGIN
            IF NOT IS_VALID_ID(SCAN) THEN BEGIN
                INVALID_SUM := INVALID_SUM + SCAN;
{                WRITELN("WOOT ", SCAN, " IS AN INVLID");}
            END;
        END;

    UNTIL EOF(INFILE);
    WRITELN(INVALID_SUM);
END.
