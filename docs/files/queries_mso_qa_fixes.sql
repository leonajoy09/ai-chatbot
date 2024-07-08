-- ---------------------------------------------------------
-- 
-- queries_mso_qa_fixes
--
-- ---------------------------------------------------------

use ClientOracleJava

-- replace all '-' and '' with NULL values
update serversMSOIBM set "hostname"=NULL where "hostname"='-' or "hostname"=''
update serversMSOIBM set "Tower"=NULL where "Tower"='-' or "Tower"=''
update serversMSOIBM set "Platform"=NULL where "Platform"='-' or "Platform"=''
update serversMSOIBM set "UsageFlavour"=NULL where "UsageFlavour"='-' or "UsageFlavour"=''
update serversMSOIBM set "Description"=NULL where "Description"='-' or "Description"=''
update serversMSOIBM set "BASIDs"=NULL where "BASIDs"='-' or "BASIDs"=''
update serversMSOIBM set "DBInstance"=NULL where "DBInstance"='-' or "DBInstance"=''
update serversMSOIBM set "TechnicalContact"=NULL where "TechnicalContact"='-' or "TechnicalContact"=''
update serversMSOIBM set "ApplicationNameEAM"=NULL where "ApplicationNameEAM"='-' or "ApplicationNameEAM"=''
update serversMSOIBM set "UID"=NULL where "UID"='-' or "UID"=''
update serversMSOIBM set "APPID"=NULL where "APPID"='-' or "APPID"=''
update serversMSOIBM set "MSO"=NULL where "MSO"='-' or "MSO"=''



-- BASIDs with NO
update serversMSOIBM set BASIDs = 'N0_PDM' where BASIDs = 'NO_PDM';


