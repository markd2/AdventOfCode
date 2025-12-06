PROGRAM AOC_DAY_4_2 (INFILE, OUTPUT);

TYPE
    LEFTRIGHT = (LEFT, RIGHT);
    STR255 = STRING(255);

CONST
    SIZE = 136;
{    SIZE = 10;}

VAR
    INFILE: TEXT;
    LINE: STR255;

    GRID: ARRAY[1..SIZE, 1..SIZE] OF CHAR;
    I: INTEGER;
    J: INTEGER;

    COUNT: INTEGER := 0;
    ROLLCOUNT: INTEGER := 0;

PROCEDURE DUMP_GRID;
VAR
    ROW: INTEGER;
    COLUMN: INTEGER;

BEGIN
    writeln("dumping grid...");
    FOR ROW := 1 TO SIZE DO BEGIN
        FOR COLUMN := 1 to SIZE DO BEGIN
            WRITE(GRID[ROW, COLUMN]);
        END;
        WRITELN("");
    END;
END;

FUNCTION NEIGHBORS(ROW, COLUMN: INTEGER) : INTEGER;
VAR
    RSCAN, CSCAN : INTEGER;
    COUNT: INTEGER := 0;
BEGIN
    FOR RSCAN := ROW - 1 TO ROW + 1 DO BEGIN
        FOR CSCAN := COLUMN - 1 TO COLUMN + 1 DO BEGIN
            IF ((RSCAN <> ROW) OR (CSCAN <> COLUMN))
               AND (RSCAN >= 1) AND (CSCAN >= 1)
               AND (RSCAN <= SIZE) AND (CSCAN <= SIZE) THEN BEGIN
               IF GRID[RSCAN, CSCAN] <> '.' THEN BEGIN
                   COUNT := COUNT + 1;
               END;
            END;
        END;
    END;
    NEIGHBORS := COUNT;
END;

FUNCTION COUNT_N_CLEAR : INTEGER;
VAR
    ROW, COLUMN: INTEGER;
    ROLLCOUNT: INTEGER := 0;
BEGIN
    FOR I := 1 TO SIZE DO BEGIN
        FOR J := 1 TO SIZE DO BEGIN
            IF (GRID[I][J] <> '.') AND (NEIGHBORS(I, J) < 4) THEN BEGIN
                GRID[I][J] := "x";
                ROLLCOUNT := ROLLCOUNT + 1;
            END
        END;
    END;
    COUNT_N_CLEAR := ROLLCOUNT;

    { replace 'x' with '.' }
    FOR I := 1 TO SIZE DO BEGIN
        FOR J := 1 TO SIZE DO BEGIN
            IF GRID[I][J] = 'x' THEN GRID[I][J] := '.';
        END;
    END;
END;

(* MAIN *)
BEGIN
    RESET(INFILE);
    I := 1;
    REPEAT
        READLN(INFILE, LINE);
        FOR J := 1 TO LENGTH(LINE) DO BEGIN
            GRID[I, J] := LINE[J];
        END; 
        I := I + 1;
    UNTIL EOF(INFILE);

    REPEAT
        COUNT := COUNT_N_CLEAR;
        ROLLCOUNT := ROLLCOUNT + COUNT;
(*        WRITELN("COUNT ", COUNT);
        DUMP_GRID; *)
    UNTIL COUNT = 0;
    WRITELN(ROLLCOUNT);
END.
