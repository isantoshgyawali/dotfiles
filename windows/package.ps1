# from : bard.google.com && https://github.com/isantoshgyawali/

#--------------------
#  packagesToRemove  |
#--------------------

$packagestoremove = @(

	"Microsoft.3DBuilder"
	"Microsoft.BingFinance"
	#.......................

)

Write-Host #---------------------------------------------#
Write-Host |    Installed packages/Services in system    |
Write-Host #---------------------------------------------#

$installedPackagesToRemove = Get-Appxpackage -Name $packagestoremove -AllUsers

if($installedPackagesToRemove){

	$installPackagesToRemove | Format-Table Name , PackageFullName --AutoSize
	
	$confirm = Read-Host "Throw the junk out of windows?(ofc/no)"

	if($confirm -eq "Y" -or $confirm -eq "y" -or $confirm -eq "ofc"){
		
		$installedPackagesToRemove | Remove-Appxpackage
		Write-Host "Junk Clean Successfull!"

	}
	
	else {
		Write-Host "Packages removal aborted"
	}

} else {

	Write-Host "None of Packages/Services are available in the system"
}