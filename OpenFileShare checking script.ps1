#OpenFileShare checking script

#Check for Open Share
$SMBEveryoneSharePath = (Get-SmbShare | Get-SmbShareAccess |Where-Object {$_.accountname -eq "everyone"}|Get-SmbShare).path

#Loop thru and confirm NTFS permission is also everyone
foreach ($FileShare in $SMBEveryoneSharePath){

    if(((Get-Acl $FileShare).access).IdentityReference -like "*everyone*" ){
            return "OpenFileShareFound=" + $FileShare
        }    
}
return 0