#~/.config/powershell/Microsoft.PowerShell_profile.ps1
(Get-Command oh-my-posh).Source

# Bash like functionality
function ll { ls -al @args }

# Functions
function Start-CleanupDownload {
    # Reliable method to determine Downloads folder path: https://stackoverflow.com/a/57950443
    $DownloadsFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
    $DownloadsFiles = Get-ChildItem -Path $DownloadsFolderPath -File

    foreach ($File in $DownloadsFiles) {
        $FileExtension = [System.IO.Path]::GetExtension($File).Split('.')[-1]
        $SortPath = "$DownloadsFolderPath\$FileExtension"

        if (-Not (Test-Path -Path $SortPath)) {
            New-Item -Path $SortPath -ItemType Directory | Out-Null
        }

        Move-Item -Path $File.FullName -Destination $SortPath
    }
}
Write-host "Loaded: Start-CleanupDownload"
function Create-Credentials {
    <#
    .SYNOPSIS
        Used to create PSCredentials for use in scripts
    .DESCRIPTION
        Used to create PSCredentials for use in scripts. Use case could be to connect to a Vcenter or remote machine, without the need to login on every use.
        We create the credentials ONCE at runtime. It is then saved in memory and we are able to reuse it until script is done running.
    .NOTES
        Function is only usable on those function or modules that support the use of PSCredentials
    .LINK
        Null
    .EXAMPLE
        Create-Credentials
        You will be prompted for username and password. Password is encrypted.
    #>
    
    # Set text color for better readability
    $TextColour = 'green'

    # Prompt user for username
    Write-Host 'Insert Username: ' -ForegroundColor "$TextColour" -NoNewline
    [string]$userName = Read-Host 

    # Prompt user for password securely
    Write-Host 'Type in password: ' -ForegroundColor "$TextColour" -NoNewline 
    [securestring]$userPassword = Read-Host -AsSecureString    

    #Create the $CredObject and save it in script scope to be reused
    [pscredential]$script:credObject = New-Object System.Management.Automation.PSCredential ($userName, $userPassword)
}
Write-host "Loaded: Create-Credentials"


