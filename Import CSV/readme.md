<h1>Import CSV</h1>

It is possible to have an ACL Script (or an Analytic) automatically define a CSV file. But there are a lot of limitations still, some can be removed with further scripting.

<ul>
	<li>The file needs to be comma separated and use double-quotes as a text qualifier</li>
	<li>The field names need to be in the first row</li>
	<li>Length is currently hard coded to 250 (can be modified)</li>
	<li>Fields are created based on the longest value found in the data, this may take time to calculate on large CSV files and this part of code can be commented out if needed</li>
	<li>Fields are all created as ASCII text, user will need to modify data types. It may be possible to auto define the data types if the data is consistent but would require more scripting</li>
	<li>This uses an undocumented feature, "IMPORT FORMAT" which will be changed to "IMPORT LAYOUT" in a future release.</li> 
	<li>My script is still pointing to the CSV file but it also creates a FIL file. Both files could be useable.</li>
</ul>

<h2>To run</h2>
<ol>
	<li>Copy scripts to a local folder</li>
	<li>Secify location of scripts with v_scriptpath</li>
	<li>Copy and paste following script into ACL and then run</li>
</ol>


    COMMENT *** Run Github script
    COMMENT *** My repository: https://github.com/shanegrimm/ACLScripts
    
    v_scriptpath   = "S:\Import CSV"
    v_filename     = "S:\Import CSV\Employees.csv"
    v_recordlength = "250"
    v_output       = "ResultTableName"
    
    SET SAFETY OFF
    
    OPEN Metaphor_APTrans_2002
    
    DELETE SCRIPT ImportCSV OK
    DO "%v_scriptpath%\ImportCSV.bat"
    DELETE SCRIPT ImportCSV OK

    COMMENT *** Cleanup variables
    DELETE v_scriptpath   OK
    DELETE v_filename     OK
    DELETE v_recordlength OK
	DELETE v_output       OK
    
    SET SAFETY ON

