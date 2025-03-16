
# SOP: Resizing Ubuntu Disk in UTM VM

## Objective

Expand the disk space of an Ubuntu guest OS within a UTM VM.

## Steps:

1.  **UTM Resize:**
    *   Shut down the VM.
    *   In UTM, edit the VM configuration.
    *   Select the disk to expand.
    *   Resize the disk.
    *   Save the configuration.

2.  **VM Startup & Initial Checks:**
    *   Start the VM.
    *   Open a terminal.
    *   `sudo fdisk -l`:  Verify a "GPT PMBR Size Mismatch" warning.  This is expected and will be fixed.

3.  **Fix Partition Table (GPT):**
    *   `sudo parted -l`: `gparted` should prompt to fix the size mismatch automatically.  Choose "Fix".
    *   **Manual Fix (If needed):**  If the automatic fix fails: `sudo parted /dev/vda resize 3 100%`  (This resizes partition 3 to use 100% of the available space).

4.  **Resize Physical Volume (PV):**
    *   `pvresize /dev/vda3`

5.  **Extend Logical Volume (LV):**
    *   `sudo lvm` (Enter LVM console)
    *   `lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv` (Expands the logical volume to use all available free space.)
    *   `exit` (Exit LVM console)

6.  **Resize Filesystem (ext4):**
    *   `sudo resize2fs /dev/ubuntu-vg/ubuntu-lv`

7.  **Verification:**
    *   `df -h`: Confirm that `/dev/mapper/ubuntu--vg-ubuntu--lv` (or your equivalent) shows the increased size.

**Key Commands Summary (in order):**

*   `sudo fdisk -l`
*   `sudo parted -l`  (or `sudo parted /dev/vda resize 3 100%`)
*   `pvresize /dev/vda3`
*   `sudo lvm`
    *   `lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv`
    *   `exit`
*   `sudo resize2fs /dev/ubuntu-vg/ubuntu-lv`
*   `df -h`

**Notes:**

*   `/dev/vda` is assumed to be the main disk.  Adjust if necessary.
*   `/dev/vda3` is assumed to be the relevant partition. Adjust if necessary.
*   `/dev/ubuntu-vg/ubuntu-lv` is the standard LVM logical volume path, but double-check with `df -h` before running `lvextend` and `resize2fs`.  Adapt the commands if your paths are different.
* This SOP is for Ubuntu, other distributions might vary.
