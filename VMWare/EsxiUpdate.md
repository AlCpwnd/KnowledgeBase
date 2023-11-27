# ESXI update

> You can use `vmware -v` in SSH to confirm the version you're running on.

This procedure goes over the steps requires to install the **ESXI Offline Bundle** update on a host.

1. Go to [VmWare Customer Connect](https://my.vmware.com/) and connect with your account
2. Go to `Downloads` and choose the update corresponding to your ESXI version
3. Open your ESXI web UI by navigating to its URL
4. Upload the update ZIP file to the datastore
5. Shut down all running VM's
6. Set the host in maintenance mode
    1. Enable SSH on the host
7. Connect to the host using SSL
8. Run the following command to find the profile name:
  `esxcli software sources profile list -d <Full path to the update ZIP file>`
9. Choose the corresponding not-security only, standard update:
  In the example below:
  `ESXi-ESXi-7.0U3sl` : The `s` before the version (`l`) stands for security and contains only the security updates (Not the feature updates), therefore not the version we want.

  ```bash
  Name                            Vendor        Acceptance Level  Creation Time        Modification Time
  ------------------------------  ------------  ----------------  -------------------  -----------------
  ESXi-7.0U3sl-21422485-standard  VMware, Inc.  PartnerSupported  2023-03-30T00:00:00  2023-03-30T00:00:00  
  ESXi-7.0U3sl-21422485-no-tools  VMware, Inc.  PartnerSupported  2023-03-30T00:00:00  2023-03-10T16:04:06
  ESXi-7.0U3l-21424296-standard   VMware, Inc.  PartnerSupported  2023-03-30T00:00:00  2023-03-30T00:00:00  # --> Profile you want.
  ESXi-7.0U3l-21424296-no-tools   VMware, Inc.  PartnerSupported  2023-03-30T00:00:00  2023-03-11T01:18:32
  ```

10. Run the following command with the profile name found in step `9.`:
  `esxcli software profile update -d <Full path to the update ZIP file> -p <Profile name>`
11. Restart the host: `reboot`
