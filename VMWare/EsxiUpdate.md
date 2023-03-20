# ESXI update

> You can use `vmware -v` in SSH to confirm the version you're running on.

1. Download the corresponding update file from VMware
2. Upload the file onto the server's repository
3. Shut down all VM's running on the host
4. Enabled SSL on the host
  1. Right click the host
  2. Services
  3. Enabled Secure Shell (SSH)
5. Connect to the host using SSL
6. Run `esxcli software vib update -d /vmfs/volumes/UpdatePackage.zip --no-sig-check`. Where `/vmfs/volumes/UpdatePackage.zip` is the path towards the update you uploaded to the datastore
7. Restart the ESXI: `reboot`
