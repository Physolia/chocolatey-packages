﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download2.tixati.com/download/tixati-2.84-1.portable.zip'
  checksum       = '6a10f730123628c4aa7d230f6a1353942d9e23bc5c2c250b8be8fff3fa675db7'
  checksumType   = 'sha256'
  unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$is32bit = (Get-OSArchitectureWidth 32) -or ($Env:chocolateyForceX86 -eq 'true')
$tixati_path = "$toolsPath\Tixati_portable"
Remove-Item $tixati_path\tixati_Linux*
if ($is32bit) {
    Remove-Item $tixati_path\tixati_Windows64bit.exe
    Move-Item $tixati_path\tixati_Windows32bit.exe $tixati_path\tixati.exe
} else {
    Remove-Item $tixati_path\tixati_Windows32bit.exe
    Move-Item $tixati_path\tixati_Windows64bit.exe $tixati_path\tixati.exe
}
