# Sfcbd-watchdog cannot be started

> [Source](https://www.claudiokuenzler.com/blog/1280/how-to-enable-cim-server-wbem-service-esxi-8)

## Requirements

:warning: SSH needs to be enabled on the host in question.

## Procedure

1. Connect to the host using SSH
2. Attempt to start the service manually: `/etc/init.d/sfcbd-watchdog start`
3. If the output of the command is similar to:
   `sfcbd-init[3011634]: sfcbd not started, administratively disabled.`
4. Run the following command: `esxcli system wbem set -e true`
5. Run the following command to verify the service is started: `/etc/init.d/sfcbd-watchdog status`
