# This script checks the file hash for keepass against the txt record from hash.webland.se
$ValidHash= ""
$ValidHash= "BC86C00BE3A725DFAECC6144A5B1C9FD4A821AE24A86AB00E9EAFD318FB6DE69"
if ($ValidHash -eq (Get-FileHash -Path \\path\to\the\installer.exe).Hash){
    Write-Host "Valid Keepass-installer" -ForegroundColor Green
}else {
    Write-Host "Invalid KeePass-installer. Check your source!" -ForegroundColor Red
}