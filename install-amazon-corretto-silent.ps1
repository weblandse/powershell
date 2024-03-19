# Test if path exists (c:\temp)
if (!(Test-Path -Path "c:\temp")) {
    New-Item -ItemType Directory -Path "c:\temp"
}
# Download the file
$wc = New-Object net.webclient
$wc.Downloadfile("https://corretto.aws/downloads/latest/amazon-corretto-11-x64-windows-jdk.msi", "c:\temp\amazon-corretto-11-x64-windows-jdk.msi")

# Install the msi
Start-Process -FilePath "msiexec" -ArgumentList "/i c:\temp\amazon-corretto-11-x64-windows-jdk.msi /quiet /qn /norestart /log c:\temp\correttolog.txt" -Wait -Passthru

# Clean up
Remove-Item -Path "c:\temp\amazon-corretto-11-x64-windows-jdk.msi"

