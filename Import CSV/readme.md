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
