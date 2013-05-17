COMMENT *** This requires AN10 or higher
COMMENT *** Also consider WAITFOR to send or wait for a signal from another computer

SET SESSION Test Timeout

COMMENT *** Pause for 10 seconds or until key is pressed

DISP TIME()
EXECUTE "TIMEOUT /t 10"
DISP TIME()

COMMENT *** Pause for 10 seconds, no option to press key to bypass
COMMENT *** User still has option to press Ctrl+C to quit

DISP TIME()
EXECUTE "TIMEOUT /t 10 /nobreak"
DISP TIME()

COMMENT *** Pause until a key is pressed (Don't use with AX)

EXECUTE "TIMEOUT /t -1"

SET SESSION
