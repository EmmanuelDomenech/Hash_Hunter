<# Script: Hash_Hunter 
   Dev:Emmanuel Domenech  
    
   The Hash_Hunter will collect hash algorithm on a local and remote system. 
   The script will prompt the user to provide a remote system name, the target file or directory,  
   the desire hash function and the location on where to save the results. Once complete it will generate a .csv file  
   and copied into the location specified by the user for analysis. 
    
   Note: The script can be used to collect the hash value of multiple files present on a directory with multiple levels of subfolders (*.*):  
    
   \\Remote machine name\c$\Users\Luke.Skywalker.ctr\Desktop\folder name\*.* #> 
 
Param( 
      [Parameter(Mandatory)][string]$ComputerName, #Remote machine name 
      [Parameter(Mandatory)][string]$TargetFile, #Complete file path on remote machine (\\Remote machine name\c$\Users\Luke.Skywalker\Desktop\filename.csv) 
      [Parameter(Mandatory)][ValidateSet('MD5','SHA1','SHA256','SHA384','SHA512')][string]$Algorithm, #Provide Hash algorithm (MD5, SHA1,SHA256,SHA384,SHA512) 
      [Parameter(Mandatory)][string]$TargetSave #Complete file path on local machine (\\Local machine name\c$\Users\Luke.Skywalker\Desktop\filename.csv) 
      ) 
if (!(Test-Path $TargetFile)) {Write-Warning "$TargetFile not found, please verify path." } 
else { 
    Write-Host "Get Ready!!!" 
    }   
if (!(Test-Connection $ComputerName)) { Write-Warning "$ComputerName is unreachable..." } 
else { 
    Write-Host "Running Script on $ComputerName..." 
    Get-FileHash –Algorithm $Algorithm –Path (Get-ChildItem "$TargetFile" -Recurse –Force) | export-csv $TargetSave 
    Write-Host "Collecting Hash... Please wait." 
    Write-Host "Done" 
} 
