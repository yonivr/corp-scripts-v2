$datastores = Get-Datastore
foreach($ds in $datastores)
{
	$ds.name
	write-host "---"
	New-PSDrive -Name TgtDS -Location $ds -PSProvider VimDatastore -Root '\' | Out-Null
	(Get-ChildItem -Path TgtDS:  | where-object {$_.name -notcontains  "."} | select name).name
	Remove-PSDrive -Name TgtDS
}
