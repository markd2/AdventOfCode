[PEN_CHECKING_STYLE(NONE)] MODULE PASCAL$STR_ROUTINES;
{
    Copyright 2000 Compaq Computer Corporation

    COMPAQ Registered in U.S. Patent and Trademark Office.

    Confidential computer software. Valid license from Compaq required for
    possession, use or copying. Consistent with FAR 12.211 and 12.212,
    Commercial Computer Software, Computer Software Documentation, and
    Technical Data for Commercial Items are licensed to the U.S. Government
    under vendor's standard commercial license.
}

[HIDDEN] TYPE	(**** Pre-declared data types ****)
	$BYTE = [BYTE] -128..127;
	$WORD = [WORD] -32768..32767;
	$QUAD = [QUAD,UNSAFE] RECORD
		L0:UNSIGNED; L1:INTEGER; END;
	$OCTA = [OCTA,UNSAFE] RECORD
		L0,L1,L2:UNSIGNED; L3:INTEGER; END;
	$UBYTE = [BYTE] 0..255;
	$UWORD = [WORD] 0..65535;
	$UQUAD = [QUAD,UNSAFE] RECORD
		L0,L1:UNSIGNED; END;
	$UOCTA = [OCTA,UNSAFE] RECORD
		L0,L1,L2,L3:UNSIGNED; END;
	$PACKED_DEC = [BIT(4),UNSAFE] 0..15;
	$DEFTYP = [UNSAFE] INTEGER;
	$DEFPTR = [UNSAFE] ^$DEFTYP;
	$BOOL = [BIT(1),UNSAFE] BOOLEAN;
	$BIT  = [BIT(1),UNSAFE] BOOLEAN;
	$BIT2 = [BIT(2),UNSAFE] 0..3;
	$BIT3 = [BIT(3),UNSAFE] 0..7;
	$BIT4 = [BIT(4),UNSAFE] 0..15;
	$BIT5 = [BIT(5),UNSAFE] 0..31;
	$BIT6 = [BIT(6),UNSAFE] 0..63;
	$BIT7 = [BIT(7),UNSAFE] 0..127;
	$BIT8 = [BIT(8),UNSAFE] 0..255;
	$BIT9 = [BIT(9),UNSAFE] 0..511;
	$BIT10 = [BIT(10),UNSAFE] 0..1023;
	$BIT11 = [BIT(11),UNSAFE] 0..2047;
	$BIT12 = [BIT(12),UNSAFE] 0..4095;
	$BIT13 = [BIT(13),UNSAFE] 0..8191;
	$BIT14 = [BIT(14),UNSAFE] 0..16383;
	$BIT15 = [BIT(15),UNSAFE] 0..32767;
	$BIT16 = [BIT(16),UNSAFE] 0..65535;
	$BIT17 = [BIT(17),UNSAFE] 0..131071;
	$BIT18 = [BIT(18),UNSAFE] 0..262143;
	$BIT19 = [BIT(19),UNSAFE] 0..524287;
	$BIT20 = [BIT(20),UNSAFE] 0..1048575;
	$BIT21 = [BIT(21),UNSAFE] 0..2097151;
	$BIT22 = [BIT(22),UNSAFE] 0..4194303;
	$BIT23 = [BIT(23),UNSAFE] 0..8388607;
	$BIT24 = [BIT(24),UNSAFE] 0..16777215;
	$BIT25 = [BIT(25),UNSAFE] 0..33554431;
	$BIT26 = [BIT(26),UNSAFE] 0..67108863;
	$BIT27 = [BIT(27),UNSAFE] 0..134217727;
	$BIT28 = [BIT(28),UNSAFE] 0..268435455;
	$BIT29 = [BIT(29),UNSAFE] 0..536870911;
	$BIT30 = [BIT(30),UNSAFE] 0..1073741823;
	$BIT31 = [BIT(31),UNSAFE] 0..2147483647;
	$BIT32 = [BIT(32),UNSAFE] UNSIGNED;
 
 
(*** MODULE str$routines ***)
 
