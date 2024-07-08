# Migration Process

This page will provide an overview only. The steps of each phase below are not claimed to be complete. For the very technical details, see the Confluence pages [Technical Steps](https://confluence.henkelgroup.net/display/DigiLab/Technical+Steps) and [Migration to Equinix](https://confluence.henkelgroup.net/display/DigiLab/Migration+to+Equinix) (limited access only) or read the playbooks.

The migration process consists of the multiple phases:

* [Migration Preparation](#migration-preparation)
* [Migration](#migration)
* [Migration Postcleanup](#migration-postcleanup)
* [Archiving](#archiving)

The migration is only possible for VMs with the variable `equinix_no_migration` set to `false` (which is the default value). This variable could be set in the inventory in the VM `host_vars` file itself or in `group_vars`.

The status of the migration is reflected in the variable `migration_status`. If the variable is not present in VM inventory file, it defaults to `to_be_migrated`.


## Migration Preparation

Some of the checks described in [Migration Requirements](migration-requirements.md) are listed here.

### Precheck

* Check /etc/fstab for mounts via devices instead of labels

### Preparation in vCenter

* Shutdown VM
* Remove Snapshots
* Remove CD-ROM / DVD
* Check whether VM is in proper datastore
* Power on VM for further preparation

### Preparation in VM OS

* Create local user `dlo_sv_scripts` with sudo config
* Prepare future network configuration
* Lower sssd settings for migration

### Preparation on NetApp

* Trigger syncmirror from DUS to FRA: After this we can be sure that the latest changes to the VM have been replicated to FRA from where we will import the VM

## Migration

* Create VM in Proxmox cluster
* Configure VM
* Import disks

## Migration Postcleanup

* Cleanup in VM
  * Restore sssd settings for migration
  * Remove old networking config
  * Modify target server from repo configuration

* Remove VM from vCenter

At the end of this phase, the inventory file of the VM will contain the variable `migration_status` with value `to_be_archived`.

## Archiving

* Compress VM into archive on Synology and remove from DUS NetApp

At the end of this phase, the inventory file of the VM will contain the variable `migration_status` with value `completed`.
