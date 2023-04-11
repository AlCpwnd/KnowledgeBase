# DISM Offline Repair
> [Source](https://ugetfix.com/ask/how-to-fix-dism-error-0x800f081f-in-windows/)

Steps to follow in case neither `SFC /SCANNOW` and `DISM /Online /Cleanup-Image /RestoreHealth` fail to repair the system files.

0. (Optional) Download the ISO file corresponding to the OS you want to repair
1. Mount the ISO file within the operating system you are trying to repair
2. Find the "Install.*" file within the "source" folder of your mounted image. Depending on the image file you're using, you'll find `Install.wim` or `Install.esd`.
    1. Copy the file to your windows directory: `copy D:\source\Install.esd C:\Install.esd`
    2. Start CMD as Admin and navigate to the same folder
    3. Run `dism /Get-WimInfo /WimFile:install.esd` and take note of the index number corresponding to your current Windows install
    4. Run the following command where `X` corresponds to the one found with the previous command `DISM /Export-Image /SourceImageFile:Install.esd /SourceIndex:X /DestinationImageFile:Install.wim /Compress:max /CheckIntergrity`
3. Run `DISM /Online /Cleanup-Image /RestoreHealth /Source:WIM:c:\\install.wim:1 /LimitAccess`
4. End by running `SFC /SCANNOW` and restarting if needed.

Alternitively, you can run:
```
DISM /Online /Cleanup-Image /RestoreHealth /Source:WIM:c:\\install.wesdim:X /LimitAccess
```
Where `X` is the index previously found in stop 2.3 .