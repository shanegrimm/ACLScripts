SET SESSION "ImportCSV"
SET SAFETY OFF

COMMENT
  ***********************************************************
  An attempt to auto define a delimited file using a script.
  - Determine record length (NOT DONE YET)
  - Define a new table with field v_line for the entire record length
  - Define a new field for each value found and set proper length
  - Re-define fields with correct data type (NOT DONE YET)
  Requires AN10.5 because of IMPORT FORMAT command 
  ***********************************************************
END

COMMENT 
  ***********************************************************
  Create a new ACL Table with a name of v_Table and a length of 
  v_Recordlength by creating .FMT and opening CSV with the new FMT.
  If not using AN10.5 same can be done by using t_stub and defining
  v_line as a computed field with BLANKS(%v_Recordlength%) and
  then extrating v_line to a new table then relinking to the csv
  ***********************************************************
END

COMMENT *** Create stub file since ACL requires a table to be open
DIRECTORY *.acl TO t_stub
OPEN t_stub

v_Table = "Employees"
v_Recordlength = "250" 

DELETE %v_Table%.FMT OK

LIST UNFORMATTED "FILE_NAME '%v_Table%.CSV'"                           TO %v_Table%.FMT IF RECNO() = 0 EOF APPEND
LIST UNFORMATTED " "                                                   TO %v_Table%.FMT IF RECNO() = 0 EOF APPEND
LIST UNFORMATTED "RECORD_LENGTH %v_Recordlength% SKIP 0 ASCII CRLF"    TO %v_Table%.FMT IF RECNO() = 0 EOF APPEND
LIST UNFORMATTED "v_line         ASCII       1  %v_Recordlength%    "  TO %v_Table%.FMT IF RECNO() = 0 EOF APPEND


IMPORT FORMAT "%v_Table%.FMT" TO %v_Table%
OPEN "%v_Table%.csv" FORMAT "%v_Table%.FMT"

COMMENT *** Grab all field names from first row
COMMENT *** Create the computed fields for each field using SPLIT()
COMMENT *** Generate v_fieldlist to contain a list of all fields found

v_columns   = OCCURS(v_line, ",") + 1
v_count     = 1
v_fieldlist = BLANKS(500)
f_qualifier = F

DELETE SCRIPT ImportCSV_B01 OK
DO "%v_scriptpath%\ImportCSV_B01" WHILE v_count <= v_columns
DELETE SCRIPT ImportCSV_B01 OK

COMMENT *** Extract all of the fields to new table... maybe not required?
EXTRACT FIELDS %v_fieldlist% TO "Test"
OPEN Test

COMMENT 
  ***********************************************************
  Cleanup all temporary files and variables
  ***********************************************************
END

DELETE FORMAT t_stub OK
DELETE t_stub.FIL OK

SET SAFETY ON
SET SESSION