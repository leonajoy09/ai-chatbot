-- ---------------------------------------------------------
-- 
-- queries_baseline_qa
--
-- ---------------------------------------------------------
use ClientOracleJava

-- 
-- 
-- 
-- 
-- 
-- 
-- the next queries will provide an overview
-- 
-- 
-- 
-- 
-- 
--


-- count the entries
select count(*), editiontimestamp from serversBaselineIBM group by editiontimestamp order by editiontimestamp desc;

-- delete from serversBaselineIBM where editionTimestamp = '2022-11-20 00:00:00.000'


-- list OSversion of last three editions
SELECT distinct baselineEdition, OSVersion
  FROM serversBaselineIBM
  where baselineEdition in (select distinct TOP(3) baselineEdition from serversBaselineIBM order by baselineEdition desc)
order by OSVersion asc, baselineedition desc

-- list OSversions
select baselineEdition, OSName,OSVersion,count(*) from serversBaselineIBM 
where baselineEdition in (select distinct TOP(4) baselineEdition from serversBaselineIBM order by baselineEdition desc)
--and OSName like 'Win%'
group by baselineEdition, OSName,OSVersion
order by baselineEdition desc, OSName,OSVersion 

-- Compare OS Vendor and OS Name because once there was a SuSE paired with Red Hat Enterprise Linux

select baselineEdition, OSVendor, OSName, count(*) from serversBaselineIBM 
where baselineEdition in (select distinct TOP(4) baselineEdition from serversBaselineIBM order by baselineEdition desc)
--and OSName like 'Win%'
group by baselineEdition, OSVendor, OSName
order by OSVendor, OSName, baselineEdition desc

select baselineEdition, OsVendor, count(*) from serversBaselineIBM
group by baselineEdition, OSVendor
order by OSVendor asc, baselineEdition desc

select baselineEdition, OSVendor, OSName, count(*) from serversBaselineIBM 
where baselineEdition in (select distinct TOP(3) baselineEdition from serversBaselineIBM order by baselineEdition desc)
and OSVendor = 'SuSE' 
group by baselineEdition, OSVendor, OSName
order by baselineEdition, OSVendor, OSName asc

-- list OSName of last three editions
SELECT distinct baselineEdition, OSName
  FROM serversBaselineIBM
  where baselineEdition in (select distinct TOP(3) baselineEdition from serversBaselineIBM order by baselineEdition desc)
order by OSName asc, baselineedition asc

-- list vCPU with '-' of last three editions
SELECT baselineEdition, hostname, osname, vCPU
  FROM serversBaselineIBM
  where vCPU = '-'
  and not OSName in ('DATA ONTAP', 'HMC', 'AIX', 'AIX VIO', 'Netscaler')
  and Status not in ('Transition-In', 'Transition-Out')
order by baselineEdition desc, hostname asc

-- 
-- 
-- 
-- 
-- 
-- 
-- the queries below should not provide any result
-- 
-- 
-- 
-- 
-- 
--

-- list wrongly formatted SUSE versions
SELECT distinct OSName, OSVersion, baselineEdition
  FROM serversBaselineIBM
  where OSName like '%SuSE%'
  and OSVersion not in ('10-SP4', '11-SP4', '12-SP1', '12-SP2', '12-SP3', '12-SP4', '12-SP5', '15-GA', '15-SP1', '15-SP2', '15-SP3', '15-SP4')


-- in general count OS Versions with comma separators
SELECT count(*) as '#', baselineEdition, OSName, OSVersion
  FROM serversBaselineIBM
  where OSVersion like '%,%'
group by baselineEdition, OSName, OSVersion
order by OSVersion asc , baselineEdition asc

-- list OSversion with decimal separator instead of dot
SELECT distinct baselineEdition, OSVersion
  FROM serversBaselineIBM
  where OSVersion like '%,%'
order by OSVersion asc , baselineEdition asc

-- list vCPU and memory of VMs that appear conspicuous in previous check
SELECT baselineEdition, Status, SLAType, hostname, osname, HWType, vCPU, MemoryMB
  FROM serversBaselineIBM
  where baselineEdition in (select distinct TOP(10) baselineEdition from serversBaselineIBM order by baselineEdition desc)
  and hostname in (
    -- entries from most recent baseline without vCPU or Memory
	SELECT hostname
	  FROM serversBaselineIBM
	  where baselineEdition in (select distinct TOP(1) baselineEdition from serversBaselineIBM order by baselineEdition desc)
	  and (vCPU = '-' or
			MemoryMB = '-')
	  and not OSName in ('DATA ONTAP', 'HMC', 'AIX', 'AIX VIO', 'Netscaler')
	  and Status not in ('Transition-In', 'Transition-Out')
	  and SLAType not in ('Infrastructure')
	  and HWType in ('virtual machine')
)
order by hostname asc, baselineEdition asc

