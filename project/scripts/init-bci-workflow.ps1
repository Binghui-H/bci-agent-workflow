param(
  [Parameter(Mandatory = $true)]
  [string]$TargetRepo,

  [ValidateSet("gated", "phase_gated", "full_auto")]
  [string]$Mode = "gated",

  [ValidateSet("subagents", "separate_threads")]
  [string]$Topology = "subagents",

  [switch]$Force
)

$ErrorActionPreference = "Stop"

$resolvedTarget = Resolve-Path -LiteralPath $TargetRepo -ErrorAction Stop
$templateDir = Join-Path (Split-Path -Parent $PSScriptRoot) "workflow-template"
$workflowDir = Join-Path $resolvedTarget ".agent-workflow"

if ((Test-Path -LiteralPath $workflowDir) -and -not $Force) {
  throw ".agent-workflow already exists at $workflowDir. Re-run with -Force to overwrite template files."
}

New-Item -ItemType Directory -Force -Path $workflowDir | Out-Null
Copy-Item -Path (Join-Path $templateDir "*") -Destination $workflowDir -Recurse -Force

$configPath = Join-Path $workflowDir "workflow.config.yaml"
$config = Get-Content -Raw -Encoding UTF8 -LiteralPath $configPath
$config = $config -replace "mode: gated # gated \| phase_gated \| full_auto", "mode: $Mode # gated | phase_gated | full_auto"
$config = $config -replace "topology: subagents # subagents \| separate_threads", "topology: $Topology # subagents | separate_threads"

if ($Topology -eq "separate_threads") {
  $config = $config -replace "role_creation: on_demand # on_demand \| upfront", "role_creation: upfront # on_demand | upfront"
}

if ($Mode -eq "full_auto") {
  $config = $config -replace "after_design: true", "after_design: false"
  $config = $config -replace "before_implementation: true", "before_implementation: false"
  $config = $config -replace "before_final_acceptance: true", "before_final_acceptance: false"
}

Set-Content -LiteralPath $configPath -Value $config -Encoding UTF8

$runStatePath = Join-Path $workflowDir "RUN_STATE.md"
$runState = Get-Content -Raw -Encoding UTF8 -LiteralPath $runStatePath
$runState = $runState -replace "\| gated \|", "| $Mode |"
$runState = $runState -replace "\| subagents \|", "| $Topology |"
$runState = $runState -replace "<fill-time>", (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
Set-Content -LiteralPath $runStatePath -Value $runState -Encoding UTF8

$agentsPath = Join-Path $workflowDir "agents.yaml"
$agents = Get-Content -Raw -Encoding UTF8 -LiteralPath $agentsPath
$agents = $agents -replace "topology: subagents # subagents \| separate_threads", "topology: $Topology # subagents | separate_threads"
Set-Content -LiteralPath $agentsPath -Value $agents -Encoding UTF8

Write-Host "Initialized BCI workflow:"
Write-Host "  Target: $resolvedTarget"
Write-Host "  Workflow: $workflowDir"
Write-Host "  Mode: $Mode"
Write-Host "  Topology: $Topology"
