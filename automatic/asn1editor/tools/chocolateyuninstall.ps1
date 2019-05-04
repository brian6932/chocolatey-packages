# Remove start menu shortcut
$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutFilePath = Join-Path $programs "ASN.1 Editor.lnk"
if (Test-Path $shortcutFilePath) { Remove-Item $shortcutFilePath }