-- list VMs without Virtualization Infra Pool
SELECT baselineEdition, hostname, VirtualizationInfraPool
  FROM serversBaselineIBM
  where baselineEdition in (select distinct TOP(1) baselineEdition from serversBaselineIBM order by baselineEdition desc)
  and HWType = 'virtual machine'
  and VirtualizationInfraPool = '-'

-- list vCPU with floats
SELECT distinct baselineEdition, vCPU
  FROM serversBaselineIBM
  where vCPU like '%,%'
order by vCPU asc --, baselineEdition desc, hostname asc

-- list vCPU with #NV
SELECT distinct baselineEdition, hostname, vCPU
  FROM serversBaselineIBM
  where VCPU = '#NV'
order by vCPU asc --, baselineEdition desc, hostname asc

---- list vCPU with NULL values
--SELECT distinct baselineEdition, hostname, vCPU
--  FROM serversBaselineIBM
--  where baselineEdition in (select distinct TOP(5) baselineEdition from serversBaselineIBM order by baselineEdition desc)
--  and VCPU is null
--order by vCPU asc --, baselineEdition desc, hostname asc

-- list CPUSPeed non-numeric
SELECT distinct baselineEdition, hostname,CPUSpeed
  FROM serversBaselineIBM
  where CPUSpeed like '%GHz'
order by baselineEdition desc, CPUSpeed asc --, baselineEdition desc, hostname asc

---- list CPUSPeed non-numeric
--SELECT distinct baselineEdition, hostname,CPUSpeed
--  FROM serversBaselineIBM
--  where CPUSpeed not like '%,%'
--order by baselineEdition desc, CPUSpeed asc --, baselineEdition desc, hostname asc

--select * from serversBaselineIBM where hostname = 'USHENSV720'

-- list CoreCount with floats
SELECT distinct baselineEdition, CoreCount
  FROM serversBaselineIBM
  where CoreCount like '%,%'
order by CoreCount asc --, baselineEdition desc, hostname asc

-- list VCUEntitled with floats
SELECT distinct baselineEdition, VCUEntitled
  FROM serversBaselineIBM
  where VCUEntitled like '%,%'
order by VCUEntitled asc --, baselineEdition desc, hostname asc

-- list VCUUpperlimit with floats
SELECT distinct baselineEdition, VCUUpperlimit
  FROM serversBaselineIBM
  where VCUUpperlimit like '%,%'
order by VCUUpperlimit asc --, baselineEdition desc, hostname asc


-- IPs as numbers, only formatted with dots or empty without '-'
SELECT distinct baselineEdition, hostname, PrimaryIPAddressIPv4
  FROM serversBaselineIBM
  where PrimaryIPAddressIPv4 not like '%.%'
  and PrimaryIPAddressIPv4 != '-'
order by baselineEdition desc, hostname asc

-- Check MemoryMB with commas as decimal separator
SELECT hostname, MemoryMB
FROM serversBaselineIBM 
where memoryMB LIKE '%,%'

-- Check date formats
SELECT distinct baselineEdition, hostname, ProdTransInStartDate
  FROM serversBaselineIBM
  where ProdTransInStartDate not like '%-%-%'
  and ProdTransInStartDate != '-'
order by baselineEdition desc, hostname asc

-- Check date formats
SELECT distinct baselineEdition, hostname, ProductionStartDate
  FROM serversBaselineIBM
  where ProductionStartDate not like '%-%-%'
  and ProductionStartDate != '-'
order by baselineEdition desc, hostname asc

-- Check date formats
SELECT distinct baselineEdition, hostname, ProductionEndDate
  FROM serversBaselineIBM
  where ProductionEndDate not like '%-%-%'
  and ProductionEndDate != '-'
order by baselineEdition desc, hostname asc

-- Check for invalid BASID format
select editionTimestamp, hostname, BASIDs from serversBaselineIBM 
where 
(
BASIDs not like 'N0_%' and BASIDs not like 'N1_%' and BASIDs not like 'N2_%' 
and
BASIDs not like 'U0_%' and BASIDs not like 'U1_%' and BASIDs not like 'U2_%' 
and
BASIDs not like 'L0_%' and BASIDs not like 'L1_%' and BASIDs not like 'L2_%' 
and
BASIDs not like 'S0_%' and BASIDs not like 'S1_%' and BASIDs not like 'S2_%' and BASIDs not like 'S3_%' 
and
BASIDs not like 'I0_%' and BASIDs not like 'I1_%' and BASIDs not like 'I2_%' and BASIDs not like 'I3_%' 
) and
baselineEdition in (select distinct TOP(1) baselineEdition from serversBaselineIBM order by baselineEdition desc)
order by hostname asc, editionTimestamp asc


