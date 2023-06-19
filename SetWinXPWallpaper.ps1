$url = "https://example.com/image.jpg"  # 画像のURLを指定
$path = "$env:USERPROFILE\Desktop\wallpaper.jpg"  # ダウンロードした画像の保存先パス

# 画像のダウンロード
Invoke-WebRequest -Uri $url -OutFile $path

# 壁紙設定用のAPIを呼び出すためのPInvoke定義
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Wallpaperの設定
[Wallpaper]::SystemParametersInfo(20, 0, $path, 3)
