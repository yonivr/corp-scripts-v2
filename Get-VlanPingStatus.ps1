$subnet = "10.20.144"
$start=10
$end=252
while ($start -le $end) 
{
	$IP="$subnet.$start"
	Write-Host "Pinging $IP....." -ForegroundColor Cyan -NoNewline
	if(Test-Connection -ComputerName $IP -count 1 -Quiet){
		write-host "True" -ForegroundColor green
		}
	else{
		write-host "False" -ForegroundColor red
		}
	$start++
}
