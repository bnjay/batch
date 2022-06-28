# Batch comparison
If there are too many files to compare it is tedious to manually compare each other repeatedly. This batch tool can help reduce manual interactions.

Surely this can be written by many languages, but this is done so to minimise any extra installations and dependencies. This tool depends on DOS, WinMerge and Chrome.

A batch job will compare two files in a directory using WinMerge and creates a report in HTML. Only when a difference was found Chrome opens the Diff report. These steps are repeated against all other directories. If there are more than two files in a directory it will skip it. At the end of the process a number of checked directories is reported together with a number of skipped ones. The directory and file names can be conviniently specified to check only interested ones.

Note: If you compare Excel books you probably need to enable "automatic depoyment" in WinMerge first under "Plugin".
