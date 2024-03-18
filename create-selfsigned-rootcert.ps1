$params = @{
    Type = 'Custom'
    Subject = 'CN=Webland AB Root CA'
    KeySpec = 'Signature'
    KeyExportPolicy = 'Exportable'
    KeyUsage = 'CertSign'
    KeyUsageProperty = 'Sign'
    KeyLength = 4096
    HashAlgorithm = 'sha256'
    NotAfter = (Get-Date).AddMonths(48)
    CertStoreLocation = 'Cert:\CurrentUser\My'
}
$cert = New-SelfSignedCertificate @params