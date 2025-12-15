PROGRAM AOC_DAY_6_1 (INFILE, OUTPUT);

TYPE
    STR255 = STRING(255);
    OPERATOR = ( PLUS, TIMES );
    NUMARRAY = ARRAY[1..2000] OF INTEGER;

VAR
    INFILE: TEXT;
    LINE: STR255;
    C: CHAR;
    I, J: INTEGER;
    ACCUM: INTEGER;

    OPERATORS: ARRAY[1..2000] OF OPERATOR;
    OPERATOR_COUNT: INTEGER := 0;

    NUMBERS: ARRAY[1..10] OF NUMARRAY;
    NUMBER_COUNT: INTEGER := 0;
    SUBARRAY_COUNT: INTEGER := 0;

    RUNNING_VALUE: QUADRUPLE := 0;
    TOTAL_SUM: QUADRUPLE := 0;

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

    (* next, inhale numbers *)

    NUMBER_COUNT := 0;
    REPEAT
        NUMBER_COUNT := NUMBER_COUNT + 1;

        ACCUM := 0;
        SUBARRAY_COUNT := 0;

        WHILE NOT EOLN(INFILE) DO BEGIN
            READ(INFILE, C);

            IF C = ' ' THEN BEGIN
                IF ACCUM <> 0 THEN BEGIN
                    SUBARRAY_COUNT := SUBARRAY_COUNT + 1;
                    NUMBERS[NUMBER_COUNT][SUBARRAY_COUNT] := ACCUM;
                    ACCUM := 0;
                END;
            END ELSE BEGIN
                ACCUM := ACCUM * 10;
                ACCUM := ACCUM + ORD(C) - ORD('0')
            END;

        END;
        IF ACCUM <> 0 THEN BEGIN
            SUBARRAY_COUNT := SUBARRAY_COUNT + 1;
            NUMBERS[NUMBER_COUNT][SUBARRAY_COUNT] := ACCUM;
        END;

        READ(INFILE, C);  { nom the newline }

    UNTIL EOF(INFILE);

    FOR I := 1 to NUMBER_COUNT DO BEGIN
        WRITELN("OOK ", NUMBERS[I][1]);
    END;

    TOTAL_SUM := 0;
    FOR I := 1 TO SUBARRAY_COUNT DO BEGIN  { walk columns }
        RUNNING_VALUE := QUAD(NUMBERS[1][I]);
        FOR J := 2 TO NUMBER_COUNT DO BEGIN  { for each column }
            CASE OPERATORS[I] OF
                PLUS: RUNNING_VALUE := RUNNING_VALUE + QUAD(NUMBERS[J][I]);
                TIMES: RUNNING_VALUE := RUNNING_VALUE * QUAD(NUMBERS[J][I]);
            END;
        END;
        WRITELN("RUNNING ", RUNNING_VALUE);
        TOTAL_SUM := TOTAL_SUM + QUAD(RUNNING_VALUE);
    END;

    WRITELN("LINE MATH ", TOTAL_SUM);

END.
