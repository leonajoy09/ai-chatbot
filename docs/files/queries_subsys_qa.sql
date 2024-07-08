-- ---------------------------------------------------------
-- 
-- queries_subsys_qa
--
-- ---------------------------------------------------------

use ClientOracleJava

select subsysEdition,count(*) from serversSubsysIBM group by subsysEdition order by subsysEdition desc; -- where subsysEdition = '202104';

-- delete from serversSubsysIBM where subsysEdition = '20221215';

-- 
-- 
-- the queries below should not provide any result
-- 
-- 

