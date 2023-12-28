# from : bard.google.com && https://github.com/isantoshgyawali/

#--------------------
#  packagesToRemove  |
#--------------------

$packagestoremove = @(

	"Microsoft.3DBuilder"
	"Microsoft.BingFinance"
	#.......................

)

$installedPackagesToRemove = $packagestoremove | ForEach-Object { Get-AppxPackage -Name $_ -AllUsers }

if ($installedPackagesToRemove) {
	Write-Host "#---------------------------------------------#"
	Write-Host "|    Installed packages/Services in system    |"
	Write-Host "#---------------------------------------------#"

	$installedPackagesToRemove | Format-Table Name, PackageFullName --AutoSize
	
	$confirm = Read-Host "Throw the junk out of windows? (ofc/no)"

	if ($confirm -eq "Y" -or $confirm -eq "y" -or $confirm -eq "ofc") {

		$installedPackagesToRemove | Remove-AppxPackage
		Write-Host "Junk Clean Successful!"
  
	} 
    
    else {
    	Write-Host "Packages removal aborted"
	}

} 
else {
	Write-Host "None of Packages/Services are available in the system"
}
