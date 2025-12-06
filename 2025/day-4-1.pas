PROGRAM AOC_DAY_4_1 (INFILE, OUTPUT);

TYPE
    LEFTRIGHT = (LEFT, RIGHT);
    STR255 = STRING(255);

CONST
    SIZE = 136;

VAR
    INFILE: TEXT;
    LINE: STR255;

    GRID: ARRAY[1..SIZE, 1..SIZE] OF CHAR;
    I: INTEGER;
    J: INTEGER;

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
    LOGGIT: BOOLEAN := FALSE;
BEGIN
    IF (ROW = 1) AND (COLUMN = 4) THEN LOGGIT := TRUE;

writeln("neighbours for ", row, column);
    FOR RSCAN := ROW - 1 TO ROW + 1 DO BEGIN
        FOR CSCAN := COLUMN - 1 TO COLUMN + 1 DO BEGIN
IF LOGGIT THEN WRITELN("  looking at RSCAN,CSCAN ", RSCAN, CSCAN);
            IF ((RSCAN <> ROW) OR (CSCAN <> COLUMN))
               AND (RSCAN >= 1) AND (CSCAN >= 1)
               AND (RSCAN <= SIZE) AND (CSCAN <= SIZE) THEN BEGIN
               IF GRID[RSCAN, CSCAN] <> '.' THEN BEGIN
IF LOGGIT THEN WRITELN("    incrementing for ", RSCAN, CSCAN);
                   COUNT := COUNT + 1;
               END;
            END;
        END;
    END;
writeln("survived?");
IF LOGGIT THEN WRITELN(" count is ", COUNT);
    NEIGHBORS := COUNT;
END;

(* MAIN *)
BEGIN
    RESET(INFILE);
    I := 1;
    REPEAT
        READLN(INFILE, LINE);
 writeln("LENGTH ", LENGTH(LINE));
        FOR J := 1 TO LENGTH(LINE) DO BEGIN
            GRID[I, J] := LINE[J];
        END; 
        I := I + 1;
    UNTIL EOF(INFILE);
dump_grid;

    FOR I := 1 TO SIZE DO BEGIN
        FOR J := 1 TO SIZE DO BEGIN
writeln("looking at ", i, j);
            IF (GRID[I][J] <> '.') AND (NEIGHBORS(I, J) < 4) THEN BEGIN
                GRID[I][J] := "x";
                ROLLCOUNT := ROLLCOUNT + 1;
            END
        END;
    END;
    DUMP_GRID;
    WRITELN(ROLLCOUNT);
END.
