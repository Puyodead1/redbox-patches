param (
    [string]$FolderName,
    [string]$CommitName
)

# Check if the folder path is provided, if not, exit the script with a message
if (-not $FolderName) {
    Write-Host "Please provide a folder path."
    exit
}

# Check if the commit name is provided, if not, exit the script with a message
if (-not $CommitName) {
    Write-Host "Please provide a commit name."
    exit
}

# Define the base folder and patches directory
$baseFolder = Join-Path $FolderName "export"
$patchesFolder = Join-Path $FolderName "..\..\Patches"

# Navigate to the base folder
Set-Location -Path $baseFolder

# Ensure the patches folder exists
if (-not (Test-Path $patchesFolder)) {
    New-Item -ItemType Directory -Path $patchesFolder | Out-Null
    Write-Host "Created Patches directory: $patchesFolder"
}


# Add all changes to Git
Write-Host "Adding all changes to Git..."
git add .

# Commit the changes
Write-Host "Creating a new Git commit..."
git commit -m $CommitName

# Generate the patch file
Write-Host "Generating patch file..."
git format-patch -1

# Move the patch file to the Patches folder
Write-Host "Moving patch file to Patches directory..."
Move-Item -Path *.patch -Destination (Resolve-Path -Path $patchesFolder).Path -Force

Write-Host "Patch file moved to $patchesFolder."

# Return to the original directory
Set-Location -Path $PSScriptRoot
Write-Host "Returned to the original directory."
