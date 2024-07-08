## GCP Backup factory

# Backup Factory Configuration

The Backup and DR Factory provides automated onboarding of VMs and applications to the centrally managed Google Backup and Disaster Recovery solution. Configuration files are used to define backup plans and templates by project within the Google Cloud Platform (GCP). This file specifies the necessary parameters for creating and managing backups, ensuring data integrity and availability.

## Getting Started

To implement backup plans using the Backup Factory, follow these steps:

1. **Create folders and files for the project**
    - Clone the repository (e.g. `git clone https://gitlab.gcp.henkelgroup.io/hmcp-gcp/backup-dr-factory-config.git`) and create a feature branch.
    - Create a folder for the project in the relevant henkel organization (e.g. `henkelcom`).
    - Create subfolders for each required environment (e.g. `dev`, `test`, `prod`, `prod-dmz`), and a `config.yaml` file in each folder, and enter the details. A schema is provided to give some syntax highlighting for available values (see [here](/schemas/schema.md)).

2. **Create a Merge Request (MR) on GitLab:**
   - Create an MR in the repository with the changes. This will run a validation pipeline to check that everything is updated as it should, and ensure that the management console has the information required to onboard the VMs to the backup plans defined.

3. **Install Agents on Virtual Machines (VMs) for Database Backups:**
   - For database backups (`backup_type: db`), ensure that agents are installed on the relevant VMs. This is required for backup operations. It is possible to do this in an automated way using startup scripts provided by the platform team. Set the following metadata on the VM instance, via console or terraform configuration.

    ```terraform
    # For Windows
      metadata = {
          "windows-startup-script-url" = "gs://hnk-hmcp-share-ad-auto-de-prj-dpo/windows/Invoke-StartupScripts.ps1"
          "backupagent"                = true
      }
    ```

    ```terraform
    # For Linux
      metadata = {
        "startup-script-url = "gs://hnk-hmcp-share-ad-auto-de-prj-dpo/linux/startupscript.sh
        "backupagent"       = true 
      }
    ```
  
   - After agents are installed on the VM, trusted communication must be established between the backup appliance and the host VM. To ensure this trusted communication, a secret must retrieved from the host VM, and be updated in the Backup and DR Management Console. This is currently a manual effort that requires the following:
        - Access the VM (RDP/SSH or using IAP). Open Windows Powershell as administrator and run the `New-HenkelGCPBackupAgentSecret.ps1`.
        - Copy the secret value from the output, and update the host in the Backup and DR management console with the value.

Below are six examples of Backup Factory configurations, showcasing different scenarios:

### Example 1: GCE Continuous Backup Plan

```yaml
project_id: "my-gcp-project"
backup_plans:
  - description: "Windowed Backup for GCE Instances"
    unique_suffix: "vm1"
    backup_type: "gce"
    template: migration-stream-default-eu
    disaster_recovery: false
    geography: "us"
    apply_to:
      - "myVM1"
      - "myVM2
```

