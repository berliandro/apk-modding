# Recreates the gitignored workspace layout on a fresh clone and reports host prerequisites.
param([switch]$CheckAdb)

$root = Split-Path -Parent $PSScriptRoot
$dirs = @(
  (Join-Path $root 'workspace\input'),
  (Join-Path $root 'workspace\temp'),
  (Join-Path $root 'workspace\output'),
  (Join-Path $root 'tools')
)

foreach ($dir in $dirs) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Write-Host "created $dir"
  }
}

$required = @('java', 'git', 'python')
foreach ($cmd in $required) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    Write-Error "MISSING: $cmd is not on PATH. Ask for approval before installing host software."
  }
}

if ($CheckAdb -and -not (Get-Command adb -ErrorAction SilentlyContinue)) {
  Write-Error 'MISSING: adb is not on PATH. Device detection/install requires it; ask before installing.'
}
