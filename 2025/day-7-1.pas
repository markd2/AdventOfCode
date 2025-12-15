PROGRAM AOC_DAY_7_1 (INFILE, OUTPUT);

TYPE
    STR255 = STRING(255);

VAR
    INFILE: TEXT;
    LINE: STR255;
    LINES: ARRAY[1..150] of STR255;
    LINE_COUNT: INTEGER := 0;

    I: INTEGER;
    SCAN: INTEGER;
    SPLIT_COUNT: INTEGER := 0;

(* MAIN *)
BEGIN
    RESET(INFILE);

    REPEAT
        READLN(INFILE, LINE); 
        LINE_COUNT := LINE_COUNT + 1;
        LINES[LINE_COUNT] := LINE;
    UNTIL EOF(INFILE);

    FOR I := 1 TO LINE_COUNT - 1 DO BEGIN
        LINE := LINES[I];
        FOR SCAN := 1 TO LENGTH(LINE) DO BEGIN
            IF LINE[SCAN] = 'S' THEN BEGIN
                LINES[I+1][SCAN] := '|';
            END;
            IF LINE[SCAN] = '|' THEN BEGIN
                IF LINES[I+1][SCAN] = '^' THEN BEGIN { split }
                    LINES[I+1][SCAN-1] := '|';
                    LINES[I+1][SCAN+1] := '|';
                    SPLIT_COUNT := SPLIT_COUNT + 1;
                END ELSE BEGIN { carry down }
                    LINES[I+1][SCAN] := '|';
                END;
            END;
        END;
    END;

    FOR I := 1 TO LINE_COUNT DO BEGIN
        WRITELN(LINES[I]);
    END;
    WRITELN("SPLITZ ", SPLIT_COUNT);
END.
