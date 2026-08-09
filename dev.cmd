@echo off
REM Launch helper for the preview harness.
REM
REM The harness splits launch.json runtimeArgs on whitespace, so it cannot be
REM given a path containing spaces - this script is referenced by its 8.3 short
REM name instead. But "cd /d <shortpath>" leaves process.cwd() in 8.3 form, and
REM starting "next dev" from there makes libuv abort on the first file event:
REM   Assertion failed: !_wcsnicmp(filename, dir, dirlen), src\win\fs-event.c
REM (watched paths come back long and no longer match the registered prefix).
REM The batch path operators do NOT un-shorten a literal, so we resolve the
REM real long name below before starting the dev server.
REM
REM NOTE: keep CRLF line endings, and no percent signs in these comments -
REM cmd parses them as parameter substitutions even inside REM.
setlocal
set "PATH=C:\Program Files\nodejs;%PATH%"
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "(Get-Item -LiteralPath '%~dp0.').FullName"`) do cd /d "%%I"
call npm run dev -- --port 3100
