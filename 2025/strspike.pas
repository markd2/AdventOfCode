[INHERIT ('SYS$LIBRARY:STARLET',
          'SYS$LIBRARY:PASCAL$CLI_ROUTINES',
          'SYS$LIBRARY:PASCAL$LIB_ROUTINES',
          'SYS$LIBRARY:PASCAL$LBR_ROUTINES',
          'SYS$LIBRARY:PASCAL$MAIL_ROUTINES',
          'SYS$LIBRARY:PASCAL$STR_ROUTINES')]

PROGRAM STRING_SPIKE(INFILE, OUTPUT);

VAR
    INFILE: TEXT;
    LINE: VARYING [20] OF CHAR;
    RESULT: VARYING [40] OF CHAR;
    STATUS: INTEGER;

    asign: UNSIGNED;
    aexp: INTEGER;
    bsign: UNSIGNED;
    bexp: INTEGER;
    csign: UNSIGNED;
    cexp: INTEGER;
    
BEGIN
    RESET(INFILE);

    REPEAT
        READLN(INFILE, LINE);
        WRITELN(LINE);
asign := 0; bsign := 0;
aexp := 0; bexp := 0;
csign := 0; cexp := 0;

        STATUS := STR$ADD(asign, aexp, %DESCR LINE,
                          bsign, bexp, %DESCR LINE,
                          csign, cexp, %DESCR RESULT);
        WRITELN("  Status ", STATUS, " result ", RESULT);

    UNTIL EOF(INFILE);
    WRITELN("Bork");
END.
