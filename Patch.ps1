param (
    [string]$FolderName
)

# Check if the folder path is provided, if not, exit the script with a message
if (-not $FolderName) {
    Write-Host "Please provide a folder name."
    exit
}

# Define the path to the patches directory
$patchesDirectory = Join-Path $FolderName "patches"

# Check if the patches directory exists
if (-not (Test-Path $patchesDirectory)) {
    Write-Host "No patch folder found."
    exit
}

# Get all patch files in the patches directory
$patchFiles = Get-ChildItem -Path $patchesDirectory -Filter "*.patch" -Recurse

# Check if there are any patch files
if ($patchFiles.Count -eq 0) {
    Write-Host "No patch files found in the patches directory."
    exit
}

# Change to the folder where the Git repository is located
Set-Location -Path $FolderName

$baseFolder = "export"

# Check if the base folder exists
if (-not (Test-Path $baseFolder)) {
    Write-Host "The 'export' folder does not exist."
    exit
}

foreach ($patch in $patchFiles) {
    Write-Host "Applying patch: $($patch.FullName)"
    
    try {
		# We need to exclude patching .sln files, because they always change and cannot be patched correctly
        git apply --directory=$baseFolder --exclude=export/$FolderName/$FolderName.sln $patch.FullName
        Write-Host "Successfully applied patch: $($patch.Name)"
    }
    catch {
        Write-Host "Failed to apply patch: $($patch.Name). Error: $_"
    }
}

Set-Location -Path ..

Write-Host "Patch application process is complete."