# Build-Projects.ps1
# Syncs humor-storytelling-lab into quartz/content and builds the site

$ErrorActionPreference = "Stop"

# Where this script lives: ...\quartz\scripts
$scriptDir    = Split-Path -Parent $MyInvocation.MyCommand.Path

# quartz root: ...\quartz
$quartzRoot   = Split-Path -Parent $scriptDir

# projects root: ...\CLionProjects
$projectsRoot = Split-Path -Parent $quartzRoot

# quartz/content
$contentDir   = Join-Path $quartzRoot "content"

$projectName  = "humor-storytelling-lab"
$source       = Join-Path $projectsRoot $projectName
$target       = Join-Path $contentDir $projectName

if (!(Test-Path $source)) {
    Write-Error "Source folder not found: $source"
    exit 1
}

# Clean content dir (removes previous copies / symlinks)
if (Test-Path $contentDir) {
    Get-ChildItem $contentDir -Force | Remove-Item -Recurse -Force
} else {
    New-Item -ItemType Directory -Path $contentDir -Force | Out-Null
}

# Recreate target
New-Item -ItemType Directory -Path $target -Force | Out-Null

# Copy project into content/<projectName>/
Copy-Item (Join-Path $source "*") -Destination $target -Recurse

# Run quartz build from quartz root
Push-Location $quartzRoot
try {
    npx quartz build
}
finally {
    Pop-Location
}
