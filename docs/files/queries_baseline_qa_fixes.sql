-- ---------------------------------------------------------
-- 
-- queries_baseline_qa_fixes
--
-- ---------------------------------------------------------
use ClientOracleJava


-- fix OSVendor where SuSE was used instead of RedHat
update serversBaselineIBM set OSVendor = 'RedHat' where OSName = 'Linux Red Hat Enterprise 7' and OSVendor = 'SuSE'

-- fix OS versions with comma separators
update serversBaselineIBM set OSVersion='10.0' where OSVersion='10,0' and OSName = 'Win2016'
update serversBaselineIBM set OSVersion='15.1' where OSVersion='15,1' and OSName = 'IOS'
update serversBaselineIBM set OSVersion='12.2' where OSVersion='12,2' and OSName = 'IOS'
update serversBaselineIBM set OSVersion='11.11' where OSVersion='11,11' and OSName = 'HP-UX'
update serversBaselineIBM set OSVersion='2.2' where OSVersion='2,2' and OSName = 'AIX'
update serversBaselineIBM set OSVersion='2.6' where OSVersion='2,6' and OSName = 'QIP'
update serversBaselineIBM set OSVersion='6.5' where OSVersion='6,5' and OSName = 'VMware ESXi'
update serversBaselineIBM set OSVersion='6.7' where OSVersion='6,7' and OSName = 'VMware ESXi'
update serversBaselineIBM set OSVersion='6.3' where OSVersion='6,3' and OSName = 'Win2012R2'
update serversBaselineIBM set OSVersion='7.1' where OSVersion='7,1' and OSName = 'AIX'
update serversBaselineIBM set OSVersion='7.1' where OSVersion='7,1' and OSName = 'Xenserver'
update serversBaselineIBM set OSVersion='7.3' where OSVersion='7,3' and OSName = 'HMC'
update serversBaselineIBM set OSVersion='8.1' where OSVersion='8,1' and OSName = 'HMC'
update serversBaselineIBM set OSVersion='8.2' where OSVersion='8,2' and OSName = 'DATA ONTAP'
update serversBaselineIBM set OSVersion='8.1' where OSVersion='8,1' and OSName = 'DATA ONTAP'
update serversBaselineIBM set OSVersion='9.6' where OSVersion='9,6' and OSName = 'DATA ONTAP'
update serversBaselineIBM set OSVersion='6.1' where OSVersion='6,1' and OSName = 'Linux Red Hat Enterprise 6'
update serversBaselineIBM set OSVersion='8.3' where OSVersion='8,3' and OSName = 'Linux Red Hat Enterprise 8'

-- fix inconsistent OSNames
update serversBaselineIBM set OSName='Linux Red Hat Enterprise 8' where OSName = 'RED HAT ENTERPRISE LINUX' and OSVersion = '8.4'


-- fix inconsistent RHEL OS Versions

update serversBaselineIBM set OSVersion='5.11' where OSVersion='RHEL 5.11' and OSName = 'Linux Red Hat Enterprise 5'
update serversBaselineIBM set OSVersion='6.8' where OSVersion='RHEL 6.8' and OSName = 'Linux Red Hat Enterprise 6'
update serversBaselineIBM set OSVersion='6.9' where OSVersion='RHEL 6.9' and OSName = 'Linux Red Hat Enterprise 6'
update serversBaselineIBM set OSVersion='6.10' where OSVersion='RHEL 6.10' and OSName = 'Linux Red Hat Enterprise 6'
update serversBaselineIBM set OSVersion='7' where OSVersion='RHEL 7' and OSName = 'Linux Red Hat Enterprise 7'
update serversBaselineIBM set OSVersion='7.7' where OSVersion='RHEL 7.7' and OSName = 'Linux Red Hat Enterprise 7'
update serversBaselineIBM set OSVersion='7.8' where OSVersion='RHEL 7.8' and OSName = 'Linux Red Hat Enterprise 7'
update serversBaselineIBM set OSVersion='8.2' where OSVersion='RHEL 8.2' and OSName = 'Linux Red Hat Enterprise 8'



