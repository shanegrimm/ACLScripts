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

CLOSE PRIMARY SECONDARY

COMMENT *** Create stub file since ACL requires a table to be open
DIRECTORY *.acl TO t_stub
OPEN t_stub

v_TableName = REVERSE( SPLIT( REVERSE( v_Filename ), "\", 1 ) ) 
DELETE "%v_TableName%.FMT" OK

LIST UNFORMATTED "FILE_NAME '%v_Filename%'"                            TO "%v_TableName%.FMT" IF RECNO() = 0 EOF APPEND
LIST UNFORMATTED " "                                                   TO "%v_TableName%.FMT" IF RECNO() = 0 EOF APPEND
LIST UNFORMATTED "RECORD_LENGTH %v_Recordlength% SKIP 0 ASCII CRLF"    TO "%v_TableName%.FMT" IF RECNO() = 0 EOF APPEND
LIST UNFORMATTED "v_line         ASCII       1  %v_Recordlength%    "  TO "%v_TableName%.FMT" IF RECNO() = 0 EOF APPEND

COMMENT *** Import emtpy format file (FMT) with v_TableName 
IMPORT FORMAT "%v_TableName%.FMT" TO %v_TableName%
OPEN "%v_Filename%" FORMAT "%v_TableName%"
DELETE "%v_TableName%.FMT" OK

COMMENT *** Grab all field names from first row
COMMENT *** Create the computed fields for each field using SPLIT()
COMMENT *** Generate v_fieldlist to contain a list of all fields found

v_columns   = OCCURS(v_line, ",") + 1
v_count     = 1
v_fieldlist = BLANKS(500)

DELETE SCRIPT ImportCSV_B01 OK
DO "%v_scriptpath%\ImportCSV_B01" WHILE v_count <= v_columns
DELETE SCRIPT ImportCSV_B01 OK

COMMENT *** Extract all of the fields to new table... maybe not required?
EXTRACT FIELDS %v_fieldlist% TO "%v_output%" IF RECNO() > 1
OPEN %v_output% 

COMMENT ***  Cleanup all temporary files and variables

DELETE FORMAT t_stub  OK
DELETE t_stub.FIL     OK
DELETE v_columns      OK
DELETE v_count        OK
DELETE v_fieldlist    OK
DELETE v_fieldname    OK
DELETE v_RecordLength OK
DELETE v_Table        OK

SET SAFETY ON
SET SESSION