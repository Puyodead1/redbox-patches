param (
    [string]$FolderName
)

# Check if the folder path is provided, if not, exit the script with a message
if (-not $FolderName) {
    Write-Host "Please provide a folder path."
    exit
}

# Save the current directory to return later
$initialDirectory = Get-Location

# Call Clean.ps1 with FolderName as argument
Write-Host "Running Clean..."
& ".\Clean.ps1" -FolderName $FolderName

# Define the baseFolder path
$baseFolder = Join-Path $FolderName "export"

# Check if .gitignore exists in the current directory
$gitIgnoreFile = "template.gitignore"
if (Test-Path $gitIgnoreFile) {
    # Copy template.gitignore to baseFolder as .gitignore
    $destinationGitIgnore = Join-Path $baseFolder ".gitignore"
    Copy-Item -Path $gitIgnoreFile -Destination $destinationGitIgnore -Force
    Write-Host "template.gitignore file copied to $destinationGitIgnore"
}
else {
    Write-Host "template.gitignore file does not exist in the current directory."
    exit
}

# Initialize a new git repository in baseFolder
Write-Host "Initializing new Git repository in $baseFolder"
Set-Location -Path $baseFolder
git init

# Add all files to the repository
git add .

# Commit with message "Base"
git commit -m "Base"

Write-Host "Git repository initialized and commit 'Base' created."

# Return to the initial directory
Set-Location -Path $initialDirectory
Write-Host "Returned to the initial directory: $initialDirectory"
