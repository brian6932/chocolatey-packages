﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'zip'  
  file         =  'laragon.exe'

  url           = 'https://github.com/leokhoa/laragon/releases/download/4.0.12/laragon.7z'
  checksum      = '221fd74474310c1e4756cd6758eb68361635cfb8db3692173106ea54bf0b0dfc'
  checksumType  = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

#Install start menu shortcuts
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)

$shortcutFilePath = Join-Path $programs "Laragon.lnk"
$targetPath = Join-Path $toolsDir "laragon.exe"
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath