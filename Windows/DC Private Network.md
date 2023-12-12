# Domain Controller: Private network connection

Possible solutions for when a domain controller's network connection changes to Private or Public.

## Modifying Network Location Awareness service dependencies
>
> [Source](https://freddejonge.nl/windows-server-2019-domain-controller-keeps-network-on-private/)

1. Open the registry editor. `Regedit`
2. Navigate to: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc`
3. Doube click the `DependOnService`-key
4. Add `Netlogon` at the end of the list
5. Restart the server

## Modifying Network Location Awareness service startup type

1. Open the services. `Service.msc`
2. Scroll down to the `Network Location Awareness`-service
3. Right click the service
4. Select `Properties`
5. Under `Startup type` select `Automatic (Delayed Start)`
