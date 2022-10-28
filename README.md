# KnowledgeBase
Random Collection of knowledge

---
## Windows
### DISM Repair with ISO file
> [Source](https://ugetfix.com/ask/how-to-fix-dism-error-0x800f081f-in-windows/)
Steps to follow in case neither `SFC /SCANNOW` and `DISM /Online /Cleanup-Image /RestoreHealth` fail to repair the system files.
0. (Optional) Download the ISO file corresponding to the OS you want to repair
1. Mount the ISO file within the operating system you are trying to repair
2. Find the "Install.*" file within the "source" folder of your mounted image.
    a. Install.wim
        1. Copy the file to your windows directory: `C:\Install.wim`
    b. Install.esd
        1. Copy the file to your windows directory: `C:\Install.esd`
        2. Start CMD as Admin and navigate to the same folder
        3. Run `dism /Get-WimInfo /WimFile:install.esd` and take note of the index number corresponding to your current Windows install
        4. Run the following command where `InexNumber` corresponds to the one found with the previous command `DISM /Export-Image /SourceImageFile:Install.esd /SourceIndex:IndexNumber /DestinationImageFile:Install.wim /Compress:max /CheckIntergrity`
3. Run `DISM /Online /Cleanup-Image /RestoreHealth /Source:WIM:c:\\install.wim:1 /LimitAccess`
4. End by running `SFC /SCANNOW` and restarting if needed.