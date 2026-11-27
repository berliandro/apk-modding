# Patches the verified clean YouTube APK with the verified Morphe bundle and signs it.
param(
  [string]$Jar = 'tools/morphe-desktop-2.4.0-all.jar',
  [string]$Bundle = 'tools/patches-2.4.0.mpp',
  [string]$InputApk = 'workspace/input/youtube-21.30.216-nodpi.apk',
  [string]$Out = 'workspace/output/youtube-21.30.216-morphe-2.4.0.apk',
  [string]$Keystore = 'workspace/keystore/apk-modding.keystore',
  [string]$PasswordFile = 'workspace/keystore/keystore.password',
  [string]$Alias = 'apkmodding',
  [string]$StripLibs = 'arm64-v8a',
  [string]$ResultFile = 'workspace/temp/youtube-patch-result.json',
  [string[]]$Extra = @()
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
  '-r', $ResultFile
)
$arguments += $Extra
$arguments += $InputApk

& java -jar $Jar @arguments
if ($LASTEXITCODE -ne 0) { throw "Patching failed (exit $LASTEXITCODE). See log above." }
Get-Item $Out | Select-Object FullName, Length
