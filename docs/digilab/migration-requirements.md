# Migration VM Requirements

The following requirements for a VM must be met.

## Power State

!!! success "Note"

    The VM has to be running.

## Datastore Location

!!! success "Note"

    This is checked by the migration playbooks.

The VM has to be located in either `FP_ESX_Z38_NFS` or `FP_ESX_E20_NFS` only. No second datastore allowed.

## Snapshots

!!! success "Note"

    This is checked by the migration playbooks.

The VM must not have any snapshots.

## CD-ROM / DVD

!!! success "Note"

    This is checked by the migration playbooks.

The VM must not have any CD-ROM or DVD mounted because the mount might cause the VM to be present in multiple datastores.

## /etc/fstab

### Devices vs. Labels

!!! success "Note"

    This is checked by the migration playbooks.

### NFS Mounts on dedussv-fpnas03

!!! warning

    This is **NOT checked** by the migration playbooks.

Any occurrence of `dedussv-fpnas03-ic.henkelgroup.net` has to be replaced with `dedussv-fpnas03.henkelgroup.net`.

Also the Synology cannot be configured via Ansibles. Therefore the NFS share needs to be prepared with the future Frankfurt IPv6 address manually.

