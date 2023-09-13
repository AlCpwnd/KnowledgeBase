# Azure AD Link Fail
> [Source](https://stackoverflow.com/questions/42805114/how-to-set-immutable-id-of-an-msoluser-to-null-value-using-powershell)

1. Connect onto the server hosting Azure AD Sync service.
2. Recover the GUID from the concerned user:
    ```ps
    $User = 'john'
    $GUID = (Get-ADUser $User).ObjectGUID
    ```
3. Encryp the GUID in base64:
    ```ps
    [Convert]::ToBase64String([guid]::New($GUID).ToByteArray())
    ```
5. Move the user to a OU that isn't in the sync.
6. Run a sync:
    ```ps
    Start-ADSyncSyncCycle
    ```
7. Connect to the MSOnline services:
    ```ps
    Connect-MsolService
    ```
8. Define the user's `ImmutableID` using the encrypted string found in step `3`:
    ```ps
    Set-MsolUser -UserPrincipalName <john@contosco.com> -ImmutableId <Encrypted GUID>
    ```
9. Move the user back to a synced OU on within the AD.
10. Run the Azure AD Syc again:
    ```ps
    Start-ADSyncSyncCycle
    ```