-- fix inconsistent SUSE OS Versions
update serversBaselineIBM set OSVersion='10-SP4' where OSVersion='SLES 10.4' and OSName = 'Linux SuSE Enterprise Server 10'
update serversBaselineIBM set OSVersion='10-SP4' where OSVersion='2.6.16.60-0.132.1-smp' and OSName = 'Linux SuSE Enterprise Server 10'
update serversBaselineIBM set OSVersion='11-SP4' where OSVersion='11.4' and OSName = 'Linux SuSE Enterprise 11'
update serversBaselineIBM set OSVersion='11-SP4' where OSVersion='11.4' and OSName = 'Linux SuSE Enterprise Server 11'
update serversBaselineIBM set OSVersion='11-SP4' where OSVersion='11.4 SP4' and OSName = 'Linux SuSE Enterprise Server 11'
update serversBaselineIBM set OSVersion='11-SP4' where OSVersion='SLES 11.4' and OSName = 'Linux SuSE Enterprise Server 11'
update serversBaselineIBM set OSName='Linux SuSE Enterprise Server 12', OSVersion='12-SP3' where OSVersion='SLES 12-SP3' and OSName = 'Linux SuSE Enterprise Server 11'
update serversBaselineIBM set OSVersion='12-SP1' where OSVersion='SLES 12-SP1' and OSName = 'Linux SuSE Enterprise Server 12'
update serversBaselineIBM set OSVersion='12-SP2' where OSVersion='SLES 12-SP2' and OSName = 'Linux SuSE Enterprise Server 12'
update serversBaselineIBM set OSVersion='12-SP3' where OSVersion='SLES 12-SP3' and OSName = 'Linux SuSE Enterprise Server 12'
update serversBaselineIBM set OSVersion='12-SP4' where OSVersion='SLES 12-SP4' and OSName = 'Linux SuSE Enterprise Server 12'
update serversBaselineIBM set OSVersion='12-SP5' where OSVersion='SLES 12-SP5' and OSName = 'Linux SuSE Enterprise Server 12'
update serversBaselineIBM set OSVersion='12-SP3' where OSVersion='4.4.120-92.70-default' and OSName = 'Linux SuSE Enterprise Server 12'
update serversBaselineIBM set OSVersion='15-GA' where OSVersion='SLES 15' and OSName = 'Linux SuSE Enterprise Server 15'
update serversBaselineIBM set OSVersion='15-SP1' where OSVersion='SLES 15-SP1' and OSName = 'Linux SuSE Enterprise Server 15'



-- replace all '-' and '' with NULL values
update serversBaselineIBM set "Status"=NULL where "Status"='-' or "Status"=''
update serversBaselineIBM set Platform=NULL where Platform='-' or Platform=''
update serversBaselineIBM set Usage=NULL where Usage='-' or Usage=''
update serversBaselineIBM set Description=NULL where Description='-' or Description=''
update serversBaselineIBM set Tower=NULL where Tower='-' or Tower=''
update serversBaselineIBM set BASIDs=NULL where BASIDs='-' or BASIDs=''
update serversBaselineIBM set SLAType=NULL where SLAType='-' or SLAType=''
update serversBaselineIBM set SLALevel=NULL where SLALevel='-' or SLALevel=''
update serversBaselineIBM set SLAKPINumber=NULL where SLAKPINumber='-' or SLAKPINumber=''
update serversBaselineIBM set CADRE=NULL where CADRE='-' or CADRE=''
update serversBaselineIBM set ClusterType=NULL where ClusterType='-' or ClusterType=''
update serversBaselineIBM set ClusterPartner=NULL where ClusterPartner='-' or ClusterPartner=''
update serversBaselineIBM set Flag4B=NULL where Flag4B='-' or Flag4B=''
update serversBaselineIBM set ProdTransInStartDate=NULL where ProdTransInStartDate='-' or ProdTransInStartDate=''
update serversBaselineIBM set ProductionStartDate=NULL where ProductionStartDate='-' or ProductionStartDate=''
update serversBaselineIBM set ProductionEndDate=NULL where ProductionEndDate='-' or ProductionEndDate=''
update serversBaselineIBM set Project=NULL where Project='-' or Project=''
update serversBaselineIBM set CC=NULL where CC='-' or CC=''
update serversBaselineIBM set Location=NULL where Location='-' or Location=''
update serversBaselineIBM set HenkelLocationID=NULL where HenkelLocationID='-' or HenkelLocationID=''
update serversBaselineIBM set VirtualizationInfraPool=NULL where VirtualizationInfraPool='-' or VirtualizationInfraPool=''
update serversBaselineIBM set NetworkZone=NULL where NetworkZone='-' or NetworkZone=''
update serversBaselineIBM set LBusage=NULL where LBusage='-' or LBusage=''
update serversBaselineIBM set AVScan=NULL where AVScan='-' or AVScan=''
update serversBaselineIBM set PrimaryIPAddressIPv4=NULL where PrimaryIPAddressIPv4='-' or PrimaryIPAddressIPv4=''
update serversBaselineIBM set PrimaryIPAddressIPv6=NULL where PrimaryIPAddressIPv6='-' or PrimaryIPAddressIPv6=''
update serversBaselineIBM set AliasHostname=NULL where AliasHostname='-' or AliasHostname=''
update serversBaselineIBM set OSVendor=NULL where OSVendor='-' or OSVendor=''
update serversBaselineIBM set OSName=NULL where OSName='-' or OSName=''
update serversBaselineIBM set OSVersion=NULL where OSVersion='-' or OSVersion=''
update serversBaselineIBM set HWVendor=NULL where HWVendor='-' or HWVendor=''
update serversBaselineIBM set HWType=NULL where HWType='-' or HWType=''
update serversBaselineIBM set SerialNo=NULL where SerialNo='-' or SerialNo=''
update serversBaselineIBM set CPUModel=NULL where CPUModel='-' or CPUModel=''
update serversBaselineIBM set CPUSpeed=NULL where CPUSpeed='-' or CPUSpeed=''
update serversBaselineIBM set NoOfSockets=NULL where NoOfSockets='-' or NoOfSockets=''
update serversBaselineIBM set CoreCount=NULL where CoreCount='-' or CoreCount=''
update serversBaselineIBM set VCPU=NULL where VCPU='-' or VCPU='' or vCPU='#NV'
update serversBaselineIBM set VCUEntitled=NULL where VCUEntitled='-' or VCUEntitled=''
update serversBaselineIBM set VCUUpperlimit=NULL where VCUUpperlimit='-' or VCUUpperlimit=''
update serversBaselineIBM set MemoryMB=NULL where MemoryMB='-' or MemoryMB=''

