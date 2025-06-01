# Function to create PowerShell script files
function Create-PSScriptFile {
    param (
        [string]$filePath,
        [string]$fileContent
    )

    if (-Not (Test-Path -Path $filePath)) {
        Set-Content -Path $filePath -Value $fileContent
        Write-Output "Created script: $filePath"
    } else {
        Write-Output "Script already exists: $filePath"
    }
}

# Get user input for project configuration
$projectPath = Read-Host "Enter the path to your Visual Studio project"
$projectFile = Read-Host "Enter the name of your .vcxproj file (e.g., YourProjectName.vcxproj)"
$sierraChartDataPath = Read-Host "Enter the path to your Sierra Chart 'Data' folder (e.g., C:\SierraChart\Data\)"
$acsSourcePath = Read-Host "Enter the path to your Sierra Chart 'ACS_Source' folder (e.g., C:\SierraChart\ACS_Source\)"
$powershellPath = Read-Host "Enter the path to your PowerShell executable (e.g., C:\Program Files\PowerShell\7\pwsh.exe)"
$dllName = Read-Host "Enter the name of your DLL file (e.g., SCFirstStudy.dll)"
$peerIP = Read-Host "Enter the Sierra Chart IP address (e.g., 127.0.0.1)"
$peerPort = Read-Host "Enter the Sierra Chart UDP port (e.g., 22904)"

# Create ReleaseDLL.ps1 script
$releaseDLLScript = @"
\$client = new-object net.sockets.udpclient(0) 
\$peerIP = "$peerIP"
\$peerPort = "$peerPort"
\$send = [text.encoding]::ascii.getbytes("RELEASE_DLL--$sierraChartDataPath$dllName")
[void] \$client.send(\$send, \$send.length, \$peerIP, \$peerPort)
\$client.close()
"@
Create-PSScriptFile -filePath (Join-Path -Path $projectPath -ChildPath "ReleaseDLL.ps1") -fileContent $releaseDLLScript

# Create ReloadDLL.ps1 script
$reloadDLLScript = @"
\$client = new-object net.sockets.udpclient(0) 
\$peerIP = "$peerIP"
\$peerPort = "$peerPort"
\$send = [text.encoding]::ascii.getbytes("ALLOW_LOAD_DLL--$sierraChartDataPath$dllName")
[void] \$client.send(\$send, \$send.length, \$peerIP, \$peerPort)
\$client.close()
"@
Create-PSScriptFile -filePath (Join-Path -Path $projectPath -ChildPath "ReloadDLL.ps1") -fileContent $reloadDLLScript

# Load the project file
[xml]$xml = Get-Content -Path (Join-Path -Path $projectPath -ChildPath $projectFile)

# Set Output Directory
$xml.Project.PropertyGroup | ForEach-Object {
    $_.OutDir = $sierraChartDataPath
}

# Set Output File
$xml.Project.ItemDefinitionGroup.Link.OutputFile = "$sierraChartDataPath$(TargetName)$(TargetExt)"

# Set Include Directories
$xml.Project.ItemDefinitionGroup.ClCompile.AdditionalIncludeDirectories = "$($xml.Project.ItemDefinitionGroup.ClCompile.AdditionalIncludeDirectories);$acsSourcePath"

# Add Pre-Build and Post-Build events
$xml.Project.ItemDefinitionGroup | ForEach-Object {
    $_.PreBuildEvent.Command = "$powershellPath -File ""$projectPath\ReleaseDLL.ps1"""
    $_.PostBuildEvent.Command = "$powershellPath -File ""$projectPath\ReloadDLL.ps1"""
}

# Save changes to the project file
$xml.Save((Join-Path -Path $projectPath -ChildPath $projectFile))

Write-Output "Project configuration and scripts updated successfully."
