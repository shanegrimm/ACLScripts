SET SESSION TO ExtractFirstMatches
CLOSE PRIMARY SECONDARY
SET SAFETY OFF

v_numbermatches = '25'
v_filter        = 'region = "05"'
v_inputtable    = 'Transactions'
v_outputtable   = 'Test_FirstMatches'

OPEN %v_inputtable%

v_counter = 1

GROUP WHILE v_counter <= %v_numbermatches%
  IF %v_filter% v_counter = v_counter + 1 AND %v_filter%
  EXTRACT FIELDS ALL TO %v_outputtable% IF %v_filter%
END

OPEN %v_outputtable%
SET SAFETY ON
SET SESSION