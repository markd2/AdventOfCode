PROGRAM AOC_DAY_6_1 (INFILE, OUTPUT);

TYPE
    STR255 = STRING(255);
    OPERATOR = ( PLUS, TIMES );

VAR
    INFILE: TEXT;
    LINE: STR255;
    C: CHAR;
    I: INTEGER;
    ACCUM: INTEGER;

    OPERATORS: ARRAY[1..2000] OF OPERATOR;
    OPERATOR_COUNT: INTEGER := 0;

    NUMBERS: ARRAY[1..2000] OF INTEGER;
    NUMBER_COUNT: INTEGER := 0;

    RUNNING_VALUE: INTEGER;

FUNCTION EXTRACT_NUMBER(LINE: STR255): INTEGER;
VAR
    NUMBER: INTEGER := 0;
    LEN: INTEGER;
    SCAN: INTEGER := 2;

BEGIN
    LEN := LENGTH(LINE);

    REPEAT
        NUMBER := NUMBER * 10;
        NUMBER := NUMBER + ORD(LINE[SCAN]) - ORD('0');
        SCAN := SCAN + 1;
    UNTIL SCAN > LEN;

    EXTRACT_NUMBER := NUMBER;
END;


(* MAIN *)
BEGIN
    RESET(INFILE);

    (* first, soak up operators.  Reordered the supplied files *)
    WHILE NOT EOLN(INFILE) DO BEGIN
        READ(INFILE, C);
        IF C = '*' THEN BEGIN
            OPERATOR_COUNT := OPERATOR_COUNT + 1;
            OPERATORS[OPERATOR_COUNT] := TIMES;
        END;
        IF C = '+' THEN BEGIN
            OPERATOR_COUNT := OPERATOR_COUNT + 1;
            OPERATORS[OPERATOR_COUNT] := PLUS;
        END;
    END;
    READ(INFILE, C);  { nom the newline }

    WRITELN("yay got ", OPERATOR_COUNT, "operators");

    REPEAT
        (* next, process numbers *)
        ACCUM := 0;
        NUMBER_COUNT := 0;

        WHILE NOT EOLN(INFILE) DO BEGIN
            READ(INFILE, C);

            IF C = ' ' THEN BEGIN
                IF ACCUM <> 0 THEN BEGIN
                    NUMBER_COUNT := NUMBER_COUNT + 1;
                    NUMBERS[NUMBER_COUNT] := ACCUM;
                    ACCUM := 0;
                END;
            END ELSE BEGIN
                ACCUM := ACCUM * 10;
                ACCUM := ACCUM + ORD(C) - ORD('0')
            END;

        END;
        IF ACCUM <> 0 THEN BEGIN
            NUMBER_COUNT := NUMBER_COUNT + 1;
            NUMBERS[NUMBER_COUNT] := ACCUM;
        END;

        { Do column math }

NEXT HERE - Need array of number arrays, and then do math down the arrays.

        RUNNING_VALUE := NUMBERS[1];
        FOR I := 2 TO NUMBER_COUNT DO BEGIN
            CASE OPERATORS[I - 1] OF
                PLUS: RUNNING_VALUE := RUNNING_VALUE + NUMBERS[I];
                TIMES: RUNNING_VALUE := RUNNING_VALUE * NUMBERS[I];
            END;
        END;

        WRITELN("LINE MATH ", RUNNING_VALUE);
        READ(INFILE, C);  { nom the newline }

    UNTIL EOF(INFILE);
END.
