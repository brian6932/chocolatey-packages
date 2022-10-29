﻿import-module au

. ..\..\helpers\GitHub_Helper.ps1

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_GetLatest {
   return github_GetInfo -ArgumentList @{
        repository = 'guilryder/clavier-plus'
        regex64    = '/download/release(?<Version>[\d\.]+)/Clavier.zip'
   }
}

function global:au_SearchReplace {
    @{
        "legal\VERIFICATION.txt"  = @{            
            "(?i)(x64: ).*"               = "`${1}$($Latest.URL64)"            
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
            "(?i)(checksum64:).*"       = "`${1} $($Latest.Checksum64)"
        }

        "tools\chocolateyinstall.ps1" = @{
          "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\)(.*)`"" = "`$1$($Latest.FileName64)`""
        }
    }
}


update -ChecksumFor none