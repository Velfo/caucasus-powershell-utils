# scaffold.ps1
# Creates the caspian-ingest-plane repo tree (network-aware ingest reliability)
# Safe to re-run: does not overwrite existing files.

param(
  [string]$Root = "caspian-ingest-plane"
)

$ErrorActionPreference = "Stop"

function Ensure-Dir([string]$Path) {
  if (-not (Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

function Ensure-File([string]$Path, [string]$Content = "") {
  if (-not (Test-Path $Path)) {
    $parent = Split-Path $Path -Parent
    if ($parent -and -not (Test-Path $parent)) { Ensure-Dir $parent }
    New-Item -ItemType File -Path $Path | Out-Null
    if ($Content -ne "") {
      Set-Content -Path $Path -Value $Content -Encoding UTF8
    }
  }
}

Write-Host "Scaffolding repo at: $Root"

# Root
Ensure-Dir $Root
Ensure-File (Join-Path $Root "README.md") @"
# caspian-ingest-plane

A WAN-first ingest plane with explicit backpressure, spooling, and reliability telemetry
for on-prem and hybrid observability systems.

Status: early-stage. Design feedback welcome.
"@
Ensure-File (Join-Path $Root "Makefile") @"
.PHONY: help
help:
	@echo "Targets: build, test, lint (add as you implement)"
"@
Ensure-File (Join-Path $Root ".gitignore") @"
# Go
/bin/
/dist/
/web/dist/
/*.exe
*.test
*.out

# Node
node_modules/
"@
Ensure-File (Join-Path $Root "docker-compose.yml") @"
version: "3.9"
services:
  server:
    image: scratch
    command: ["echo","caspian-ingest-plane scaffold"]
"@

# configs
Ensure-Dir (Join-Path $Root "configs")
Ensure-File (Join-Path $Root "configs/server.yaml") "server: { http_addr: ':8080' }`n"
Ensure-File (Join-Path $Root "configs/gateway.yaml") "gateway: { http_addr: ':8081' }`n"
Ensure-File (Join-Path $Root "configs/agent.yaml") "agent: { gateway_url: 'https://localhost:8081' }`n"
Ensure-File (Join-Path $Root "configs/rbac.yaml") "rbac: {}`n"
Ensure-File (Join-Path $Root "configs/retention.yaml") "retention: { raw: '168h' }`n"
Ensure-File (Join-Path $Root "configs/reliability.yaml") "reliability: {}`n"
Ensure-File (Join-Path $Root "configs/telemetry.yaml") "telemetry: {}`n"

# docs
Ensure-Dir (Join-Path $Root "docs/diagrams")
$diagramFiles = @(
  "00-context.mmd","01-components.mmd","02-ingest-seq.mmd","03-ingest-flow.mmd",
  "04-query-flow.mmd","05-security-trust-zones.mmd","06-agent-gateway-flow.mmd",
  "07-wan-reliability-flow.mmd","08-telemetry-schema.mmd"
)
foreach ($f in $diagramFiles) {
  Ensure-File (Join-Path $Root "docs/diagrams/$f") "%% caspian-ingest-plane diagram: $f`n"
}

Ensure-Dir (Join-Path $Root "docs/adr")
$adrFiles = @(
  "0001-tech-stack.md","0002-ingest-api-shape.md","0003-storage-interface.md",
  "0004-rbac-scope.md","0005-encryption-at-rest.md","0006-retention-and-rollups.md",
  "0007-audit-log.md","0008-offline-install.md","0009-agent-gateway-protocol.md",
  "0010-wan-reliability-contracts.md","0011-backpressure-policy.md",
  "0012-spooling-design.md","0013-telemetry-semantics.md"
)
foreach ($f in $adrFiles) {
  Ensure-File (Join-Path $Root "docs/adr/$f") "# $f`n`nTODO.`n"
}

Ensure-Dir (Join-Path $Root "docs/perf")
$perfFiles = @(
  "budgets.md","baseline.md","loadtest-notes.md","p99-honesty.md","ingest-wan-scenarios.md"
)
foreach ($f in $perfFiles) {
  Ensure-File (Join-Path $Root "docs/perf/$f") "# $f`n`nTODO.`n"
}

Ensure-Dir (Join-Path $Root "docs/security")
foreach ($f in @("threat-model.md","data-custody.md","tls-mtls.md")) {
  Ensure-File (Join-Path $Root "docs/security/$f") "# $f`n`nTODO.`n"
}

Ensure-Dir (Join-Path $Root "docs/install")
foreach ($f in @("offline.md","docker.md","k8s.md")) {
  Ensure-File (Join-Path $Root "docs/install/$f") "# $f`n`nTODO.`n"
}

# api
Ensure-Dir (Join-Path $Root "api/samples")
Ensure-File (Join-Path $Root "api/openapi.yaml") `
"openapi: 3.0.0`ninfo: { title: caspian-ingest-plane, version: 0.0.0 }`n"

# proto
Ensure-Dir (Join-Path $Root "proto")
Ensure-File (Join-Path $Root "proto/ingest.proto") "syntax = ""proto3"";`npackage ingest;`n"
Ensure-File (Join-Path $Root "proto/telemetry.proto") "syntax = ""proto3"";`npackage telemetry;`n"
Ensure-File (Join-Path $Root "proto/gateway.proto") "syntax = ""proto3"";`npackage gateway;`n"

# cmd
Ensure-Dir (Join-Path $Root "cmd/server")
Ensure-Dir (Join-Path $Root "cmd/ingest-gateway")
Ensure-Dir (Join-Path $Root "cmd/edge-agent")

Ensure-File (Join-Path $Root "cmd/server/main.go") "package main`n`nfunc main() {}"
Ensure-File (Join-Path $Root "cmd/ingest-gateway/main.go") "package main`n`nfunc main() {}"
Ensure-File (Join-Path $Root "cmd/edge-agent/main.go") "package main`n`nfunc main() {}"

# internal (directories only; stubs next)
$dirs = @(
  "internal/config","internal/httpapi","internal/auth","internal/audit",
  "internal/reliability/retry","internal/reliability/batching",
  "internal/reliability/flowcontrol","internal/reliability/spool/diskqueue",
  "internal/reliability/spool/memory","internal/reliability/idempotency",
  "internal/reliability/wire","internal/reliability/testing",
  "internal/telemetry","internal/ingest","internal/transport",
  "internal/storage/badger","internal/storage/memory","internal/storage/wal",
  "internal/rollup","internal/query","internal/observability",
  "internal/admin","internal/buildinfo","internal/util"
)
foreach ($d in $dirs) { Ensure-Dir (Join-Path $Root $d) }

Write-Host "Done. caspian-ingest-plane scaffold created."
Write-Host "Next: cd $Root; go mod init github.com/Caspian-Systems-Lab/caspian-ingest-plane"
