<h1>Report variable multiline</h1>
<p>Sometimes report files will have text fields (usually description fields) that may start flowing into additional lines in a report. Unfortunately, some records may have one line per record and others may have multiple lines because of this text field.<p>
<p>For example:</p>
    code description                 amount
    0004 The single line record      321.12
    0005 The multi line record        83.21
         that wraps onto multiple 
         lines
    0006 Another single line record   21.21
    0007 Another single line record  121.12
<p>Prompt user for field to correct. Use RECOFFSET() to detect wrapping. Create a new table with lines combined, to look like:</p>
    code description                                               amount
    0004 The single line record                                    321.12
    0005 The multi line record that wraps onto multiple lines       83.21
    0006 Another single line record                                 21.21
    0007 Another single line record                                121.12
<p>Since we need to expand the width of the description field we will need to consider the maximum number of lines that a single record could consume and multiply the width of the original description field by that value. We could then determine what record has the longest description and set the width to that. Or alternatively, we could send to CSV and re-import.</p>