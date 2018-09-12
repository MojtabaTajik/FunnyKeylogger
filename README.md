# FunnyKeylogger

FunnyKeylogger is very clear to understand and i think lightest Keylogger ever written. Do you ever see keylogger for just 2KB of size ?! maybe :)

The code written in C# language using standard Windows API calls.

.Net executables is very light in size because of underlying architecture of .Net framework 
which install prerequisite files in end user machine and no need to embed extra metadata, headers
and codes in final executable file.

but even in .Net framework minimum size of executable is about ~5KB, so what happen here for FunnyKeylogger ?!

The trick is here, .Net classes could be called using PowerShell scripts like FunnyKeylogger do it, in this way the code still raw text wich translated by .Net CLI in memory at runtime. 
So by this trick 2kb is not surprising ;)

PowerShell scripts is restricted by default in Windows which let user just run signed scripts or scripts which comes from trusted source, so our script could not run by default PowerShell configuration.

Here is three steps to run FunnyKeylogger :

	- Run PowerShell as administrator
	- Run "Set-ExecutionPolicy Unrestricted"
	- Run the script by right click on it and select "Run with PowerShell" or command line
	
This is code born from a few minutes of my free times and will be improved in the future.
