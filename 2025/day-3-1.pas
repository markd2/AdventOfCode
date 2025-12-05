PROGRAM AOC_DAY_3_1 (INFILE, OUTPUT);

TYPE
    STR255 = STRING(255);

VAR
    INFILE: TEXT;
    LINE: STR255;
    OUTPUT_JOLTAGE: INTEGER;

FUNCTION JOLTAGE(LINE: STR255): INTEGER;
VAR
    START_MAX: INTEGER;
    START_MAX_INDEX: INTEGER;
    END_MAX: INTEGER;
    I: INTEGER;
    J_VALUE: INTEGER;
BEGIN

    { first find the first largest number }
    START_MAX := -1;
    END_MAX := 0;

    FOR I := 1 TO LENGTH(LINE) - 1 DO BEGIN
        J_VALUE := INT(LINE[I]) - ORD('0');
        IF J_VALUE > START_MAX THEN BEGIN
            START_MAX := J_VALUE;
            START_MAX_INDEX := I;
        END;
    END;

    { then find the largest number after ^^ that one }
    FOR I := START_MAX_INDEX + 1 to LENGTH(LINE) DO BEGIN
        J_VALUE := INT(LINE[I]) - ORD('0');
        IF J_VALUE > END_MAX THEN BEGIN
            END_MAX := J_VALUE;
        END;
    END;

{    WRITELN("FOR LINE ", LINE, " MAX IS ", START_MAX, " at index ", 
            START_MAX_INDEX, " second max is ", END_MAX); }

    JOLTAGE := START_MAX * 10 + END_MAX;
END;


(* MAIN *)
BEGIN
    RESET(INFILE);
    OUTPUT_JOLTAGE := 0;

    REPEAT
        READLN(INFILE, LINE);
        OUTPUT_JOLTAGE := OUTPUT_JOLTAGE + JOLTAGE(LINE);
    UNTIL EOF(INFILE);
    WRITELN(OUTPUT_JOLTAGE);
END.
