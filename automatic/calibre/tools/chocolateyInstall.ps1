﻿$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/5.30.0/calibre-5.30.0.msi'
  checksum       = 'F9451697776C7F0AC9FF500E70291F61B1922B8C06E39477BB7F2AE300887EB5'
  checksumType   = 'sha256'
  file64         = "$toolsPath\calibre-64bit-5.30.0.msi"
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

if ((Get-OSArchitectureWidth -compare 32) -or ($env:chocolateyForceX86 -eq $true)) {
  Install-ChocolateyPackage @packageArgs
}
else {
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item -Force -ea 0 "$toolsPath\*.msi","$toolsPath\*.ignore"
