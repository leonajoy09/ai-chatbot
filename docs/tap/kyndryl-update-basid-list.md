# Update BASID list in MSSQL database

Open the [Baseline Check](https://ibmstats.henkelgroup.net/d/XGO00VCnk/baseline-invalid-values?orgId=1) and [Invoice Check](https://ibmstats.henkelgroup.net/d/Uyh2slmVz/invalid-values?orgId=1)

If invalid values exist with `Column="BASID2"` and `Error="not in list"`, the BASIDs need to be updated in the corresponding database:

* Use Microsoft SQL Server Management Tool and connect to `dedussvfpsql01\SHARED`.
* Database is `ClientOracleJava` (don't ask, it's a legacy name...)
* Right click on database --&gt; New Query
* Open Kyndryl-managed BASID List in [Quality Library](https://henkelgroup.sharepoint.com/:x:/r/teams/QualityLibraryDC/_layouts/15/Doc.aspx?sourcedoc=%7B77577955-03E2-4010-B335-1ACFE1A1DAB4%7D&file=BASID%20Details%20in%20Baseline.xlsx&action=default&mobileredirect=true).
Column E should contain the date when the (new) BASID was added.

In the new Query-Window, enter for each missing resp. new BASID:
```
INSERT INTO BASIDs VALUES (<COLUMN A>, <COLUMN B, if empty then COLUMN A>, <COLUMN C>, <COLUMN D, if empty then null>);
```

String-values are enclosed by single-quotes (`'`), the null value must not have single-quotes.
Then press F5 or click the _Play button_ to execute the SQL commands, which will insert the data.

Errors might arise if duplicate values are entered, which is not allowed in this database-table.

``` sql title="Examples"
INSERT INTO BASIDs VALUES ('I0_TERMINAL', 'I0_TERMINAL', 'Internal Terminal Server', null);
INSERT INTO BASIDs VALUES ('N0_VEGAMLB', 'N0_VEGAMLB', 'Vegam Labeling Global', 'APP-38545');
INSERT INTO BASIDs VALUES ('I0_KYNLIC', 'I0_KYNLIC', 'License and tool server', null);
INSERT INTO BASIDs VALUES ('S0_P04', 'S0_P04', 'P04: SAP HANA DB Server', null);
INSERT INTO BASIDs VALUES ('N2_HCMCOLD', 'N2_HCMCOLD', 'HCM Extranet Website v. 1.0', 'APP-35680');
INSERT INTO BASIDs VALUES ('N2_PACKTEST', 'N2_PACKTEST', 'Package Testing v. 1.0', 'APP-36142');
INSERT INTO BASIDs VALUES ('N2_EDINA', 'N2_EDINA', 'NA B&L Clob Grepper / Raw EDI Data Explorer 1.0', 'APP-36072');
```

Now go back to both Check URLs above and reload the pages.

The list of invalid values should have reduced now. If there are still unknown/invalid BASIDs present, make a note of this and issue a complaint:

* for Baseline: with the current Kyndryl configuration manager (Karthikeyan Arthanarie <karthikeyan.arthanarie@kyndryl.com>)
* for Invoice Issues: with Henkel's finance team (Winfried Raschke, Sandra Amini)