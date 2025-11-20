param(
    [string]$RootDir = "../caucasus-powershell-utils"
)

Write-Host "Creating structure under: $RootDir"

# Directories
$dirs = @(
    "$RootDir/scripts",
    "$RootDir/examples",
    "$RootDir/docs"
)

foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

# Files to create
$files = @(
    "$RootDir/scripts/Create-Structure.ps1",
    "$RootDir/scripts/Sync-Files.ps1",
    "$RootDir/scripts/Build-Project.ps1",
    "$RootDir/examples/usage_examples.md",
    "$RootDir/docs/execution_policy.md",
    "$RootDir/docs/module_design.md",
    "$RootDir/docs/style_guide.md",
    "$RootDir/LICENSE",
    "$RootDir/README.md"
)

foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Path $file | Out-Null
    }
}

Write-Host "Done."