-- fix vCPU floats with comma
UPDATE serversBaselineIBM set vCPU=REPLACE(vCPU,',','.') WHERE vCPU LIKE '%,%'

-- remove CPUSpeed GHz string
UPDATE serversBaselineIBM set CPUSpeed=REPLACE(CPUSpeed,' GHz','') WHERE CPUSpeed LIKE '% GHz'
UPDATE serversBaselineIBM set CPUSpeed=REPLACE(CPUSpeed,'GHz','') WHERE CPUSpeed LIKE '%GHz'

-- fix MemoryMB decimalsepararators
UPDATE serversBaselineIBM SET MemoryMB=REPLACE(MemoryMB, ',','.') where memoryMB LIKE '%,%'

-- fix CoreCount floats with comma
UPDATE serversBaselineIBM set CoreCount=REPLACE(CoreCount,',','.') WHERE CoreCount LIKE '%,%'

-- fix VCUEntitled floats with comma
UPDATE serversBaselineIBM set VCUEntitled=REPLACE(VCUEntitled,',','.') WHERE VCUEntitled LIKE '%,%'

-- fix VCUUpperlimit floats with comma
UPDATE serversBaselineIBM set VCUUpperlimit=REPLACE(VCUUpperlimit,',','.') WHERE VCUUpperlimit LIKE '%,%'

-- fix wrong date formats
UPDATE serversBaselineIBM set ProductionStartDate='2015-05-22' WHERE ProductionStartDate='22.05.15'
UPDATE serversBaselineIBM set ProductionStartDate=NULL WHERE ProductionStartDate='fixme'
UPDATE serversBaselineIBM set ProductionStartDate='2018-05-31' WHERE ProductionStartDate='43251'
UPDATE serversBaselineIBM set ProductionEndDate='2018-05-25' WHERE ProductionEndDate='44433'

-- fix IPs without dots
UPDATE serversBaselineIBM set PrimaryIPAddressIPv4=REPLACE(PrimaryIPAddressIPv4,'10175238','10.175.238.') WHERE PrimaryIPAddressIPv4 LIKE '10175238%'
UPDATE serversBaselineIBM set PrimaryIPAddressIPv4=REPLACE(PrimaryIPAddressIPv4,'10175239','10.175.239.') WHERE PrimaryIPAddressIPv4 LIKE '10175239%'
UPDATE serversBaselineIBM set PrimaryIPAddressIPv4=REPLACE(PrimaryIPAddressIPv4,'10175252','10.175.252.') WHERE PrimaryIPAddressIPv4 LIKE '10175252%'
UPDATE serversBaselineIBM set PrimaryIPAddressIPv4=REPLACE(PrimaryIPAddressIPv4,'10175255','10.175.255.') WHERE PrimaryIPAddressIPv4 LIKE '10175255%'

