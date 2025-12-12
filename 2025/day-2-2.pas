
[INHERIT ('SYS$LIBRARY:STARLET',
          'SYS$LIBRARY:PASCAL$STR_ROUTINES')]

PROGRAM AOC_DAY_2_1 (INFILE, OUTPUT);

TYPE
    STR255 = VARYING [255] OF CHAR;
    BIGNUM = STR255;

VAR
    INFILE: TEXT;
    LINE: STR255;

    RANGE_LOW: BIGNUM;
    RANGE_HIGH: BIGNUM;

    SCAN: BIGNUM;
    ONE: BIGNUM;
    INVALID_SUM: BIGNUM;

    SPLITPOINT: INTEGER;
    (* "Bignum" support storage *)
    SIGN: UNSIGNED;
    EXP: INTEGER;
    STATUS: INTEGER;
    TEMP: BIGNUM;


FUNCTION NUMERIC_COMPARE(THING1, THING2: STR255) : INTEGER; { usual -1/0/+1 }
VAR
    LEN1, LEN2: INTEGER;
BEGIN
    LEN1 := LENGTH(THING1);
    LEN2 := LENGTH(THING2);

    IF LEN1 < LEN2 THEN NUMERIC_COMPARE := -1
    ELSE IF LEN1 > LEN2 THEN NUMERIC_COMPARE := 1
    ELSE BEGIN
        IF THING1 < THING2 THEN NUMERIC_COMPARE := -1
	ELSE IF THING1 > THING2 THEN NUMERIC_COMPARE := 1
        ELSE NUMERIC_COMPARE := 0;
    END;
END;

FUNCTION IS_VALID_ID(VAR ID: BIGNUM) : BOOLEAN;
VAR
    HALF: INTEGER;
    TEMPLATE: STR255;
    CANDIDATE: STR255;
    LEN: INTEGER;
    WIDTH: INTEGER;
    SCAN: INTEGER;
    ALLMATCH: BOOLEAN;
    
BEGIN
    LEN := LENGTH(ID);
    IF LEN < 2 THEN BEGIN
        IS_VALID_ID := TRUE;
        RETURN;
    END;

    HALF := TRUNC(LEN / 2);

    FOR WIDTH := 1 TO HALF DO BEGIN {I is substring length to consider}
        { only evenly divisble is useful }
        IF LEN REM WIDTH = 0 THEN BEGIN
            { There is no FOR .. STEP construct :-( }
            TEMPLATE := ID[1 .. WIDTH];
            ALLMATCH := TRUE;
            SCAN := WIDTH + 1;
            REPEAT
                CANDIDATE := ID[SCAN .. SCAN + WIDTH - 1];
                IF TEMPLATE <> CANDIDATE THEN BEGIN
                    ALLMATCH := FALSE;
                END;
                SCAN := SCAN + WIDTH;
            UNTIL SCAN > LEN;

            IF ALLMATCH THEN BEGIN
                WRITELN("   HOORAY ALL MATCHED FOR ", TEMPLATE);
                IS_VALID_ID := FALSE;
                RETURN;
            END;
        END ELSE BEGIN
        END;
    END;
    IS_VALID_ID := TRUE;
END;

FUNCTION DENORMALIZE(DIGITS: STR255; EXP: INTEGER) : STR255;
VAR
    I : INTEGER;
BEGIN
    FOR I := 1 to EXP DO
        DIGITS := DIGITS + '0';
    DENORMALIZE := DIGITS;
END;


FUNCTION ADD_BIGNUM(THING1, THING2: BIGNUM) : BIGNUM;
VAR
    SIGN: UNSIGNED;
    EXP: INTEGER;
    STATUS: INTEGER;
    TEMP: BIGNUM;
BEGIN
    SIGN := 0;
    EXP := 0;

    STATUS := STR$ADD(sign, exp, %DESCR THING1,
                      sign, exp, %DESCR THING2,
                      sign, exp, %DESCR TEMP);
    IF STATUS <> SS$_NORMAL THEN BEGIN
        WRITELN("BAD ADD: ", STATUS, THING1, THING2);
    END;
    ADD_BIGNUM := DENORMALIZE(TEMP, EXP);
END;


(* MAIN *)
BEGIN
    RESET(INFILE);
    ONE := "1";
    INVALID_SUM := "0";
    SIGN := 0;
    EXP := 0;

    REPEAT
        READLN(INFILE, LINE);
        SPLITPOINT := INDEX(LINE, "-");
        RANGE_LOW := LINE[1 .. SPLITPOINT - 1];
        RANGE_HIGH := LINE[ SPLITPOINT + 1 .. LENGTH(LINE)];
        WRITELN("looking at ", range_low, " -> ", range_high);

        SCAN := RANGE_LOW;
        REPEAT
            IF NOT IS_VALID_ID(SCAN) THEN BEGIN
                WRITELN("    WOOT ", SCAN, " IS INVALID");
                INVALID_SUM := ADD_BIGNUM(INVALID_SUM, SCAN);
            END;
            SCAN := ADD_BIGNUM(SCAN, ONE);
        UNTIL NUMERIC_COMPARE(SCAN, RANGE_HIGH) = 1;

    UNTIL EOF(INFILE);
    WRITELN(INVALID_SUM);
END.
