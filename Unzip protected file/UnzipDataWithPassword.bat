CLOSE PRIMARY SECONDARY
SET SAFETY OFF
SET SESSION TO UnzipDataWithPassword

COMMENT *** Folder where 7za.exe can be found
COMMENT *** Files can be downloaded from here http://www.7-zip.org/download.html 
v_appsdir = "C:\ACL DATA\AN10 Demo\apps\"

COMMENT *** Folder where zip file can be found and where output will be sent
v_datadir = "C:\ACL DATA\AN10 Demo\"

COMMENT *** Prompt for filename
ACCEPT "Enter filename for zip file (data_encrypted.zip)" TO v_filename

COMMENT *** Prompt for zip file password
ACCEPT "Enter password for zip file (superuser)" TO v_pass4zip

COMMENT *** Use 7zip to extract contents of data.zip to the v_datadir
EXECUTE '"%v_appsdir%7za.exe" e "%v_datadir%%v_filename%" -o"%v_datadir%" -p"%v_pass4zip%" *.xls -y' 

COMMENT *** If return code is anything but 0, there was an issue. Notify user.
COMMENT *** 7-zip return codes are (0 no error, 1 warning, 2 fatal, 7 command line, 8 not enough memory, 255 user stopped process) Source: http://sevenzip.sourceforge.jp/chm/cmdline/exit_codes.htm 
IF RETURN_CODE <> 0 DISPLAY VARIABLES
IF RETURN_CODE <> 0 PAUSE "Error unzipping file"

SET SAFETY ON
SET SESSION
