# Function to rename files by removing the '' prefix
function Rename-Files {
    param (
        [string]$directory
    )

    $fileMap = @{}

    # Get all files that start with '' and rename them
    Get-ChildItem -Path $directory -Recurse -File | Where-Object { $_.Name -like '*' } | ForEach-Object {
        $newName = $_.Name.Substring(2)
        $newPath = Join-Path -Path $_.DirectoryName -ChildPath $newName
        Rename-Item -Path $_.FullName -NewName $newPath
        $fileMap[$_.FullName] = $newPath
        Write-Output "Renamed: $($_.FullName) -> $newPath"
    }

    return $fileMap
}

# Function to update file references in Dart files
function Update-References {
    param (
        [string]$directory,
        [hashtable]$fileMap
    )

    # Get all Dart files and update references
    Get-ChildItem -Path $directory -Recurse -Include *.dart | ForEach-Object {
        $fileContent = Get-Content -Path $_.FullName
        $updatedContent = $fileContent

        foreach ($oldPath in $fileMap.Keys) {
            $newPath = $fileMap[$oldPath]
            $oldFileName = [System.IO.Path]::GetFileNameWithoutExtension($oldPath)
            $newFileName = [System.IO.Path]::GetFileNameWithoutExtension($newPath)
            $updatedContent = $updatedContent -replace "\b$oldFileName\b", $newFileName
        }

        if ($updatedContent -ne $fileContent) {
            Set-Content -Path $_.FullName -Value $updatedContent
            Write-Output "Updated references in: $($_.FullName)"
        }
    }
}

# Define the directory to start the renaming and updating process
$libDirectory = ".\lib"

# Rename files and get the map of old to new file names
$fileMap = Rename-Files -directory $libDirectory

# Update references in Dart files
Update-References -directory $libDirectory -fileMap $fileMap
