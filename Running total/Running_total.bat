COMMENT
  //ANALYTIC Running Total
    Create new table name RunningTotal_Output with a running total for a selected numeric field.
  //TABLE v_tablename Select table
  //FIELD v_numericfield N Select numeric field for running total
  //RESULT LOG
  //RESULT Table RunningTotal_Output
END

COMMENT *** ax_main is the temorary script created by AX when running analytics
COMMENT *** by testing to see if it is "U" undefined, you can tell if this script
COMMENT *** is running locally or on AX

IF FTYPE("ax_main") = "U" ACCEPT "Select Table" xf TO v_tablename

OPEN %v_tablename%

IF FTYPE("ax_main") = "U" ACCEPT "Select numeric field for running total" N TO v_numericfield

COUNT

v_runningtotal = 0.00

GROUP
  v_runningtotal = v_runningtotal + %v_numericfield%
  EXTRACT FIELDS ALL v_runningtotal as "RunningTotal" TO RunningTotal_Output
END

OPEN RunningTotal_Output
COUNT
TOTAL ALL
