param(
  [string]$Destination,

  [switch]$Force
)

$ErrorActionPreference = "Stop"

$sourceSkills = Join-Path (Split-Path -Parent $PSScriptRoot) "skills"

if (-not $Destination -or $Destination.Trim().Length -eq 0) {
  if ($env:CODEX_HOME -and $env:CODEX_HOME.Trim().Length -gt 0) {
    $Destination = Join-Path $env:CODEX_HOME "skills"
  } else {
    $userProfileDir = [Environment]::GetFolderPath("UserProfile")
    $Destination = Join-Path $userProfileDir ".codex\skills"
  }
}

New-Item -ItemType Directory -Force -Path $Destination | Out-Null

Get-ChildItem -LiteralPath $sourceSkills -Directory | ForEach-Object {
  $target = Join-Path $Destination $_.Name
  if (Test-Path -LiteralPath $target) {
    if (-not $Force) {
      throw "Skill already exists at $target. Re-run with -Force to replace existing BCI workflow skills."
    }
    Remove-Item -LiteralPath $target -Recurse -Force
  }
  Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force
  Write-Host "Installed skill: $($_.Name) -> $target"
}

Write-Host "Installed BCI workflow skills to: $Destination"
