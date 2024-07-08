# Alerts for VMs

## Introduction

The Henkel Platform provied an easy opt-in way to get general VM alerts. These alerts are generalized and simple alerts which might not be enough if you are looking for more indepth and specialized alerts.

## How to opt-in

In order to opt in you need to create the `vm_alerts` object in the `config.json`. When this is present you will be required to input at least one email for the emails to receive the alerts and one location. These locations should be the locations of your VMs in your subscription.

```json
{
  "landing_zone": {
    "environments": {
      "nonprod": {
        "subscriptions": {
          "tst": {
            "vm_alerts": {
              "alert_emails": [ "emailToReceiveAlerts@henkel.com" ],
              "locations": [ "West Europe" ]
            }
          }
        }
      }
    }
  }
}
```

## Alerts supported

We have to types of alerts, dymanic alerts and static alerts. The dynamic alerts calculates thresholds for when to alert themselves by feeding past data into some machine learning models which are controlled by Microsoft. The static alerts is where we have set a threshold our self.

Be aware dynamic alerts can take a couple of days to be activated since they need to gather data before they can start alerting based on that.

The following alerts are supported as of now:

- CPU (Dynamic)
  - Triggers CPU is abnormally low
- Availability (Static)
  - Triggers is the VM is unavailable
- Low Memory (Dynamic)
  - Triggers if the memory of a VM is abnormally low
- Data IOPS (Dynamic)
  - Triggers if the Data Disk Input/Output Per Second is abnormally high
- OS IOPS (Dynamic)
  - Triggers if the OS Disk Input/Output Per Second is abnormally high
- Backup Failures (Static)
  - Triggers if a backup made by the Recovery Service Vault fails
  - This only works if the Landing Zone has opted in to using the [backup feature](backup.md)

## Deployed Resources

The following resources will be deployed into your subscription if you opt-in:

- A resource group with a name like `dx-weu-dev-<lzname>-vmalerts-rg`
- An alert processing rule with name `dx-weu-dev-<lzname>-vmalerts-vmbackup-apr`

For each location given in the config the following will be deployed:

- An Action group with name `dx-weu-dev-<lzname>-vmalerts-ag`
- A metric alert with name `dx-weu-dev-<lzname>-vmalerts-<location>-cpu-metricalert`
- A metric alert with name `dx-weu-dev-<lzname>-vmalerts-<location>-availability-metricalert`
- A metric alert with name `dx-weu-dev-<lzname>-vmalerts-<location>-lowmemory-metricalert`
- A metric alert with name `dx-weu-dev-<lzname>-vmalerts-<location>-dataiops-metricalert`
- A metric alert with name `dx-weu-dev-<lzname>-vmalerts-<location>-osiops-metricalert`