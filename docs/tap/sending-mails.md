# Sending SMTP Mails from Systems and Applications

## Problem Statement

Certain systems and applications need to be able to send outbound emails via SMTP.
They need to be able to do it in a secure and reliable way, via encryption and using authentication, allowing full transparency on who-sent-what-when-from-where.
IP allowlisting must be avoided in order to allow horizontal scalability and migration of use-cases to other infrastructure (= other IPs).

## Information
A high-available pair of SMTP servers (running Postfix) are located behind a network load balancer.
The DNS name for this service is `sendmail.henkelgroup.net`

SMTP services are reachable on ports:

* 25 (using STARTTLS)
* 587 (using STARTTLS)
* 465 (SMTPS, encrypted without further ado)

The SMTP servers itself will authenticate against Active Directory in the background.
All clients which want to send emails are required to authenticate and being authorized for mail-relaying via membership in Active Directory group `corp-adm-smtprelayallow`,
which is administered by the Data Center Service Manager for Utility/Infrastructure and the Office 365 Mail Team.

Through recipient-domain-based local SMTP-routing, (at a later point in time) technical mails can be directly delivered from `sendmail.henkelgroup.net` to applications or systems having their own SMTP service (e.g. SAP systems)
The SMTP gateway is **not a mailbox system**, therefore POP3/IMAP will not work.
As a default, it will route all mails to the Office 365 SMTP host, excluding the ones with local SMTP-routing.

## Implementation

* SMTP requires a functional Active Directory account **per use case** created via [myID](https://myid.henkelgroup.net/home.jsf) and membership in Active Directory group `corp-adm-smtprelayallow`
* The functional account needs to be configured on application/system level (with credentials) to allow sending of emails
  * It is recommended to have the credentials being non-expirational
* Your connection is required to be encrypted, using STARTTLS (via port 25 or 587) or implicit SSL (SMTPS, via port 465) - otherwise your attempt will be rejected from the SMTP system.