## Labelling scheme/convention
We follow below general guidleines for labelling GCP resources.
### Labelling Resources (Labels aka Tags)

 Use of labels (or tags) helps to add information to further categorize resources, such as `cost-center`. Labels are also helpful in situations when you can’t manage resource names directly, but you can manage a set of labels that is propagated to the child resources (e.g. GKE Cluster labels or Instance Groups).

Do not duplicate information already contained in your naming convention (such as `project`) or create large numbers of unique labels with information that can be obtained from the objects themselves (such as `creationTimestamp`).

**Labels for cost allocation**

Typically, use business labels such as cost center, business unit, or project to
associate  costs with traditional financial reporting dimensions within the organization.

**Labels for automation**

Resource or service-specific labels are often used to filter resources during infrastructure
automation activities. Labels can be used to opt into or out of automated tasks, or to identify
specific versions of resources to archive, update, or delete. For example, if you run
automated start/stop scripts that turn off development environments during non-business
hours to reduce costs. In this scenario, VM instance labels are a simple way to identify the specific development instances to opt into or out of this process

**Labels for operational support**

Labels can be used to integrate support for cloud resources into day-to-day operations including
IT Service Management (ITSM) processes such as Incident Management. For example, Level 1
support teams could use labels to direct workflow and perform business service mapping as part
of the triage process when a monitoring system triggers an alarm. Also it is very common to use
labels to support processes such as backup/restore and operating system patching etc.

**Labels for access control**

Identity and Access Management (IAM) policies support label-based conditions, enabling
 to constrain permissions based on specific labels and their values. For example, IAM
user or role permissions can include conditions to limit access to specific environments (for
example, development, test, or production) or Virtual Private Cloud (VPC)
networks based on their labels.

**Labels for security risk management**

Labels can be assigned to indetify resources that require hightened security risk management practices such as VM instance hosting application that processes sensitive or confidential data (e.g. PII, PCI). This can enable automated compliance checks to ensure that proper access controls are in place, patch compliance is upto date, & so on.



GCP labelling scheme for Project as well as resources (such as GCE instance, cloud storage bucket etc) is documented in below sharepoint location. 

https://henkelgroup.sharepoint.com/:x:/r/teams/MST-C-HybridCloud/_layouts/15/Doc.aspx?sourcedoc=%7B1AB0EFD7-EC15-4351-B280-A9A54765E335%7D&file=Henkel%20GCP%20Labelling%20Scheme%20-%20v1.0.xlsx&wdLOR=cF4716A05-7D93-3A4A-84D7-99ABA8A32BDA&action=default&mobileredirect=true&isSPOFile=1