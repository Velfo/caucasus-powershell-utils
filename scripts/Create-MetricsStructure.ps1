param(
# Optional root path where the structure will be created
    [string]$RootPath = "."
)

$baseName = "metrics-collector-study"
$base = Join-Path $RootPath $baseName

Write-Host "Creating structure under: $base"
New-Item -ItemType Directory -Path $base -Force | Out-Null

function New-DirAndFiles {
    param (
        [string]$SubDir,
        [string[]]$Files
    )

    $fullDir = Join-Path $base $SubDir
    New-Item -ItemType Directory -Path $fullDir -Force | Out-Null

    foreach ($f in $Files) {
        $path = Join-Path $fullDir $f
        if (-not (Test-Path $path)) {
            New-Item -ItemType File -Path $path | Out-Null
        }
    }
}

# 01-architecture.
New-DirAndFiles "01-architecture" @(
    "overview-of-metrics-collectors.md",
    "prometheus-architecture.md",
    "collector-flow-stages.md",
    "node-exporter-example.md"
)

# 02-linux-internals
New-DirAndFiles "02-linux-internals" @(
    "procfs-and-sysfs.md",
    "reading-system-metrics.md",
    "kernel-data-interfaces.md",
    "system-calls-used.md"
)

# 03-metric-computation
New-DirAndFiles "03-metric-computation" @(
    "sliding-window-rate.md",
    "counter-deltas-and-resets.md",
    "time-series-concepts.md",
    "promql-rate-function.md"
)

# 04-implementation-patterns
New-DirAndFiles "04-implementation-patterns" @(
    "collector-modules-structure.md",
    "data-aggregation-and-storage.md",
    "exposing-metrics-http.md",
    "lock-free-ingestion.md"
)

# 05-linux-practicals
New-DirAndFiles "05-linux-practicals" @(
    "explore-proc-and-sys.md",
    "using-strace-to-trace-collectors.md",
    "building-cpu-usage-collector.md",
    "benchmarking-collector-performance.md"
)

# 06-crossplatform-notes
New-DirAndFiles "06-crossplatform-notes" @(
    "bsd-macos-sysctl.md",
    "windows-perfcounters.md",
    "abstraction-layer-design.md",
    "portability-strategies.md"
)

# 07-references
New-DirAndFiles "07-references" @(
    "books-and-chapters.md",
    "articles-and-blogs.md",
    "man-pages-and-docs.md",
    "github-and-tutorials.md"
)

# 08-project-integration
New-DirAndFiles "08-project-integration" @(
    "prometheuslitecollector-design-map.md",
    "collector-architecture-diagram.md",
    "learning-progress-log.md",
    "next-features-and-todos.md"
)

Write-Host "Done."
