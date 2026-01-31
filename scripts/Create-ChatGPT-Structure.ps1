param(
# Change this to where you want the root folder to live
    [string]$Root = "C:\Users\aghay\Documents\ChatGPT-Chats"
)

# Create a directory if it doesn't exist
function New-Dir {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

# Create a README.md with a simple header if it doesn't exist
function New-Readme {
    param(
        [string]$FolderPath,
        [string]$Title
    )

    $readmePath = Join-Path $FolderPath "README.md"
    if (-not (Test-Path -LiteralPath $readmePath)) {
        $content = @"
# $Title

Paste or link related ChatGPT chats for **$Title** here.
"@
        $content | Out-File -FilePath $readmePath -Encoding UTF8
    }
}

# Define the structure as a nested hashtable
$structure = @{
    "1_Technical-Knowledge-Engineering" = @{
        "1.1_Systems-Programming"            = $null
        "1.2_SRE-DevOps-Infrastructure"      = $null
        "1.3_Machine-Learning"               = $null
        "1.4_Cloud-and-Architecture"         = $null
    }
    "2_Quartz-Obsidian-GitHub-Workflow" = @{
        "2.1_Quartz-Setup"                   = $null
        "2.2_Obsidian-Vault"                 = $null
        "2.3_Cloudflare-Access-and-Domains"  = $null
    }
    "3_Humor-Storytelling-Communication" = @{
        "3.1_Humor-Theory"                   = $null
        "3.2_Language-and-Translation"       = $null
        "3.3_Culture-and-Creative-Writing"   = $null
    }
    "4_Life-Strategy-and-Personal-Development" = $null
    "5_Language-Learning" = @{
        "5.1_Russian"                        = $null
        "5.2_Azerbaijani"                    = $null
        "5.3_Italian-French-Spanish"         = $null
    }
    "6_Trading-HPC-Low-Latency-Systems" = $null
    "7_Tools-Editors-Environment-Setup" = @{
        "7.1_CLion-and-CMake"                = $null
        "7.2_Git-and-GitHub"                 = $null
        "7.3_Node-NPM-PowerShell-Bash"       = $null
    }
    "8_Miscellaneous-Temporary" = $null
}

function New-Structure {
    param(
        [string]$ParentPath,
        [hashtable]$Node
    )

    foreach ($name in $Node.Keys) {
        $currentPath = Join-Path $ParentPath $name
        New-Dir -Path $currentPath
        New-Readme -FolderPath $currentPath -Title $name

        $child = $Node[$name]
        if ($child -is [hashtable]) {
            New-Structure -ParentPath $currentPath -Node $child
        }
    }
}

# Create root and build everything under it
New-Dir -Path $Root
New-Readme -FolderPath $Root -Title "ChatGPT-Chats-Root"

# If top-level structure is a hashtable, recurse
if ($structure -is [hashtable]) {
    New-Structure -ParentPath $Root -Node $structure
}

Write-Host "Folder structure created under: $Root"
