-- ---------------------------------------------------------
-- 
-- queries_mso_qa
--
-- ---------------------------------------------------------

use ClientOracleJava

select msoEdition,count(*) from serversMSOIBM group by msoEdition order by msoEdition desc; -- where subsysEdition = '202104';

-- delete from serversMSOIBM where msoEdition = '20221215';

-- 
-- 
-- the queries below should not provide any result
-- 
-- 

select * from serversMSOIBM where BASIDs = 'NO_PDM';
