
[INHERIT ('SYS$LIBRARY:STARLET',
          'SYS$LIBRARY:PASCAL$CLI_ROUTINES',
          'SYS$LIBRARY:PASCAL$LIB_ROUTINES',
          'SYS$LIBRARY:PASCAL$SMG_ROUTINES',
          'SYS$LIBRARY:PASCAL$STR_ROUTINES')]

PROGRAM AOC_DAY_2_1 (INFILE, OUTPUT);


TYPE
    STR255 = VARYING [255] OF CHAR;
    BIGNUM = STR255;
    INTSIZE = INTEGER;

VAR
    INFILE: TEXT;
    LINE: STR255;

    RANGE_LOW: BIGNUM;
    RANGE_HIGH: BIGNUM;
    COMMA_NOM: CHAR;

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

    S: VARYING [20] OF CHAR;
    HALF: INTSIZE;
    LEFT: STR255;
    RIGHT: STR255;
    LEN: INTEGER;

BEGIN
    LEN := LENGTH(ID);
    IF LEN < 2 THEN BEGIN
        IS_VALID_ID := TRUE;
        RETURN;
    END;

    HALF := TRUNC(LEN / 2);
    LEFT := ID[ 1 .. HALF ];
    RIGHT := ID[ HALF + 1 .. LEN];

    IS_VALID_ID := LEFT <> RIGHT;
END;


FUNCTION DENORMALIZE(DIGITS: STR255; EXP: INTEGER) : STR255;
VAR
    S : STR255;
    I : INTEGER;
BEGIN
    S := DIGITS;
    FOR I := 1 to EXP DO
        S := S + '0';
    DENORMALIZE := S;
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
writeln("looking at ", range_low, " -> ", range_high);

        SCAN := RANGE_LOW;
        REPEAT
            IF NOT IS_VALID_ID(SCAN) THEN BEGIN
                WRITELN("    WOOT ", SCAN, " IS INVLID");

                STATUS := STR$ADD(sign, exp, %DESCR INVALID_SUM,
                                  sign, exp, %DESCR SCAN,
                                  sign, exp, %DESCR TEMP);
                IF STATUS <> SS$_NORMAL THEN BEGIN
                    WRITELN("BAD ADD ", STATUS);
                END;
                INVALID_SUM := DENORMALIZE(TEMP, EXP);
                EXP := 0;
            END;
            STATUS := STR$ADD(sign, exp, %DESCR SCAN,
                              sign, exp, %DESCR ONE,
                              sign, exp, %DESCR TEMP);
            SCAN := DENORMALIZE(TEMP, exp);
            EXP := 0;
            IF STATUS <> SS$_NORMAL THEN BEGIN
                WRITELN("BAD ADD(2) ", STATUS);
            END;

            
        UNTIL NUMERIC_COMPARE(SCAN, RANGE_HIGH) = 1;        

    UNTIL EOF(INFILE);
    WRITELN(INVALID_SUM);
END.
