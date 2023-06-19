# Auto-Set Windows Legacy Wallpaper



## Usage

Open PowerShell with administrator priv and paste the following codes:

```powershell
Set-ExecutionPolicy Unrestricted -Scope Process; $Url = "https://github.com/dryout/SetWinXPWallpaper/archive/refs/heads/main.zip"; $TempDir = [System.IO.Path]::GetTempPath(); $ZipFile = Join-Path -Path $TempDir -ChildPath "repo.zip"; $ExtractPath = Join-Path -Path $TempDir -ChildPath "repo"; Invoke-WebRequest -Uri $Url -OutFile $ZipFile; Expand-Archive -Path $ZipFile -DestinationPath $ExtractPath -Force; $ScriptFile = Join-Path -Path $ExtractPath -ChildPath "SetWinXPWallpaper-main\SetWinXPWallpaper.ps1"; & $ScriptFile
```


