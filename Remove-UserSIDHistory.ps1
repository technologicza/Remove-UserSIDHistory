## created by Jean Louw and Chris Bishop
## Please note that you run this code at your own risk
 
 $AllSIDUsers = gc .\SIDUsers.txt

foreach ($User in $AllSIDUsers){

$UserValue = $User

$SIDValues = (Get-ADUser -Identity $UserValue -Properties SidHistory | Select-Object -ExpandProperty SIDHistory).Value

if ($SIDValues -ne $null){

foreach ($Value in $SIDValues){
Write-Host "..removing" $Value "from" $UserValue -ForegroundColor Red
Set-ADUser -Identity $UserValue -Remove @{SIDHistory=$Value}
}
}

else{
Write-Host "..skipping" $UserValue "as it has no SIDHistory" -ForegroundColor Green
}
If (Test-Path variable:UserValue){Remove-Variable UserValue}
If (Test-Path variable:Value){Remove-Variable Value}
If (Test-Path variable:SIDValues){Remove-Variable SIDValues}
}
