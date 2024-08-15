# Get the root folder path
$rootFolder = "<path to the root folder>"

# Get all the folders and subfolders in the root folder
$folders = Get-ChildItem -Path $rootFolder -Recurse | Where-Object { $_.PSIsContainer }

# Export the list to a CSV file
$folders | Select-Object FullName | Export-Csv -Path "folders.csv" -NoTypeInformation