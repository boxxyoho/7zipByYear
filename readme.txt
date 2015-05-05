Powershell Script for Archiving Old Files
##Powershell file to run in Windows to zip contents that are found within a certain path based on year.## 

The script copies the files to the target directory and then removes the files for the original directory.
After the copy process completes, 7zip is called to archive the files and folders into a zip file and asks the 
user if they would like to delete the old contents from the temporary directory.

