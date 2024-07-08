# Target System Landscape

In order to create a wide and large homogeneous system landscape, a certain level of standardization will be applied during the migration activities.

Below, you will find the possible target technologies for the deployments in the current IBM classical Data Center aka. as "DCO/DCS".

* [Operating Systems](#operating-systems)
* [Database](#database)
* [Web Environment](#web-environment)
* [SSL](#ssl)
* [Java](#java)


## Operating Systems

<table>
    <thead>
        <tr>
            <th>Source</th>
            <th>Target</th>
            <th>Comments</th>
            <th>Fallback Targets</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Windows Server 2008/2012/2012R2/2016</td>
            <td>Windows Server 2019<br/><img alt="Windows Server 2019" src="../../images/windows-server-2019.png" /></td>
            <td>
                <ul>
                    <li>Ensures no required major release upgrades on a long-term basis</li>
                </ul>
            </td>
            <td>
                Windows 2016
                <ul>
                    <li>Unwanted target, only applicable if source is lower than Windows Server 2016</li>
                    <li>Will need major release upgrade much sooner than Windows Server 2019</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>SuSE Linux Enterprise Server (SLES, any version)</td>
            <td rowspan="3">RedHat Enterprise Linux 8 (RHEL 8)<br /><img alt="Red Hat Enterprise Linux 8" src="../../images/RHEL8.png" /></td>
            <td rowspan="2">
                <ul>
                    <li>License provided within management fee by IBM only for RHEL</li>
                    <li>RHEL is an IBM product</li>
                    <li>End of support date beyond IBM contract</li>
                </ul>
            </td>
            <td>
                RedHat Enterprise Linux 7 (RHEL 7)
                <ul>
                    <li>Unwanted target, only applicable if source is either SLES (any version) or RHEL 7 or lower</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>RedHat Enterprise Linux 7 or lower (RHEL)</td>
            <!-- rowspan -->
            <!-- rowspan -->
            <td>
                <ul>
                </ul>
            </td>
        </tr>
        <tr>
            <td>AIX 7.1 (or lower)</td>
            <!-- rowspan -->
            <td>
                <ul>
                    <li>General tendency to reduce AIX and System-p (Power CPU footprint), as not being common on the market</li>
                </ul>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>AIX 7.1 (or lower)</td>
            <td>AIX 7.2<br /><img alt="AIX 7.2" src="../../images/aix_72.png" /></td>
            <td>
                <ul>
                    <li>via in-place upgrades</li>
                    <li>AIX only available in "classical" DCO/DCS</li>
                    <li>Mostly affects SAP footprint</li>
                </ul>
            </td>
            <td>&nbsp;</td>
        </tr>
    </tbody>
</table>

## Database

<table>
    <thead>
        <tr>
            <th>Source</th>
            <th>Target</th>
            <th>Comments</th>
            <th>Fallback Targets</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Microsoft SQL Server 2008/2008R2/2012/2014/2016</td>
            <td>Microsoft SQL Server 2019<br /><img alt="Microsoft SQL Server 2019" src="../../images/mssqlserver_2019.jpg" /></td>
            <td>
                <ul>
                    <li>Ensures no required major release upgrades on a long-term basis</li>
                    <li>Compatibility Mode for lower versions can be used on SQL Server 2019</li>
                </ul>
            </td>
            <td>Microsoft SQL Server 2017
                <ul>
                    <li>Unwanted target, only applicable if source is lower than Microsoft SQL Server 2017</li>
                    <li>Will need major release upgrade much sooner than Microsoft SQL Server 2019</li>
                </ul>
            </td>
        </tr>        
        <tr>
            <td rowspan="3">Oracle 10/11/12R1/12R2/18c (including RAC)</td>
            <td>PostgreSQL<br /><img alt="PostgreSQL" src="../../images/postgresql.png" /></td>
            <td>
                <ul>
                    <li><b>PREFERRED:</b> target database environment, if supported by application (and vendor)</li>
                    <li>reduced licensing costs</li>
                    <li>requires migration/transformation effort</li>
                    <li>not available for SAP systems</li>
                </ul>
            </td>
            <td rowspan="3">Oracle 19c
                <ul>
                    <li>Unwanted target, only applicable if vendor does not support other database server software</li>
                </ul>
            </td>
        </tr>
        <tr>
            <!-- rowspan -->
            <!-- rowspan -->
            <td>MariaDB<br /><img alt="MariaDB" src="../../images/mariadb.png" /></td>
            <td>
                <ul>
                    <li>possible target database environment, if supported by application vendor</li>
                    <li>results in reduced licensing costs</li>
                    <li>but does require migration/transformation effort</li>
                </ul>
            </td>
        </tr>        
        <tr>
            <!-- rowspan -->
            <!-- rowspan -->
            <td>Microsoft SQL Server 2019<br /><img alt="Microsoft SQL Server 2019" src="../../images/mssqlserver_2019.jpg" /></td>
            <td>
                <ul>
                    <li>possible target database environment, if supported by application vendor</li>
                    <li>results in reduced licensing costs compared to Oracle</li>
                    <li>but does require migration/transformation effort</li>                
                </ul>
            </td>
        </tr>        
    </tbody>
</table>

## Web Environment

| Source | Target | Comments | Fallback Targets |
| --- | --- | --- | --- |
| dedicated Apache HTTPD (acting solely as reverse proxy to an application server) | [Web-Tier](web-tier.md) | See documentation on Intranet Web-Tier<ul><li>not compatible with NTLM-based authentication | dedicated Apache HTTPD<ul><li>Unwanted target, only applicable if software does not support shared webtier</li></ul> |
| Apache Tomcat | standardized Tomcat packages, running on RedHat 8 | <ul><li>Ensures standardized setup which will be easier to maintain/manage</li></ul> | dedicated Apache Tomcat<ul><li>Unwanted target, only applicable if software does not allow for different package</li></ul> |

## SSL

| Target | Comments | 
| --- | --- |
| SSL handled by IBM | <ul><li>all SSL related topics (from Middleware and below) are in responsibility of IBM</li></ul> |

## Java

| Source | Target | Comments | Fallback Targets |
| --- | --- | --- | --- |
| Oracle Java (any version) | OpenJDK 11 | <ul><li>results in reduced licensing costs</li></ul> | Oracle Java<ul><li>Unwanted target, only applicable if software requires Oracle Java</li></ul> |
| OpenJDK 8 (or lower) | OpenJDK 11 | <ul><li>Ensures no required major release upgrades on a long-term basis</li></ul> | OpenJDK 8<ul><li>Unwanted target, only applicable if source is lower than OpenJDK 8</li></ul> |