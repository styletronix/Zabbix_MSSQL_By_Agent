Param(
    [Parameter(Mandatory=$True)][string]$action,
     [Parameter(Mandatory=$true)][string]$param1,
     [Parameter(Mandatory=$false)][string]$param2,
    [Parameter(Mandatory = $false)][string]$param3,
    [Parameter(Mandatory = $false)][string]$param4,
    [Parameter(Mandatory = $false)][string]$param5
)

$OutputEncoding = [System.Text.Encoding]::UTF8

$sql = Get-Content -Path ($PSScriptRoot + "\" + $action + ".sql") -raw

if ($param1 -ne $null){
    $sql = $sql.Replace('{$MSSQL.INSTANCE}',$param1.ToString())
}
if ($param2 -ne $null){
    $sql = $sql.Replace('{$MSSQL.PARAM2}',$param2.ToString())
}
if ($param3 -ne $null) {
    $sql = $sql.Replace('{$MSSQL.PARAM3}', $param3.ToString())
}
if ($param4 -ne $null) {
    $sql = $sql.Replace('{$MSSQL.PARAM4}', $param4.ToString())
}
if ($param5 -ne $null) {
    $sql = $sql.Replace('{$MSSQL.PARAM5}', $param5.ToString())
}

#$sql
$queryResult = Invoke-Sqlcmd -OutputAs DataTables -query $sql
$json = ($queryResult | Select-Object $queryResult.Columns.ColumnName | ConvertTo-Json -Compress)
$json -replace '(\s+)\"','"'