# Group Policy processing failure

> [Source](https://woshub.com/group-policy-processing-failed-windows/)

## Problem
When attemting to run `GPUPDATE /FORCE` onto  a device, you will get the following output:
```
Computer policy could not be updated successfully. The following errors were encountered:
The processing of Group Policy failed. Windows could not apply the registry-based policy settings for the Group Policy object LocalGPO. Group Policy settings will not be resolved until this event is resolved. View the event details for more information on the file name and path that caused the failure.
```
The event viewer system logs should also contain the following:
  ID: 1096
  Source: Microsoft-Windows-GroupPolicy

## Solution
Rename the corrupted local policy file:
```bat
cd C:\Windows\System32\GroupPolicy\Machine
ren Registry.pol Registry.bak
```
And run `GPUPDATE /FORCE` in order to re-generate the file.