::batchTee.bat  OutputFile  [+]
::
::  Write each line of stdin to both stdout and outputFile.
::  The default behavior is to overwrite any existing outputFile.
::  If the 2nd argument is + then the content is appended to any existing
::  outputFile.
::
::  Limitations:
::
::  1) Lines are limited to ~1000 bytes. The exact maximum line length varies
::     depending on the line number. The SET /P command is limited to reading
::     1021 bytes per line, and each line is prefixed with the line number when
::     it is read.
::
::  2) Trailing control characters are stripped from each line.
::
::  3) Lines will not appear on the console until a newline is issued, or
::     when the input is exhaused. This can be a problem if the left side of
::     the pipe issues a prompt and then waits for user input on the same line.
::     The prompt will not appear until after the input is provided.
::
::  4) Attempting to abort the piped commands will lock up the console. Ouch!
::

@echo off
if "%~1" equ ":tee" goto :tee

setlocal disableDelayedExpansion
:lock
set "teeTemp=%temp%\tee%time::=_%"
2>nul (
  9>"%teeTemp%.lock" (
    (find /n /v ""&echo END) >"%teeTemp%.tmp" | <"%teeTemp%.tmp" "%~f0" :tee %*
    (call )
  ) || goto :lock
)
del "%teeTemp%.lock" "%teeTemp%.tmp"
exit /b

:tee
setlocal enableDelayedExpansion
set "redirect=>"
if "%~3" equ "+" set "redirect=>>"
8%redirect% %2 (
  for /l %%. in () do (
    set "ln="
    set /p "ln="
    if defined ln (
      if "!ln:~0,3!" equ "END" exit
      set "ln=!ln:*]=!"
      (echo(!ln!)
      (echo(!ln!)>&8
    )
  )
)
