SET SESSION "ReportVarMulti"
SET SAFETY OFF

COMMENT
  ***********************************************************
  Create a new table that moves descriptions from multiple
  lines into a single line.
  ***********************************************************
END

COMMENT *** BEGIN IMPORT ***
COMMENT *** Import Sample File, replace this with whatever you want
	v_tmpscriptpath     = "%v_scriptpath%"
	v_scriptpath        = "S:\Import CSV"
	v_FileName          = "S:\Report variable multiline\SampleData.csv"
	v_Output            = "tmp_Import"
	v_Recordlength      = "250"
	
	DELETE BATCH ImportCSV OK
	DO "%v_scriptpath%\ImportCSV.BAT"
	DELETE BATCH ImportCSV OK
	
	v_scriptpath        = "%v_tmpscriptpath%"
	DELETE v_tmpscriptpath OK
	v_field             = "description"
	v_field_blank       = "code"
	v_output            = "ReportVarMulti_output"
COMMENT *** End of Import Sample File

COMMENT *** BEGIN VALIDATION ***
COMMENT *** Consider creating a standardized log file of the import along with control totals and unique values
COMMENT *** Can we re-use the same validation scripts for most of our imports? What if multiple files have been imported?

COMMENT *** BEGIN TEST ***
SET SESSION "ReportVarMulti"
SET SAFETY OFF

OPEN tmp_Import

COMMENT *** Prompt for input (v_field, v_field_blank and v_output)
v_validate = F
DELETE SCRIPT ReportVarMulti_B01 OK
DO "%v_scriptpath%\ReportVarMulti_B01.BAT" WHILE v_validate = F
DELETE SCRIPT ReportVarMulti_B01 OK
DELETE v_validate OK

DELETE v_test1    OK
DELETE v_test2    OK 

DEFINE FIELD c_field_line2 COMPUTED
AS "temp"
ALLTRIM( %v_field% ) + "; " + ALLTRIM( RECOFFSET( %v_field%, 1 )) IF ISBLANK( RECOFFSET( %v_field_blank%, 1 ) ) AND NOT ISBLANK( RECOFFSET( %v_field%, 1 )) 
%v_field%

DEFINE FIELD c_field_line3 COMPUTED
AS "temp"
ALLTRIM( c_field_line2 ) + "; " + ALLTRIM( RECOFFSET( %v_field%, 2 )) IF ISBLANK( RECOFFSET( %v_field_blank%, 2 ) ) AND NOT ISBLANK( RECOFFSET( %v_field%, 2 ))
%v_field%

DEFINE FIELD c_field_line4 COMPUTED
AS "%v_field%"
ALLTRIM( c_field_line3 ) + "; " + ALLTRIM( RECOFFSET( %v_field%, 3 )) IF ISBLANK( RECOFFSET( %v_field_blank%, 3 ) ) AND NOT ISBLANK( RECOFFSET( %v_field%, 3 ))
%v_field%

EXTRACT FIELDS ALL TO %v_output% IF NOT ISBLANK( %v_field_blank% )
OPEN %v_output%

DELETE FIELD %v_field%                  OK
DELETE FIELD c_field_line2              OK
DELETE FIELD c_field_line3              OK
RENAME FIELD c_field_line4 TO %v_field% OK

COMMENT *** Clean up

COMMENT DELETE FORMAT tmp_Import OK
COMMENT DELETE tmp_Import.FIL    OK 
DELETE v_field                   OK
DELETE v_field_blank             OK
DELETE v_output                  OK
DELETE v_scriptpath              OK
DELETE v_FileName                OK
DELETE v_TableName               OK

SET SESSION
SET SAFETY ON