(**************************************************************************** *)
(*									    * *)
(*  COPYRIGHT (c) 1988 BY               				    * *)
(*  DIGITAL EQUIPMENT CORPORATION, MAYNARD, MASSACHUSETTS.		    * *)
(*  ALL RIGHTS RESERVED.						    * *)
(* 									    * *)
(*  THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED   * *)
(*  ONLY IN  ACCORDANCE WITH  THE  TERMS  OF  SUCH  LICENSE  AND WITH THE   * *)
(*  INCLUSION OF THE ABOVE COPYRIGHT NOTICE. THIS SOFTWARE OR  ANY  OTHER   * *)
(*  COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY   * *)
(*  OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF  THE  SOFTWARE IS  HEREBY   *  *)
(*  TRANSFERRED.			       				    * *)
(* 									    * *)
(*  THE INFORMATION IN THIS SOFTWARE IS  SUBJECT TO CHANGE WITHOUT NOTICE   * *)
(*  AND  SHOULD  NOT  BE  CONSTRUED AS  A COMMITMENT BY DIGITAL EQUIPMENT   * *)
(*  CORPORATION.							    * *)
(* 									    * *)
(*  DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE  OR  RELIABILITY OF ITS   * *)
(*  SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.		    * *)
(* 									    * *)
(*									    * *)
(**************************************************************************** *)
(*    STR$ADD                                                               *)
(*                                                                          *)
(*    Add Two Decimal Strings                                               *)
(*                                                                          *)
(*    The Add Two Decimal Strings routine                                   *)
(*    adds two decimal strings of digits.                                   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$add (
	asign : UNSIGNED;
	aexp : INTEGER;
	adigits : [CLASS_S] PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR;
	bsign : UNSIGNED;
	bexp : INTEGER;
	bdigits : [CLASS_S] PACKED ARRAY [$l6..$u6:INTEGER] OF CHAR;
	VAR csign : [VOLATILE] UNSIGNED;
	VAR cexp : [VOLATILE] INTEGER;
	VAR cdigits : [CLASS_S,VOLATILE] PACKED ARRAY [$l9..$u9:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$ANALYZE_SDESC                                                     *)
(*                                                                          *)
(*    Analyze String Descriptor                                             *)
(*                                                                          *)
(*    The Analyze String Descriptor routine extracts the                    *)
(*    length and starting address of the data                               *)
(*    for a variety of string descriptor classes.                           *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$analyze_sdesc (
	input_descriptor : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	VAR word_integer_length : [VOLATILE] $UWORD;
	VAR data_address : [VOLATILE] UNSIGNED) : $UWORD; EXTERNAL;
 
(*    STR$APPEND                                                            *)
(*                                                                          *)
(*    Append String                                                         *)
(*                                                                          *)
(*    The Append String routine appends a source string to the end of a destination string. *)
(*    The destination string must be a dynamic or varying-length string.    *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$append (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$CASE_BLIND_COMPARE                                                *)
(*                                                                          *)
(*    Compare Strings Without Regard to Case                                *)
(*                                                                          *)
(*    The Compare Strings Without Regard to Case routine compares two input *)
(*    strings of any supported class                                        *)
(*    and data type without regard to whether the alphabetic characters are uppercase *)
(*    or lowercase.                                                         *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$case_blind_compare (
	first_source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	second_source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$COMPARE                                                           *)
(*                                                                          *)
(*    Compare Two Strings                                                   *)
(*                                                                          *)
(*    The Compare Two Strings routine compares the                          *)
(*    contents of two strings.                                              *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$compare (
	first_source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	second_source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$CONCAT                                                            *)
(*                                                                          *)
(*    Concatenate Two or More Strings                                       *)
(*                                                                          *)
(*    The Concatenate Two or More Strings routine concatenates all specified *)
(*    source strings into a single destination string.                      *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$concat (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	$p3 : [LIST,CLASS_S,UNSAFE] PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$COPY_DX                                                           *)
(*                                                                          *)
(*    Copy a Source String Passed by Descriptor to a Destination String     *)
(*                                                                          *)
(*    The Copy a Source String Passed by Descriptor to                      *)
(*    a Destination String routine copies a source string to                *)
(*    a destination string. Both strings are                                *)
(*    passed by descriptor.                                                 *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$copy_dx (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$COPY_R                                                            *)
(*                                                                          *)
(*    Copy a Source String Passed by Reference to a Destination String      *)
(*                                                                          *)
(*    The Copy a Source String Passed by Reference to                       *)
(*    a Destination String routine copies a source string passed by reference to a destination *)
(*    string.                                                               *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$copy_r (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	word_integer_source_length : $UWORD;
	%REF source_string_address : PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$DIVIDE                                                            *)
(*                                                                          *)
(*    Divide Two Decimal Strings                                            *)
(*                                                                          *)
(*    The Divide Two Decimal Strings routine divides two decimal strings.   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$divide (
	asign : UNSIGNED;
	aexp : INTEGER;
	adigits : [CLASS_S] PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR;
	bsign : UNSIGNED;
	bexp : INTEGER;
	bdigits : [CLASS_S] PACKED ARRAY [$l6..$u6:INTEGER] OF CHAR;
	total_digits : INTEGER;
	round_truncate_indicator : UNSIGNED;
	VAR csign : [VOLATILE] UNSIGNED;
	VAR cexp : [VOLATILE] INTEGER;
	VAR cdigits : [CLASS_S,VOLATILE] PACKED ARRAY [$l11..$u11:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$DUPL_CHAR                                                         *)
(*                                                                          *)
(*    Duplicate Character Empty Times                                       *)
(*                                                                          *)
(*    The Duplicate Character empty Times routine                           *)
(*    generates a string containing empty duplicates of the input           *)
(*    character. If the destination string is an empty dynamic string descriptor, *)
(*    STR$DUPL_CHAR allocates and initializes the string.                   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$dupl_char (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	repetition_count : INTEGER := %IMMED 0;
	%REF ASCII_character : PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR := %IMMED 0) : INTEGER; EXTERNAL;
 
(*    STR$ELEMENT                                                           *)
(*                                                                          *)
(*    Extract Delimited Element Substring                                   *)
(*                                                                          *)
(*    The Extract Delimited Element Substring routine extracts an element   *)
(*    from a string in which the elements are separated by a specified      *)
(*    delimiter.                                                            *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$element (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	element_number : INTEGER;
	delimiter_string : [CLASS_S] PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l4..$u4:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$COMPARE_EQL                                                       *)
(*                                                                          *)
(*    Compare Two Strings for Equality                                      *)
(*                                                                          *)
(*    The Compare Two Strings for Equality routine compares two             *)
(*    strings to see if they have the same length                           *)
(*    and contents. Uppercase and lowercase characters are not considered equal. *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$compare_eql (
	first_source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	second_source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$FIND_FIRST_IN_SET                                                 *)
(*                                                                          *)
(*    Find First Character in a Set of Characters                           *)
(*                                                                          *)
(*    The Find First Character in a Set of                                  *)
(*    Characters routine                                                    *)
(*    searches a string one character at a time, from                       *)
(*    left to right, comparing each character in the string to every character in *)
(*    a specified set of characters for which it is searching.              *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$find_first_in_set (
	source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	set_of_characters : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$FIND_FIRST_NOT_IN_SET                                             *)
(*                                                                          *)
(*    Find First That Does Not Occur in Set                                 *)
(*                                                                          *)
(*    The Find First Character That Does Not                                *)
(*    Occur in Set routine                                                  *)
(*    searches a string, comparing each character to the                    *)
(*    characters in a specified set of characters.  The string is searched character *)
(*    by character, from left to right.  STR$FIND_FIRST_NOT_IN_SET returns the *)
(*    position of the first character in the string that does not match any of the *)
(*    characters in the selected set of characters.                         *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$find_first_not_in_set (
	source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	set_of_characters : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$FREE1_DX                                                          *)
(*                                                                          *)
(*    Free One Dynamic String                                               *)
(*                                                                          *)
(*    The Free One Dynamic String routine                                   *)
(*    deallocates one dynamic string.                                       *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$free1_dx (
	VAR string_descriptor : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$FIND_FIRST_SUBSTRING                                              *)
(*                                                                          *)
(*    Find First Substring in Input String                                  *)
(*                                                                          *)
(*    The Find First Substring in Input String routine                      *)
(*    finds the first substring (in a provided list of                      *)
(*    substrings) occurring in a given string.                              *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$find_first_substring (
	source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	VAR index : [VOLATILE] INTEGER;
	VAR substring_index : [VOLATILE] INTEGER;
	substring : [LIST,CLASS_S,UNSAFE] PACKED ARRAY [$l4..$u4:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$GET1_DX                                                           *)
(*                                                                          *)
(*    Allocate One Dynamic String                                           *)
(*                                                                          *)
(*    The Allocate One Dynamic String routine                               *)
(*    allocates a specified number of bytes of dynamic virtual memory       *)
(*    to a specified dynamic string descriptor.                             *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$get1_dx (
	word_integer_length : $UWORD;
	VAR character_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$LEFT                                                              *)
(*                                                                          *)
(*    Extract a Substring of a String                                       *)
(*                                                                          *)
(*    The Extract a Substring of a String routine copies a substring of a   *)
(*    source string into a                                                  *)
(*    destination string. The relative starting position in the source      *)
(*    string is 1.                                                          *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$left (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	end_position : INTEGER) : INTEGER; EXTERNAL;
 
(*    STR$LEN_EXTR                                                          *)
(*                                                                          *)
(*    Extract a Substring of a String                                       *)
(*                                                                          *)
(*    The Extract a Substring of a String routine copies a                  *)
(*    substring of a source string into a                                   *)
(*    destination string.                                                   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$len_extr (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	start_position : INTEGER;
	longword_integer_length : INTEGER) : INTEGER; EXTERNAL;
 
(*    STR$MATCH_WILD                                                        *)
(*                                                                          *)
(*    Match Wildcard Specification                                          *)
(*                                                                          *)
(*    The Match Wildcard Specification routine is used to compare a         *)
(*    pattern string that includes wildcard                                 *)
(*    characters with a candidate string.  It returns a condition value of STR$_MATCH *)
(*    if the strings match and  STR$_NOMATCH if they do not match.          *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$match_wild (
	candidate_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	pattern_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$MUL                                                               *)
(*                                                                          *)
(*    Multiply Two Decimal Strings                                          *)
(*                                                                          *)
(*    The Multiply Two Decimal Strings routine multiplies two decimal strings. *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$mul (
	asign : UNSIGNED;
	aexp : INTEGER;
	adigits : [CLASS_S] PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR;
	bsign : UNSIGNED;
	bexp : INTEGER;
	bdigits : [CLASS_S] PACKED ARRAY [$l6..$u6:INTEGER] OF CHAR;
	VAR csign : [VOLATILE] UNSIGNED;
	VAR cexp : [VOLATILE] INTEGER;
	VAR cdigits : [CLASS_S,VOLATILE] PACKED ARRAY [$l9..$u9:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$COMPARE_MULTI                                                     *)
(*                                                                          *)
(*    Compare Two for Equality Using Multinational Character Set            *)
(*                                                                          *)
(*    The Compare Two Strings for Equality Using                            *)
(*    Multinational Character Set routine compares two character            *)
(*    strings for equality using the                                        *)
(*    DEC Multinational Character Set.                                      *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$compare_multi (
	first_source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	second_source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	%IMMED flags_value : UNSIGNED := %IMMED 0;
	%IMMED foreign_language : UNSIGNED := %IMMED 0) : INTEGER; EXTERNAL;
 
(*    STR$POS_EXTR                                                          *)
(*                                                                          *)
(*    Extract a Substring of a String                                       *)
(*                                                                          *)
(*    The Extract a Substring of a String routine                           *)
(*    copies a substring of a source string into a                          *)
(*    destination string.                                                   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$pos_extr (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	start_position : INTEGER;
	end_position : INTEGER) : INTEGER; EXTERNAL;
 
(*    STR$POSITION                                                          *)
(*                                                                          *)
(*    Return Relative Position of Substring                                 *)
(*                                                                          *)
(*    The Return Relative Position of Substring routine                     *)
(*    searches for the first occurrence of a                                *)
(*    single substring within a source string.  If STR$POSITION finds the substring, *)
(*    it returns the relative position of that substring.                   *)
(*    If the substring is not found, STR$POSITION returns a zero.           *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$position (
	source_string : [CLASS_S] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	substring : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	start_position : INTEGER := %IMMED 0) : INTEGER; EXTERNAL;
 
(*    STR$PREFIX                                                            *)
(*                                                                          *)
(*    Prefix a String                                                       *)
(*                                                                          *)
(*    The Prefix a String routine                                           *)
(*    inserts a source string at the beginning of a destination             *)
(*    string. The destination string must be dynamic or varying length.     *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$prefix (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$RECIP                                                             *)
(*                                                                          *)
(*    Reciprocal of a Decimal String                                        *)
(*                                                                          *)
(*    The Reciprocal of a Decimal String routine                            *)
(*    takes the reciprocal of the first decimal string to the precision     *)
(*    limit specified by the second decimal string and returns the result as a *)
(*    decimal string.                                                       *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$recip (
	asign : UNSIGNED;
	aexp : INTEGER;
	adigits : [CLASS_S] PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR;
	bsign : UNSIGNED;
	bexp : INTEGER;
	bdigits : [CLASS_S] PACKED ARRAY [$l6..$u6:INTEGER] OF CHAR;
	VAR csign : [VOLATILE] UNSIGNED;
	VAR cexp : [VOLATILE] INTEGER;
	VAR cdigits : [CLASS_S,VOLATILE] PACKED ARRAY [$l9..$u9:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$REPLACE                                                           *)
(*                                                                          *)
(*    Replace a Substring                                                   *)
(*                                                                          *)
(*    The Replace a Substring routine                                       *)
(*    copies a source string to a destination string, replacing part        *)
(*    of the string with another string.  The substring to be replaced is   *)
(*    specified by its starting and ending positions.                       *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$replace (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	start_position : INTEGER;
	end_position : INTEGER;
	replacement_string : [CLASS_S] PACKED ARRAY [$l5..$u5:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$RIGHT                                                             *)
(*                                                                          *)
(*    Extract a Substring of a String                                       *)
(*                                                                          *)
(*    The Extract a Substring of a String routine                           *)
(*    copies a substring of a source string into a                          *)
(*    destination string.                                                   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$right (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	start_position : INTEGER) : INTEGER; EXTERNAL;
 
(*    STR$ROUND                                                             *)
(*                                                                          *)
(*    Round or Truncate a Decimal String                                    *)
(*                                                                          *)
(*    The Round or Truncate a Decimal String routine                        *)
(*    rounds or truncates a decimal string to a specified number of         *)
(*    significant digits and places the result in another decimal string.   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$round (
	places : INTEGER;
	flags : UNSIGNED;
	asign : UNSIGNED;
	aexp : INTEGER;
	adigits : [CLASS_S] PACKED ARRAY [$l5..$u5:INTEGER] OF CHAR;
	VAR csign : [VOLATILE] UNSIGNED;
	VAR cexp : [VOLATILE] INTEGER;
	VAR cdigits : [CLASS_S,VOLATILE] PACKED ARRAY [$l8..$u8:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$TRANSLATE                                                         *)
(*                                                                          *)
(*    Translate Matched Characters                                          *)
(*                                                                          *)
(*    The Translate Matched Characters routine successively compares each character in a source string *)
(*    to all characters in a match string.  If a source character has a match, *)
(*    the destination character is taken from the translate string.  Otherwise, *)
(*    STR$TRANSLATE moves the source character to the destination string.   *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$translate (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	translation_string : [CLASS_S] PACKED ARRAY [$l3..$u3:INTEGER] OF CHAR;
	match_string : [CLASS_S] PACKED ARRAY [$l4..$u4:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
(*    STR$TRIM                                                              *)
(*                                                                          *)
(*    Trim Trailing Blanks and Tabs                                         *)
(*                                                                          *)
(*    The Trim Trailing Blanks and Tabs routine                             *)
(*    copies a source string to a destination string and deletes the        *)
(*    trailing blank and tab characters.                                    *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$trim (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR;
	VAR resultant_length : [VOLATILE] $UWORD := %IMMED 0) : INTEGER; EXTERNAL;
 
(*    STR$UPCASE                                                            *)
(*                                                                          *)
(*    Convert String to All Uppercase Characters                            *)
(*                                                                          *)
(*    The Convert String to All Uppercase Characters routine                *)
(*    converts a source string to uppercase.                                *)
(*                                                                          *)
 
[ASYNCHRONOUS] FUNCTION str$upcase (
	VAR destination_string : [CLASS_S,VOLATILE] PACKED ARRAY [$l1..$u1:INTEGER] OF CHAR;
	source_string : [CLASS_S] PACKED ARRAY [$l2..$u2:INTEGER] OF CHAR) : INTEGER; EXTERNAL;
 
END.
