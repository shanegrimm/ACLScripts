<h1>Import CSV</h1>

It is possible to have an ACL Script (or an Analytic) automatically define a CSV file. But there are a lot of limitations still, some can be removed with further scripting.

<ul>
	<li>The file needs to be comma separated and use double-quotes as a text qualifier</li>
	<li>The field names need to be in the first row</li>
	<li>Length is currently hard coded to 250 (can be modified)</li>
	<li>Fields are created based on the longest value found in the data, this may take time to calculate on large CSV files and this part of code can be commented out if needed</li>
	<li>Fields are all created as ASCII text, user will need to modify data types. It may be possible to auto define the data types if the data is consistent but would require more scripting</li>
	<li>I’m using IMPORT FORMAT which is new in 10.5</li> 
	<li>My script is still pointing to the CSV file but it also creates a FIL file. Both files could be useable.</li>
</ul>

<h2>To run</h2>
<ol>
	<li>Copy scripts to a local folder</li>
	<li>Secify location of scripts with v_scriptpath</li>
	<li>Copy and paste following script into ACL and then run</li>
</ol>


<code>COMMENT *** Run Github script<br />
COMMENT *** My repository: https://github.com/shanegrimm/ACLScripts <br />
<br />
v_scriptpath = "S:\Import CSV"<br />
<br />
SET SAFETY OFF<br />
<br />
OPEN Metaphor_APTrans_2002<br />
<br />
DELETE SCRIPT ImportCSV OK<br />
DO "%v_scriptpath%\ImportCSV.bat"<br />
DELETE SCRIPT ImportCSV OK<br />
<br />
SET SAFETY ON<br />
</code>
