
$xmlFilePath = "path\to\your\file.xml"
[xml]$xmlContent = Get-Content -Path $xmlFilePath
$feedback = $xmlContent.feedback

$reportMetadata = [PSCustomObject]@{
    OrgName = $feedback.report_metadata.org_name
    Email = $feedback.report_metadata.email
    ExtraContactInfo = $feedback.report_metadata.extra_contact_info
    ReportID = $feedback.report_metadata.report_id
    DateRangeBegin = [datetime]::FromFileTimeUtc($feedback.report_metadata.date_range.begin)
    DateRangeEnd = [datetime]::FromFileTimeUtc($feedback.report_metadata.date_range.end)
}

$policyPublished = [PSCustomObject]@{
    Domain = $feedback.policy_published.domain
    Adkim = $feedback.policy_published.adkim
    Aspf = $feedback.policy_published.aspf
    P = $feedback.policy_published.p
    Sp = $feedback.policy_published.sp
    Pct = $feedback.policy_published.pct
    Np = $feedback.policy_published.np
}

$records = $feedback.record | ForEach-Object {
    [PSCustomObject]@{
        SourceIP = $_.row.source_ip
        Count = $_.row.count
        Disposition = $_.row.policy_evaluated.disposition
        DKIM = $_.row.policy_evaluated.dkim
        SPF = $_.row.policy_evaluated.spf
        HeaderFrom = $_.identifiers.header_from
        DKIMDomain = $_.auth_results.dkim.domain
        DKIMResult = $_.auth_results.dkim.result
        DKIMSelector = $_.auth_results.dkim.selector
        SPFDomain = $_.auth_results.spf.domain
        SPFResult = $_.auth_results.spf.result
    }
}

$reportMetadata | Out-GridView -Title "Report Metadata"
$policyPublished | Out-GridView -Title "Policy Published"
$records | Out-GridView -Title "Records"