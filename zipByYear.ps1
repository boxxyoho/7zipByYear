<#
Created by Chris Box
Date - May 5th 2014
Used to archive old files on server storage to temporary or archived storage locations.
#>

#Assign variables based on user input
$year = Read-Host "What year do you want to archive?"
$source = Read-Host "Where is the source? "
$target = Read-Host "Where would you like the archive to be created? "
$temp = $target
$target = "$target\$year"

#get list of folders and files in necessary directories
$files = get-childitem $source -Recurse

#for loop to go through each file individually
foreach ($file in $files)
{
    #checks to see if the file's last accessed date is within the assigned date
	if (($file.LastWriteTime -ge (get-date 01/01/$year)) -and ($file.LastWriteTime -le (get-date 12/31/$year)))
    {
        #if the folder is not a directory, we ignore it and just copy the files
		if ($file.Attributes -ne 'Directory' )
		{
			$targetFile = $target + $file.FullName.SubString($source.Length)
			New-Item -ItemType File -Path $targetFile -Force
			Copy-Item $file.FullName -destination $targetFile
			Remove-Item $file.FullName
		}
    }
}
#7zips the files
.\7za.exe a -tzip $temp\$year.zip $target\* -mx5

Write-host "The files have been temporarily copied to $target and they have been deleted from the original source"

$answer = Read-Host "Would you like to Delete the Original Files? (Y/N) "
if ($answer -eq "Y") 
{
	#Removes all the files from the temporary directory
	Remove-Item $target -Force -Recurse
}
Write-host "The process has been completed. You can find a .zip file named $year.zip under $temp"