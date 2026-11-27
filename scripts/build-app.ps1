# Generic parameterized patch+sign wrapper for a verified clean base APK or split bundle.
param(
  [Parameter(Mandatory = $true)][string]$InputApk,
  [Parameter(Mandatory = $true)][string]$Out,
  [Parameter(Mandatory = $true)][string]$ResultFile,
  [string]$Jar = 'tools/morphe-desktop-2.4.0-all.jar',
  [string]$Bundle = 'tools/patches-2.4.0.mpp',
  [string]$Keystore = 'workspace/keystore/apk-modding.keystore',
  [string]$PasswordFile = 'workspace/keystore/keystore.password',
  [string]$Alias = 'apkmodding',
  [string]$StripLibs = 'arm64-v8a'
)

$ErrorActionPreference = 'Stop'
foreach ($f in @($Jar, $Bundle, $InputApk, $Keystore, $PasswordFile)) {
  if (-not (Test-Path $f)) { throw "Missing required file: $f" }
}
foreach ($d in @((Split-Path $Out), (Split-Path $ResultFile))) {
  if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}
$pass = (Get-Content $PasswordFile -Raw).Trim()
if (-not $pass) { throw "Empty password in $PasswordFile" }

$arguments = @(
  'patch', '-p', $Bundle, '-o', $Out,
  '--striplibs', $StripLibs,
  '--keystore', $Keystore,
  '--keystore-password', $pass,
  '--keystore-entry-alias', $Alias,
  '--keystore-entry-password', $pass,
  '-r', $ResultFile,
  $InputApk
)

& java -jar $Jar @arguments
if ($LASTEXITCODE -ne 0) { throw "Patching failed (exit $LASTEXITCODE)" }
Get-Item $Out | Select-Object FullName, Length
