[CmdletBinding()]
param(
  [string]$Destination,

  [switch]$Force
)

$ErrorActionPreference = "Stop"

$installer = Join-Path $PSScriptRoot "project\scripts\install-skills.ps1"
& $installer @PSBoundParameters
