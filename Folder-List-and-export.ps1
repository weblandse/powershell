# Get the root folder path
$rootFolder = "C:\temp"

# Get all the folders and subfolders in the root folder
$folders = Get-ChildItem -Path $rootFolder -Recurse | Where-Object { $_.PSIsContainer }

#Split into to collumns, first root folder and second subfolder
$folders | Select-Object @{Name="RootFolder";Expression={$rootFolder}}, @{Name="SubFolder";Expression={$_.FullName -replace [regex]::Escape($rootFolder), ""}} | Export-Csv -Path "folders.csv" -NoTypeInformation