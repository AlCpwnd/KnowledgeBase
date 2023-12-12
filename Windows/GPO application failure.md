# Group Policy Application failure

## Problem

When attempting to apply a group policy to a specific security group, the group policy doesn't show up when running `GPRESULT /R`.

## Solut8ion

Add the following permission in the `Delegation` tab:

```txt
Name:           Authenticated Users
Permissions:    Read
```

Run the `GPUPDATE /FORCE` again on the concerned device.
