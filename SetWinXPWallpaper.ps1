# �X�N���v�g�Ɠ����f�B���N�g������'jpeg'�t�H���_����摜���擾���܂��B
$directory = Join-Path -Path $PSScriptRoot -ChildPath "jpeg"

# �ǎ��ݒ�p��API���Ăяo�����߂�PInvoke��`
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

while($true) {
    # �w��f�B���N�g������JPEG�摜���擾���܂��B
    $images = Get-ChildItem -Path $directory -Filter *.jpg

    # JPEG�摜���ꗗ�\�����܂��B
    $images | foreach-object -begin { $i=1 } -process { Write-Output ("{0}: {1}" -f $i++, $_.Name) }

    # ���[�U�[�ɉ摜��I�������܂��B
    $selectedNumber = Read-Host -Prompt 'Please enter the number of the image you want to set as your wallpaper, or press Enter to exit'

    # �������͂���Enter���������ꍇ�A�X�N���v�g���I�����܂��B
    if([string]::IsNullOrEmpty($selectedNumber)) {
        Write-Output "Exiting the script..."
        break
    }

    # �I�������摜��ǎ��ɐݒ肵�܂��B
    $selectedImage = $images[$selectedNumber - 1].FullName
    [Wallpaper]::SystemParametersInfo(20, 0, $selectedImage, 3)

    Write-Output "Wallpaper set to $selectedImage"
}
