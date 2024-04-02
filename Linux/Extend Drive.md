# Extend Drive

This procedures describes the steps needed to extend the drive on a Linux Ubuntu device after assigning it space within VMware.

> :warning: All the commands below require `sudo` permissions.

0. Allocate the additionnal space within your VMware environment.
1. Run the following in order to rescan the disks:

    ```bash
    echo - - - | sudo tee /sys/class/scsi_device/*/device/rescan
    ```

2. Run the following command in order to confirm that the added space is available in the VM:

    ```bash
    lsblk
    ```

3. Run the following in order to allocate the added space:

    ```bash
    parted /dev/sda
    ```

4. Run `print` in order to display the available partitions.
5. You should then receive the following message:

    ```bash
    Warning: Not all of the space available to /dev/vda appears to be used, you can fix the GPT to use all of the space (an extra xxxxxxxx blocks) or continue with the current setting?
    Fix/Ignore?
    ```

    Type `F` or `Fix`

6. Run the following command in order to extend the partition:

    ```bash
    resizepart 3 100%
    ```

7. Run `quit` in order to exit parted.
8. Run `lvdisplay -v` in order to show your Logical Volume information ant note your `LV Path`:

    ```bash
      --- Logical volume ---
      LV Path                /dev/ubuntu-vg/ubuntu-lv  # <- This is what you need
      LV Name                ubuntu-lv
      VG Name                ubuntu-vg
      LV UUID                KT6pfm-b2ww-KtzK-B9eT-Xh0d-6nWu-Bd11LJ
      LV Write Access        read/write
      LV Creation host, time ubuntu-server, 2023-09-12 06:51:06 +0000
      LV Status              available
      # open                 1
      LV Size                <68.00 GiB
      Current LE             17407
      Segments               1
      Allocation             inherit
      Read ahead sectors     auto
      - currently set to     256
      Block device           253:0
    ```

9. Run `lvresize --extents +100%FREE --resizefs /pathnoted/inpreviousstep` in order to extend the file structure.
    a. You may get the following warning, this means you'll need to update the size of the Physical Volume.

    ```bash
    Size of logical volume /pathnoted/inpreviousstep unchanged from xx.xx GiB.
    resize2fs 1.46.5 (30-Dec-2021)
    The filesystem is already xxxxx (4k) blocks long.  Nothing to do!
    ```

    b. Run `lsblk` in order to identify the volume on which Physical Volume your drive is located on.
    c. Run `pvresize /pathto/physicalvolume`
    d. Run the command from step 9 again.

10. Run `df -h` in order to confirm the partition was extended as expected.