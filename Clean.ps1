param (
    [string]$FolderName
)

# Check if the folder path is provided, if not, exit the script with a message
if (-not $FolderName) {
    Write-Host "Please provide a folder path."
    exit
}

$baseFolder = Join-Path $FolderName "export"

# Get all C# files in the folder
$files = Get-ChildItem -Path $baseFolder -Filter "*.cs" -Recurse

foreach ($file in $files) {
    # Print the file name being processed
    Write-Host "Processing file: $($file.FullName)"

    # Read the content of the file
    $content = Get-Content $file.FullName

    # Create a list to store the modified content
    $newContent = @()

    foreach ($line in $content) {
        # Skip lines with 'nullable disable' and comments (but not the empty lines)
        if ($line -match '^\s*#nullable disable' -or $line -match '^\s*//') {
            continue
        }
        # Add non-matching lines (non-empty, non-comment) to the new content list
        $newContent += $line
    }

    # Write the modified content back to the file
    Set-Content $file.FullName $newContent
}