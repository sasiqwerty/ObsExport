# Set the folder names you want to search for and delete (separated by commas)
$targetFolderNames = "applications,dailynote,openai,podcasts,powershell,youtube,obsidian,interviews"

# Convert the target folder names to an array
$targetFolders = $targetFolderNames -split ','

# Get a list of all folders with the specified names in the current directory and its subdirectories
$foldersToDelete = Get-ChildItem -Path "C:\Users\sarat\OneDrive\Desktop\ObsExport" -Recurse |
    Where-Object { $_.PSIsContainer -and $targetFolders -contains $_.Name }

# Check if any matching folders were found
if ($foldersToDelete.Count -eq 0) {
    Write-Host "No folders with the specified names found."
}
else {
    Write-Host "Folders with the specified names found:"

    # Print the names of the matching folders
    foreach ($folder in $foldersToDelete) {
        Write-Host $folder.FullName
    }

    # Ask for confirmation before deleting the folders
    $confirmation = Read-Host "Do you want to delete these folders? (Y/N)"
    if ($confirmation -eq "Y" -or $confirmation -eq "y") {
        # Delete the folders and their contents
        $foldersToDelete | Remove-Item -Recurse -Force
        Write-Host "Folders deleted successfully."
    }
    else {
        Write-Host "Folders were not deleted."
    }
}
pause