**Description:**
This example demonstrates a windowed backup plan for Google Compute Engine (GCE) instances. The `template` property is provided as a string, indicating that a default template defined in the [backup factory](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/backup-dr-factory) repository will be used to apply backup template settings. See [README](https://gitlab.gcp.henkelgroup.io/hmcp-gcp/backup-dr-factory/-/blob/main/README.md) in that repository for guidelines on adding additional default templates.

### Example 2: Database Windowed Backup Plan

```yaml
project_id: "another-gcp-project"
backup_plans:
  - description: "Windowed Backup for Database"
    backup_type: "db"
    template:
      application: "SqlInstance"
      scheduling: "windowed"
      retention: 4
      retention_interval: "weeks"
      snap_retention: 3
      repeat_every: 1
      repeat_interval: "hours"
      starttime: "21:30"
      endtime: "22:30"
      backup_logs: true
      log_config: 
        log_onvault: true
        log_rpo: 15
        log_retention: 4
    disaster_recovery: false
    geography: "eu"
    apply_to:
      - "myDatabaseServer"
```

**Description:**
This example illustrates a windowed backup plan for a database instance. It includes specific settings for retention, scheduling, and time intervals. It specifies that snapshot retention should be for `3` days (snapshot retention always specified in days). Onvault storage pool (cloud storage bucket) has 4 weeks retention, and can be considered the long-term storage in this case. The property `backup_logs` specifies that transaction log backups should be performed, which means that Point-in-Time recovery is enabled (this is only possible if the database is in FULL recovery mode). The `log_config` block can specify settings related to storing the transaction logs, e.g. whether to also backup the transaction logs to the long-term storage, how long the log backups should be retained (in days), and the rpo (how often transaction logs should be backed up) in minutes. The minimum `log_rpo` is 15 minutes.  

### Example 3: GCE Continuous Backup Plan with DR

```yaml
project_id: "yet-another-gcp-project"
backup_plans:
  - description: "Continuous Backup for GCE Instances"
    backup_type: "gce"
    disaster_recovery: true
    template:
      scheduling: "continuous"
      retention: 15
      retention_interval: "days"
      repeat_every: 120
      repeat_interval: "minutes"
      starttime: "20:00"
    geography: "apac"
```

**Description:**
In this example, a continuous backup plan for GCE instances is defined with disaster recovery enabled. This means backups will also be stored in a separate GCP region, to ensure availability in case of a regional outage. It includes specific settings for retention, scheduling, and time intervals. The backup plan is associated with the Asia-Pacific ("apac") geographical region. No VMs have been specified in the `apply_to` list, however, this can be added at a later stage.

### Example 4: Critical GCE Continuous Backup Plan

```yaml
project_id: "critical-project"
backup_plans:
  - description: "Continuous Backup for GCE Instances (Critical)"
    backup_type: "gce"
    template:
      scheduling: "continuous"
      retention: 60
      retention_interval: "days"
      repeat_every: 30
      repeat_interval: "minutes"
      starttime: "20:00"
    disaster_recovery: true
    geography: "us"
```

**Description:**
In this example, a critical continuous backup plan for GCE instances is defined. It includes specific settings for retention, scheduling, and time intervals. Disaster recovery is enabled, and uses continous scheduling with backup jobs running every 30 minutes. Retention of backup copies is set to 60 days.

Please replace the placeholder values with your actual project details and adjust other parameters as needed. Ensure agents are installed for database backups to function effectively. Remember to create an MR on GitLab for incorporating these configurations into your project.

## Config Reference  

| Name | Property details| Description | Allowed Values | Remarks | 
 |----------|----------|----------|----------|----------|
|`project_id`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |Valid GCP Project id where the target VM or DB instance to be backed up is running|||
|`backup_plans[]`| ![Static Badge](https://img.shields.io/badge/array-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |A list of backup plans for the project|||
|`backup_plans[].description`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |Description of the backup template in the console||`e.g.Production SQL server backups west europe`|
|`backup_plans[].backup_type`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |Type of backup, currently supports GCE instance backups and database backups|`gce, db`||
|`backup_plans[].template`| ![Static Badge](https://img.shields.io/badge/object-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The template defines policies and configuration values for how and when to backup applications|||
|`backup_plans[].disaster_recovery`| ![Static Badge](https://img.shields.io/badge/boolean-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |Defines if backups should also be created in the secondary region in case of a region-wide failure in GCP|`true, false`||
|`backup_plans[].geography`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |The geographical region of the resources to backup for this plan.|`us, eu, apac`||
|`backup_plans[].unique_suffix`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |A short sequence of characters that uniquely identifies the template. Required and should not be changed after initial creation.||`e.g. sql1, vm1`|
|`backup_plans[].apply_to[]`| ![Static Badge](https://img.shields.io/badge/array-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |A list of GCP GCE or DB instance names that should have the specified application, and which the plan should apply to|||
|`backup_plans[].template`| ![Static Badge](https://img.shields.io/badge/object-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |Possible template configuration values in case of GCE instance backup plan|||
|`backup_plans[].template.scheduling`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |Which type of scheduling should be used, windowed performs backup only in a certain timeslot, continuous at the time interval specified|`windowed, continuous`||
|`backup_plans[].template.retention`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |How long (numerically) to retain copies of the data, combined with the retention_interval (e.g. days, weeks)|`numeric value`|`e.g. 7, 14, 30 etc.`|
|`backup_plans[].template.retention_interval`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |Time unit for the retention|`minutes, hours,days, weeks,months, years`||
|`backup_plans[].template.repeat_every`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |How often (numerically) to run backup jobs. Often referred to as the Recovery Point Objective (RPO). If windowed, this value will only be repeated within the given time window|`numeric value`|`e.g. 7, 10,30 etc.`|
|`backup_plans[].template.repeat_interval`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |Time unit for the repetition interval|`minutes, hours`||
|`backup_plans[].template.starttime`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |UTC time to start the backup plan (or backup window for windowed scheduling), in the format HH:MM (e.g. 19:00)|`Time in the format HH:MM`|`e.g. 17:00`|
|`backup_plans[].template.endtime`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |UTC time to end the backup window, in the format HH:MM (e.g. 19:00). Only relevant for windowed scheduling|`Time in the format HH:MM`|`e.g. 19:00`|
|`backup_plans[].template.snap_retention`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |How many days to retain snapshot of database (this can be considered a short-term storage, where onvault is long-term storage)|`numeric value`|`e.g. 7,10,20 etc.`|
|`backup_plans[].template.backup_logs`| ![Static Badge](https://img.shields.io/badge/boolean-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |Enable DB transaction log backups. Applicable only to backup_type: db i.e.database backups |`true, false`||
|`backup_plans[].template.application`| ![Static Badge](https://img.shields.io/badge/string-yellow) ![Static Badge](https://img.shields.io/badge/required-red) |Type of application to backup, currently only SQL Server supported|`SqlInstance`||
|`backup_plans[].template.log_config`| ![Static Badge](https://img.shields.io/badge/object-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |Configuration properties for transaction log backups, only relevant for database backups|||
|`backup_plans[].template.log_config.log_rpo`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |How often (interval) in minutes to run transaction log backup jobs. This is effectively the RPO of a database backup with full recovery mode set. Minimum 15 mins supported|`numeric value`|`e.g 15, 60 etc.`|
|`backup_plans[].template.log_config.log_retention`| ![Static Badge](https://img.shields.io/badge/integer-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |How many days to retain backups of transaction logs. Minimum 1 day and Maximum 90 days supported|`numeric value`|`e.g. 1, 30, 90 etc.`|
|`backup_plans[].template.log_config.log_onvault`| ![Static Badge](https://img.shields.io/badge/boolean-yellow) ![Static Badge](https://img.shields.io/badge/optional-green) |Should transaction logs also be backed up to the onvault storage|`true, false`||
