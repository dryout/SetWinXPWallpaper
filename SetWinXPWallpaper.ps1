$url = "https://example.com/image.jpg"  # �摜��URL���w��
$path = "$env:USERPROFILE\Desktop\wallpaper.jpg"  # �_�E�����[�h�����摜�̕ۑ���p�X

# �摜�̃_�E�����[�h
Invoke-WebRequest -Uri $url -OutFile $path

# �ǎ��ݒ�p��API���Ăяo�����߂�PInvoke��`
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Wallpaper�̐ݒ�
[Wallpaper]::SystemParametersInfo(20, 0, $path, 3)
