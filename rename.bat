@echo off
rem This file was created by pub v3.4.4.
rem Package: rename
rem Version: 3.0.2
rem Executable: rename
rem Script: rename
if exist "C:\Users\ahmda\AppData\Local\Pub\Cache\global_packages\rename\bin\rename.dart-3.4.4.snapshot"                                                                                                                                                                         (
  call dart "C:\Users\ahmda\AppData\Local\Pub\Cache\global_packages\rename\bin\rename.dart-3.4.4.snapshot"                                                                                                                                                                         %*
  rem The VM exits with code 253 if the snapshot version is out-of-date.
  rem If it is, we need to delete it and run "pub global" manually.
  if not errorlevel 253 (
    goto error
  )
  call dart pub global run rename:rename %*
) else (
  call dart pub global run rename:rename %*
)
goto eof
:error
exit /b %errorlevel%
:eof
