$Base = "fundamenta-c/docs"

# Directories to create
$dirs = @(
    "00_overview",
    "05_getting_started",
    "10_arrays",
    "20_strings",
    "30_queues_deques",
    "40_sliding_window",
    "50_trees",
    "60_graphs",
    "70_algorithms_misc",
    "90_meta"
)

Write-Host "Creating directory structure..."
foreach ($d in $dirs) {
    New-Item -ItemType Directory -Force -Path "$Base/$d" | Out-Null
}

Write-Host "Creating files..."

# Helper function
function TouchFile($path) {
    if (!(Test-Path $path)) {
        New-Item -ItemType File -Path $path | Out-Null
    }
}

# 00_overview
TouchFile "$Base/00_overview/index.md"
TouchFile "$Base/00_overview/naming_map.md"
TouchFile "$Base/00_overview/roadmap.md"
TouchFile "$Base/00_overview/conventions.md"

# 05_getting_started
TouchFile "$Base/05_getting_started/environment_setup.md"
TouchFile "$Base/05_getting_started/how_to_read_the_codebase.md"
TouchFile "$Base/05_getting_started/how_to_run_tests.md"
TouchFile "$Base/05_getting_started/contributing_guidelines.md"

# 10_arrays
TouchFile "$Base/10_arrays/absheron_array_overview.md"
TouchFile "$Base/10_arrays/absheron_array_api.md"
TouchFile "$Base/10_arrays/absheron_array_internals.md"
TouchFile "$Base/10_arrays/absheron_array_exercises.md"

# 20_strings
TouchFile "$Base/20_strings/fuzuli_strings_overview.md"
TouchFile "$Base/20_strings/fuzuli_strings_api.md"
TouchFile "$Base/20_strings/fuzuli_strings_internals.md"
TouchFile "$Base/20_strings/fuzuli_strings_exercises.md"

# 30_queues_deques
TouchFile "$Base/30_queues_deques/shirvan_queue_overview.md"
TouchFile "$Base/30_queues_deques/shirvan_queue_api.md"
TouchFile "$Base/30_queues_deques/shirvan_queue_internals.md"
TouchFile "$Base/30_queues_deques/shirvan_queue_exercises.md"

TouchFile "$Base/30_queues_deques/quba_deque_overview.md"
TouchFile "$Base/30_queues_deques/quba_deque_api.md"
TouchFile "$Base/30_queues_deques/quba_deque_internals.md"
TouchFile "$Base/30_queues_deques/quba_deque_exercises.md"

# 40_sliding_window
TouchFile "$Base/40_sliding_window/kura_sliding_window_concept.md"
TouchFile "$Base/40_sliding_window/kura_sliding_window_api.md"
TouchFile "$Base/40_sliding_window/kura_sliding_window_internals.md"
TouchFile "$Base/40_sliding_window/kura_sliding_window_exercises.md"

# 50_trees
TouchFile "$Base/50_trees/nakhchivan_bst_overview.md"
TouchFile "$Base/50_trees/nakhchivan_bst_api.md"
TouchFile "$Base/50_trees/nakhchivan_bst_internals.md"
TouchFile "$Base/50_trees/nakhchivan_bst_exercises.md"

# 60_graphs
TouchFile "$Base/60_graphs/gabala_graph_overview.md"
TouchFile "$Base/60_graphs/gabala_graph_api.md"
TouchFile "$Base/60_graphs/gabala_graph_internals.md"
TouchFile "$Base/60_graphs/gabala_graph_exercises.md"

# 70_algorithms_misc
TouchFile "$Base/70_algorithms_misc/searching_sorting_overview.md"
TouchFile "$Base/70_algorithms_misc/error_handling_patterns.md"
TouchFile "$Base/70_algorithms_misc/memory_management_patterns.md"

# 90_meta
TouchFile "$Base/90_meta/testing_strategy.md"
TouchFile "$Base/90_meta/cultural_references.md"
TouchFile "$Base/90_meta/future_work.md"

Write-Host "Done."
