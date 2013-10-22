COMMENT
  ***********************************************************
  Script called by ReportVarMulti WHILE v_validate = F
  ***********************************************************
END

COMMENT ***  (Enhancement) Replace with DIALOG command
ACCEPT "Select character field with text flowing on multiple lines" FIELDS "C" TO v_field
ACCEPT "Select character field that is blank when text field flows onto multiple lines" FIELDS "C" TO v_field_blank
ACCEPT "Enter output table name" TO v_output

COMMENT *** Ensure no extended characters in output filename
v_clean_output = EXCLUDE( UPPER( v_output ), "ABCDEFGHIJKLMNOPQRSTUVWXYZ01234556789_" )
v_test1 = F
v_test1 = T IF ISBLANK( v_clean_output )
DELETE v_clean_output OK
IF NOT v_test1 PAUSE "Ensure there are no extended characters in the filename"

COMMENT *** Test to ensure all values are selected
v_test2 = F
v_test2 = T IF NOT ISBLANK( v_field ) AND NOT ISBLANK( v_field_blank ) AND NOT ISBLANK( v_output )

IF v_test1 AND v_test2 v_validate = T