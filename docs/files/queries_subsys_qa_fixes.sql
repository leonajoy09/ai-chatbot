-- ---------------------------------------------------------
-- 
-- queries_subsys_qa_fixes
--
-- ---------------------------------------------------------

use ClientOracleJava

-- replace all '-' and '' with NULL values
update serversSubsysIBM set [Version]=NULL where [Version]='-' or [Version]=''
