# Restore a migrated VM in vCenter

There might be the need to restore a VM again in vCenter. The required steps depend on the migration status of the VM, which could be either `to_be_archived` or `completed`.

!!! warning

    Note that restoring will not restore the custom attributes like owner, enddate, etc. in vCenter.

## VM is in migration status `to_be_archived`

* Log in to the vCenter and go to the datastore where the VM is located. This will be either `FP_ESX_E20_NFS` or `FP_ESX_Z38_NFS`.
* In file view navigate to the VM folder.
* Select the `.vmx` file and click `Register VM`
* Revert the migration commit of the inventory file.

## VM is in migration status `completed`

* Log in to one of the Proxmox hosts and become root.
* Locate the VM folder in either `/mnt/DIGILAB/MIGRATED_E20/` or `/mnt/DIGILAB/MIGRATED_Z38/`
* Set `VM` to the shortname of the VM to be restored.
* Unarchive the VM to the corresponding share in Düsseldorf `/mnt/DIGILAB/ORIGINAL_Z38/` or `/mnt/DIGILAB/ORIGINAL_E20/` via this command:

    ```
    /usr/bin/7z x /mnt/DIGILAB/MIGRATED_E20/${VM}.7z.001 -o/mnt/DIGILAB/ORIGINAL_E20/
    ```

* Now that the VM has been "unarchived", follow the steps for status `to_be_archived`.

!!! info "A Note Regarding the Mounts"

    Note that the mountpoints are mounted via the playbooks on the fly. They do not appear in local `/etc/fstab`.

    Please find the mountpoint information in archiving playbook variables.