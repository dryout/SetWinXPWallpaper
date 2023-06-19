# スクリプトと同じディレクトリ内の'jpeg'フォルダから画像を取得します。
$directory = Join-Path -Path $PSScriptRoot -ChildPath "jpeg"

# 壁紙設定用のAPIを呼び出すためのPInvoke定義
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

while($true) {
    # 指定ディレクトリ内のJPEG画像を取得します。
    $images = Get-ChildItem -Path $directory -Filter *.jpg

    # JPEG画像を一覧表示します。
    $images | foreach-object -begin { $i=1 } -process { Write-Output ("{0}: {1}" -f $i++, $_.Name) }

    # ユーザーに画像を選択させます。
    $selectedNumber = Read-Host -Prompt 'Please enter the number of the image you want to set as your wallpaper, or press Enter to exit'

    # 何も入力せずEnterを押した場合、スクリプトを終了します。
    if([string]::IsNullOrEmpty($selectedNumber)) {
        Write-Output "Exiting the script..."
        break
    }

    # 選択した画像を壁紙に設定します。
    $selectedImage = $images[$selectedNumber - 1].FullName
    [Wallpaper]::SystemParametersInfo(20, 0, $selectedImage, 3)

    Write-Output "Wallpaper set to $selectedImage"
}
