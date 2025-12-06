# AoC 2025

This year, VAX Pascal!  Yay!

Development on simh emulating a VAX 8600.  Thanks to Dave McGuire and
Terri Kennedy for getting me set up with a working programmable 
VAX/VMS (7.something) image.

No real running commentary this year.  Mainly using this as an
excuse to refresh my Pascal chops (the LSSM has a PERQ that's getting
up and running, and the programming docs are in Pascal).  I have
some _plans_ for that machine.

One fun thing is - day three could use a bignum package for adding up 
100 digit numbers.  VMS supports strings-as-numbers.  Couldn't get it
to link MTH$LOG1.

### Using multiple files

Say have BORKNUM.PAS that has a bignum library.

Can build it with the usual `PASCAL BORKNUM`


[INHERIT ('SYS$LIBRARY:STARLET',
	  'SYS$LIBRARY:PASCAL$CLI_ROUTINES',
	  'SYS$LIBRARY:PASCAL$LIB_ROUTINES',
	  'SYS$LIBRARY:PASCAL$SMG_ROUTINES',
	  'SYS$LIBRARY:PASCAL$STR_ROUTINES')]

PROGRAM  Pp (INPUT,OUTPUT,Inprog,Outprog) ;


