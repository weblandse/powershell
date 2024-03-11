# Initilize variables
$row = 0
$dummyPath = "C:\temp\DUMMY\"
# Set backup location
$backupPath = "C:\temp\BOKSLUT\"
# Location and name of BOKSLUT.INI
$iniFile = "Bokslut.ini"
$iniPath = "PATH WHERE BOKSLUT.INI IS LOCATED"
# Test if dummy folder exists, if not create it
if (!(Test-Path -path $dummyPath)) {
    New-Item -ItemType Directory -Force -Path $dummyPath
}
# Check if $backupPath\linebackup.txt exists
if (Test-Path -path "$backupPath\linebackup.txt") {
    # Check if $backupPath\linebackup.txt is empty
    if ((Get-Content "$backupPath\linebackup.txt") -eq "") {
        Write-Host "linebackup.txt exists but is empty. This means something is wrong. Aborting"
    } else {
        Write-Host "linebackup.txt is not empty"
        # Backup BOKSLUT.INI
        # Test if backup folder exists, if not create it
        if (!(Test-Path -path $backupPath)) {
            New-Item -ItemType Directory -Force -Path $backupPath
        }
        #Try copy file, if file already exists, overwrite it
        Copy-Item -Path "$iniPath\$iniFile" -Destination ($backupPath+"Bokslut_backup_"+(Get-Date -Format "yyyy_MM_dd_HH_mm_ss")+".ini")
        # Catch error if file does not exist
        if ($?) {
            Write-Host "Backup of $iniFile successful"
            # Get the row containing "DataFiler" in BOKSLUT.INI and replace the path with the path to the original folder
            $filecontent = get-content $iniPath\$iniFile -ReadCount 1000
            # Get original line from linebackup.txt
            $originalLine = Get-Content "$backupPath\linebackup.txt"

            foreach ($line in $filecontent) {
                $row++
                if ($line -match "DataFiler") {
                    # Backup the original line to backup path to a textfile 
                    $filecontent[$row-1] = $originalLine
                    $filecontent | Set-Content $iniPath\$iniFile
                    Write-Host "Row $row changed to $originalLine"
                    Remove-item "$backupPath\linebackup.txt"
                    break
                }
            
            }
        } else {
            Write-Host "Backup of $iniFile failed. Aborting"
        }
    }
} else{
    # Backup BOKSLUT.INI
    # Test if backup folder exists, if not create it
    if (!(Test-Path -path $backupPath)) {
        New-Item -ItemType Directory -Force -Path $backupPath
    }
    #Try copy file, if file already exists, overwrite it
    Copy-Item -Path "$iniPath\$iniFile" -Destination ($backupPath+"Bokslut_backup_"+(Get-Date -Format "yyyy_MM_dd_HH_mm_ss")+".ini")
    # Catch error if file does not exist
    if ($?) {
        Write-Host "Backup of $iniFile successful"
        # Get the row containing "DataFiler" in BOKSLUT.INI and replace the path with the path to the dummy folder
        $filecontent = get-content $iniPath\$iniFile -ReadCount 1000
        foreach ($line in $filecontent) {
            $row++
            if ($line -match "DataFiler") {
                # Backup the original line to backup path to a textfile 
                $line | Out-File -FilePath "$backupPath\linebackup.txt"
                $filecontent[$row-1] = "DataFiler=$dummyPath"
                $filecontent | Set-Content $iniPath\$iniFile
                Write-Host "DataFiler path changed to $dummyPath"
                break
            }
        
        }
    } else {
        Write-Host "Backup of $iniFile failed. Aborting"
    }

}

