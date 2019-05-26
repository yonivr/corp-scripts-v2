connect-viserver buch-vc.sparkware.corp
#$vms  = Get-Cluster corp-cls | Get-VM 
$vms = Get-VM
#$winvms += $vms  | Where-Object {$_.Guest -like "*windows*"}
$winvms = $qavvms
#$vms  = Get-Cluster dev-cls | Get-VM 
#$winvms += $vms  | Where-Object {$_.Guest -like "*windows*"}

$resultCSV = "RecentUserFolderSPW3.csv"
$DirObjectCollection =@()
$FaildDirObjectCollection = @()
$winvms  |ForEach-Object {
    $ServerName = $_.guest.HostName
    $OS = $_.guest.OSFullName
	$ServerName
    if(Test-path "\\$ServerName\c$\users")
    {
        $Directory = Get-ChildItem \\$ServerName\c$\users | Sort-Object LastWriteTime -Descending |Where-Object {$_.name -notlike "*temp*"}  | Select-Object -First 2

        foreach($dir in $Directory)
        {
            [hashtable]$objectProperty = @{}
            $objectProperty.Add('Folder',$Dir.Name)
            $objectProperty.Add('LastAccessTime',$Dir.LastAccessTime)
            $objectProperty.Add('Server',$ServerName)
            $objectProperty.Add('OS', $OS)
            $DirObject = New-Object -TypeName psobject -Property $objectProperty
            $DirObjectCollection+=$DirObject 
            $DirObject
        }
    }
    else
    {
        write-host "error for $_"
        $FaildDirObjectCollection += $ServerName
    }
}
$DirObjectCollection | select-object folder,LastAccessTime,Server,OS  |export-csv $resultCSV
write-host $FaildDirObjectCollection -ForegroundColor Red



