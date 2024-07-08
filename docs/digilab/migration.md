# DigiLab Migration

This page documents the few steps of how to migrate a VM from legacy DigiLab to DigiLab in Private Cloud in Frankfurt.

For more background information, please read [Migration Process](migration-process.md).

!!! danger "Attention"

    Ensure that your environment meets the technical [prerequisites](migration-prerequisites.md).

!!! question "Info"

    Ensure that the VM meets the [migration requirements](migration-requirements.md).

Set the variable `VM` to the VMs that will be migrated, e.g.:

```
VM=dedussvi70004.henkelgroup.net,dedussvi70012.henkelgroup.net
```

Ensure that each of the specified VMs is running.

Run the playbooks:

```
time ansible-playbook equinix_vm_destroy.yml --limit ${VM} && time ansible-playbook eqx_migration.yml --limit ${VM}
```

After successful migration, archive the VM by running the `eqx_migration_archive` playbook:

```
time ansible-playbook eqx_migration_archive.yml --limit ${VM}
```

If - for whatever reason - the VM needs to be restored in vCenter, follow the [restoration guide](migration-restore.md).