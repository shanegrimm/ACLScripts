COMMENT *** v_columns contains number of columns in csv
COMMENT *** v_count will cause this script to repeat while <= v_columns

v_fieldname   = SPLIT(v_line, ",", %v_count% )

COMMENT *** Create temp computed field for each column
DEFINE FIELD t_%v_fieldname% COMPUTED SPLIT(v_line, ",", %v_count%, '"' )

COMMENT *** Calculate maximum length of each column 
COMMENT *** MAX1 variable from Statistics command will be maximum length
DEFINE FIELD t_length COMPUTED LENGTH( ALLTRIM( t_%v_fieldname% ) )
STATISTICS ON t_length TO SCREEN NUMBER 1

COMMENT *** Create real field with correct length and delete tmp field
DEFINE FIELD %v_fieldname% COMPUTED SUBSTRING( SPLIT(v_line, ",", %v_count%, '"' ), 1, %MAX1% )
DELETE FIELD t_length        OK 
DELETE FIELD t_%v_fieldname% OK

COMMENT *** Generate a list of fields encountered for EXTRACT or REPORT
v_fieldlist   = ALLTRIM(v_fieldlist) + " " + "%v_fieldname%"

v_count = v_count + 1