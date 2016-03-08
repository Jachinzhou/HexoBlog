<#
.SYNOPSIS
    Sets up the GitHub Git Shell Environment
.DESCRIPTION
    Sets up the proper PATH and ENV to use GitHub for Window's shell environment
    Don't edit this file directly, it is generated on install.
    Generally you would run this from your Powershell Profile like this:

    . (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")

.PARAMETER SkipSSHSetup
    If true, skips calling GitHub.exe to autoset and upload ssh-keys
#>
[CmdletBinding()]
Param(
    [switch]
    $SkipSSHSetup = $false
)

if ($env:github_shell -eq $null) {

  Write-Verbose "Running GitHub\shell.ps1"

  Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

  $env:github_posh_git = Resolve-Path "$env:LocalAppData\GitHub\PoshGit_869d4c5159797755bc04749db47b166136e59132"
  $env:github_git = Resolve-Path "$env:LocalAppData\GitHub\PortableGit_c7e0cbde92ba565cb218a521411d0e854079a28c"
  $env:PLINK_PROTOCOL = "ssh"
  $env:TERM = "msys"
  $env:HOME = $HOME
  $env:TMP = $env:TEMP = [system.io.path]::gettemppath()
  if ($env:EDITOR -eq $null) {
    $env:EDITOR = "GitPad"
  }

  # Setup PATH
  $pGitPath = $env:github_git
  $appPath = Resolve-Path "$env:LocalAppData\Apps\2.0\6WRO80N2.7L5\ZNGCZGL8.QD1\gith..tion_317444273a93ac29_0003.0000_328216539257acd4"
  $msBuildPath = "$env:SystemRoot\Microsoft.NET\Framework\v4.0.30319"

  $env:Path = "$env:Path;$pGitPath\cmd;$pGitPath\usr\bin;$pGitPath\usr\share\git-tfs;C:\Users\Jachin\AppData\Local\GitHub\lfs-amd64_1.1.0;$appPath;$msbuildPath"

  if (!$SkipSSHSetup) {
    & (Join-Path $appPath GitHub.exe) --set-up-ssh
  }

  Pop-Location

} else { Write-Verbose "GitHub shell environment already setup" }
