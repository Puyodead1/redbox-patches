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

    # Flag to mark when we reach the first non-comment line
    $foundNonComment = $false

    # Create a list to store the modified content
    $newContent = @()

    foreach ($line in $content) {
        # Check for non-comment lines
        if ($foundNonComment -eq $false) {
            # If the line is a comment or empty, skip it
            if ($line -match '^\s*//') {
                # Skip comment lines
                continue
            } elseif ($line -match '^\s*$') {
                # Skip empty lines
                continue
            } else {
                # Once we find the first non-comment line, we can start adding to the new content list
                $foundNonComment = $true
            }
        }

        # Add all lines after the comments to the new content (this includes using statements and code)
        $newContent += $line
    }

    # Write the modified content back to the file
    Set-Content $file.FullName $newContent
}