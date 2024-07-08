# Database migration to Cloud

!!! info
    This is a migration guide for Oracle database workloads to Azure. It will be updated continuously.

## Cost

Licensing cost is a main reason. For example Postgres is open-source and licencing fee for commercial use is free. The only costs incurred are cloud usages which can be as little as ~ 50 Euro a month. Whereas Oracle can cost tens of thousands per year!

## Availability Azure Managed Service

Azure's Managed Databases provides infrastructure management like scaling, backups and availablity. This will ease the administration portion of your application and let you worry more about the business logic and less of the operational overhead.

## Alternative options

* MySQL/MariaDB
* Postgres
* MSSQL
* distributed noSQL databases (needs lots of transformation to schemaless model)

## Dependencies

1. Data Types
   >Are there considerations for conversion of one data type to the other?
2. DB Drivers
   >You may need to consider how this might differ with regards to your current Oracle connection. Thick, Thin, ODBC, JDBC, OCI, etc
3. Oracle Application
   >will it support a non Oracle RDBMS?

## Why do we like e.g. Postgres?

It has very similar architecture, similar databases, lots of features and allows an easy path to migration.

## Mapping out a plan for migration to Postgres

Here is a [step by step procedure](https://docs.microsoft.com/en-us/azure/dms/tutorial-oracle-azure-postgresql-online) from Oracle to Postgres:

- As Always its a good idea to do a dry-run and see if you can do a migraton.
- Data Integrity, compatibility, UI Interface works properly, reporting, etc.  
- all of these factors must be taken into account.
- it helps to run through this process to see if Migration is possible for your application and or workload.

## What if I can not migrate from Oracle or I just want to keep Oracle?
You can keep your Oracle setup by provisioning a compute instance with appropriate sizing and installing oracle software, re-creating the database and importing the data

SQLNET will need to configured and opened in the appropriate Security group to allow traffic.

* Oracle RAC will not be covered.

## Misc Reading

- [Sample Costs of Oracle](https://dzone.com/articles/postgresql-vs-oracle-difference-in-costs-ease-of-u)
- [Azure Managed DB Costs](https://azure.microsoft.com/en-us/pricing/details/postgresql/server/)
- [Azure DB](https://azure.microsoft.com/en-us/product-categories/databases/)

- [SQL Server Migration Assistant (SSMA)](https://datamigration.microsoft.com/scenario/oracle-to-azuresqldb?step=1)
