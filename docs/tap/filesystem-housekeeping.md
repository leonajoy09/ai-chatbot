# Filesystem Housekeeping

## Problem Statement

Systems, applications, middleware, etc. usually write log-files. These log-files occupy precious filesystem space and should not be kept longer than necessary.
For pay-per-use based storage, this does not only occupy the technical resource (storage space), but also are perfectly avoidable costs.

When it comes to log-files, as a general statement, 3 different types can be classified:


| Classification | Description | Examples | Holding time |
| --- | --- | --- | --- |
| Technical Log | Contain only technical information, which are only helpful for timely technical troubleshooting and analysis | Webserver logs, mailserver logs, etc. | 14 days |
| Transactional log | Contain application-level transactional information. Should generally be stored elsewhere, e.g. in a database.<br /><br />Should not be stored solely in files for integrity reasons, as files can easily be modified.<br /><br />Log is required to understand details about a transaction triggered by a user or a system. | Database transaction logs / archive logs, application level logs | 90 days |
| Legal hold | Same as transactional log, but there is a legal aspect which enforces a certain minimum, maximum or on-point holding time. | Signing-off on invoices | depends on use-case |

## Assumptions

Experience shows that outdated backup files of former application software versions, former database exports, etc. are kept much longer than required,
sometimes for several years. Responsible persons change over time and the successors are sometimes too "afraid" to remove outdated data,
as they are not certain whether they might still need it or not.
Additionally to that, many systems are not perfectly built or configured in terms of when to remove outdated information.
Furthermore, many files simply are also not compressed, despite not regularly read from.

Most tasks of rotating out log-files can be automatized, whereas they are compressible in the same go.
Human interaction is not required for these tasks.

## Motivation
Reduction in the amount of unjustified usage of storage space and therefore reduce run-cost for pay-per-use based storage.
Both will allow for more efficient resource utilization.

## Implications
Housekeeping jobs, scripts, configurations, etc. need to be created. When reading compressed files, an appropriate tool needs to be used (e.g. zless, zgrep, etc.).