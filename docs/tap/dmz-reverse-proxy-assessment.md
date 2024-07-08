# DMZ Reverse Proxy assessment

assessment of reverse proxied applications related or placed in DCO/DCS DMZ


<table>
<tbody>
<tr>
<th>Application</th>
<th>Redmine Issue</th>
<th>Config</th>
<th>URL</th>
<th>CMO Upstream Server</th>
<th>IBM or DUS DMZ?</th>
<th>CPU</th>
<th>MEM</th>
<th>Server Count</th>
<th>Design Pattern</th>
<th>Contact</th>
<th>Comments</th>
</tr>
<tr><td>ABI2</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5409"  >5409</a></td>
<td><a  href="http://abi2.henkel.com"  >abi2.henkel.com</a>.conf</td>
<td><a  href="http://abi2.henkel.com"  >abi2.henkel.com</a></td>
<td><a  href="https://dehensvdus21.de.henkelgroup.net/ABI2"  >https://dehensvdus21.de.henkelgroup.net/ABI2</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>check / identify</td>
</tr>
<tr><td>ABI2</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5409"  >5409</a></td>
<td><a  href="http://abi2.henkelgroup.net"  >abi2.henkelgroup.net</a>.conf</td>
<td><a  href="http://abi2.henkelgroup.net"  >abi2.henkelgroup.net</a></td>
<td><a  href="https://dehensve12.de.henkelgroup.net/ABI2"  >https://dehensve12.de.henkelgroup.net/ABI2</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ (Win2019+IIS) &quot;Sandwich&quot;</td>
<td><br/></td>
<td>check NTLM</td>
</tr>
<tr><td>ABI2</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5409"  >5409</a></td>
<td><a  href="http://abi2-dev.henkelgroup.net"  >abi2-dev.henkelgroup.net</a>.conf</td>
<td><a  href="http://abi2-dev.henkelgroup.net"  >abi2-dev.henkelgroup.net</a></td>
<td><a  href="https://dehensvdus21.de.henkelgroup.net/ABI2"  >https://dehensvdus21.de.henkelgroup.net/ABI2</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>ActiveGate</td>
<td><br/></td>
<td><a  href="http://activegate-poc.henkelgroup.net"  >activegate-poc.henkelgroup.net</a>.conf</td>
<td><a  href="http://activegate-poc.henkelgroup.net"  >activegate-poc.henkelgroup.net</a></td>
<td><a  href="https://dedussv-aiops08.henkelgroup.net:9999/"  >https://dedussv-aiops08.henkelgroup.net:9999/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>ASK AT</td>
<td><br/></td>
<td><a  href="http://ask-seminare.at"  >ask-seminare.at</a>.conf</td>
<td><a  href="http://ask-seminare.at"  >ask-seminare.at</a></td>
<td><br/></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>ASK AT</td>
<td><br/></td>
<td><a  href="http://ask-seminare.henkel.com"  >ask-seminare.henkel.com</a>.conf</td>
<td><a  href="http://ask-seminare.henkel.com"  >ask-seminare.henkel.com</a></td>
<td><a  href="https://atviesvvap08.henkelgroup.net/"  >https://atviesvvap08.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Confluence</td>
<td><br/></td>
<td><a  href="http://confluence.henkelgroup.net"  >confluence.henkelgroup.net</a>.conf</td>
<td><a  href="http://confluence.henkelgroup.net"  >confluence.henkelgroup.net</a></td>
<td><a href="https://confluence.henkelgroup.net/"  >https://confluence.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Confluence TST</td>
<td><br/></td>
<td><a  href="http://confluence-staging.henkelgroup.net"  >confluence-staging.henkelgroup.net</a>.conf</td>
<td><a  href="http://confluence-staging.henkelgroup.net"  >confluence-staging.henkelgroup.net</a></td>
<td><a  href="https://confluence-staging.henkelgroup.net/"  >https://confluence-staging.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Detergents Regulation Info</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5412"  >5412</a></td>
<td><a  href="http://henkelconsumerinfo.com"  >henkelconsumerinfo.com</a>.conf</td>
<td><a  href="http://henkelconsumerinfo.com"  >henkelconsumerinfo.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1 or 2</td>
<td>Inner-DMZ (RHEL8+Tomcat)</td>
<td>Javier Perez</td>
<td>HA needed or not ?</td>
</tr>
<tr><td>DEWeb</td>
<td><br/></td>
<td><a  href="http://deweb02.henkel.com"  >deweb02.henkel.com</a>.conf</td>
<td><a  href="http://deweb02.henkel.com"  >deweb02.henkel.com</a></td>
<td><a  href="https://dehensv438.henkelgroup.net"  >https://dehensv438.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Domino</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Domino</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5413"  >5413</a></td>
<td><a  href="http://attachments.henkel.com"  >attachments.henkel.com</a>.conf</td>
<td><a  href="http://attachments.henkel.com"  >attachments.henkel.com</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Domino</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Domino</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5413"  >5413</a></td>
<td><a  href="http://tdsna.henkel.com"  >tdsna.henkel.com</a>.conf</td>
<td><a  href="http://tdsna.henkel.com"  >tdsna.henkel.com</a></td>
<td><a  href="https://dehensv438.henkelgroup.net"  >https://dehensv438.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Domino</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Domino</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5413"  >5413</a></td>
<td><a  href="http://web-emea.henkel.com"  >web-emea.henkel.com</a>.conf</td>
<td><a  href="http://web-emea.henkel.com"  >web-emea.henkel.com</a></td>
<td><a  href="https://dehensv438.henkelgroup.net"  >https://dehensv438.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Domino</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Dynacluster</td>
<td><br/></td>
<td><a  href="http://dynacluster-poc.henkelgroup.net"  >dynacluster-poc.henkelgroup.net</a>.conf</td>
<td><a  href="http://dynacluster-poc.henkelgroup.net"  >dynacluster-poc.henkelgroup.net</a></td>
<td><a  href="https://dedussv-aiops05.henkelgroup.net"  >https://dedussv-aiops05.henkelgroup.net</a><br/><a  href="https://dedussv-aiops06.henkelgroup.net"  >https://dedussv-aiops06.henkelgroup.net</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>eShop Adhesive</td>
<td><br/></td>
<td><a  href="http://cn-eshop.henkel-adhesives.com"  >cn-eshop.henkel-adhesives.com</a>.conf</td>
<td><a  href="http://cn-eshop.henkel-adhesives.com"  >cn-eshop.henkel-adhesives.com</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>eShop Adhesive</td>
<td><br/></td>
<td><a  href="http://eshop-henkel-adhesives.cn"  >eshop-henkel-adhesives.cn</a>.conf</td>
<td><a  href="http://eshop-henkel-adhesives.cn"  >eshop-henkel-adhesives.cn</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>eShop Adhesive TST</td>
<td><br/></td>
<td><a  href="http://n15-uat.henkel-adhesives.com"  >n15-uat.henkel-adhesives.com</a>.conf</td>
<td><a  href="http://n15-uat.henkel-adhesives.com"  >n15-uat.henkel-adhesives.com</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>Extranet</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5421"  >5421</a></td>
<td><a  href="http://extranet.henkel.com"  >extranet.henkel.com</a>.conf</td>
<td><a  href="http://extranet.henkel.com"  >extranet.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>VISIT, MCD active, PromoRoyal, </td>
</tr>
<tr><td>FLOW</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5414"  >5414</a></td>
<td><a  href="http://flow.henkel.com"  >flow.henkel.com</a>.conf</td>
<td><a  href="http://flow.henkel.com"  >flow.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>2</td>
<td>Inner-DMZ (RHEL8+CustomAS) &quot;Sandwich&quot;</td>
<td>active/passive ClusterIP</td>
<td><br/></td>
</tr>
<tr><td>Fragrance DB</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5415"  >5415</a></td>
<td><a  href="http://fragws.henkelgroup.net"  >fragws.henkelgroup.net</a>.conf</td>
<td><a  href="http://fragws.henkelgroup.net"  >fragws.henkelgroup.net</a></td>
<td><a  href="https://dehensv685.de.henkelgroup.net/fragws"  >https://dehensv685.de.henkelgroup.net/fragws</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1</td>
<td>Inner-DMZ (Win2019+IIS)</td>
<td><br/></td>
<td>Split DNS + internal NTLM</td>
</tr>
<tr><td>GIB</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5416"  >5416</a></td>
<td><a  href="http://gib.henkel.com"  >gib.henkel.com</a>.conf</td>
<td><a  href="http://gib.henkel.com"  >gib.henkel.com</a></td>
<td><a  href="https://dehensvm019.henkelgroup.net"  >https://dehensvm019.henkelgroup.net</a><br/><a  href="https://dehensvm020.henkelgroup.net"  >https://dehensvm020.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ (RHEL8) &quot;Sandwich&quot;</td>
<td>Dorothee Hoberg</td>
<td>FQDN Change to split DNS</td>
</tr>
<tr><td>GIB CON</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5417"  >5417</a></td>
<td><a  href="http://gibcon.henkel.com"  >gibcon.henkel.com</a>.conf</td>
<td><a  href="http://gibcon.henkel.com"  >gibcon.henkel.com</a></td>
<td><a  href="https://dehensvm021.henkelgroup.net"  >https://dehensvm021.henkelgroup.net</a><br/><a  href="https://dehensvm022.henkelgroup.net"  >https://dehensvm022.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ (RHEL8) &quot;Sandwich&quot;</td>
<td>Dorothee Hoberg</td>
<td>FQDN Change to split DNS</td>
</tr>
<tr><td>GODrive</td>
<td><br/></td>
<td><a  href="http://godrive.henkelgroup.net"  >godrive.henkelgroup.net</a>.conf</td>
<td><a  href="http://godrive.henkelgroup.net"  >godrive.henkelgroup.net</a></td>
<td><a  href="https://simbxsvvwapp30.henkelgroup.net/"  >https://simbxsvvwapp30.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Henkel IT inventory</td>
<td><br/></td>
<td><a  href="http://id-customs-inv.henkelgroup.net"  >id-customs-inv.henkelgroup.net</a>.conf</td>
<td><a  href="http://id-customs-inv.henkelgroup.net"  >id-customs-inv.henkelgroup.net</a></td>
<td><a  href="http://idtrgws20004626.henkelgroup.net:88/"  >http://idtrgws20004626.henkelgroup.net:88/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>HUB</td>
<td><br/></td>
<td><a  href="http://hub.henkelgroup.net"  >hub.henkelgroup.net</a>.conf</td>
<td><a  href="http://hub.henkelgroup.net"  >hub.henkelgroup.net</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>HWCAG</td>
<td><br/></td>
<td><a  href="http://hwcag.henkelgroup.net"  >hwcag.henkelgroup.net</a>.conf</td>
<td><a  href="http://hwcag.henkelgroup.net"  >hwcag.henkelgroup.net</a></td>
<td><a  href="https://g1-sngl-p.henkelgroup.net/"  >https://g1-sngl-p.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td>Michael Leutgeb</td>
<td><br/></td>
</tr>
<tr><td>JDA Printing</td>
<td><br/></td>
<td><a  href="http://jdaprinting.henkelgroup.net"  >jdaprinting.henkelgroup.net</a>.conf</td>
<td><a  href="http://jdaprinting.henkelgroup.net"  >jdaprinting.henkelgroup.net</a></td>
<td><a  href="https://deibmsvn10015.henkelgroup.net"  >https://deibmsvn10015.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1</td>
<td>Inner-DMZ (Win2019+IIS)</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>JDA Printing TST</td>
<td><br/></td>
<td><a  href="http://jdaprinttest.henkelgroup.net"  >jdaprinttest.henkelgroup.net</a>.conf</td>
<td><a  href="http://jdaprinttest.henkelgroup.net"  >jdaprinttest.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer or Inner-DMZ</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Jira</td>
<td><br/></td>
<td><a  href="http://jira.henkelgroup.net"  >jira.henkelgroup.net</a>.conf</td>
<td><a  href="http://jira.henkelgroup.net"  >jira.henkelgroup.net</a></td>
<td><a  href="https://jira.henkelgroup.net/"  >https://jira.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Jira TST</td>
<td><br/></td>
<td><a  href="http://jira-staging.henkelgroup.net"  >jira-staging.henkelgroup.net</a>.conf</td>
<td><a  href="http://jira-staging.henkelgroup.net"  >jira-staging.henkelgroup.net</a></td>
<td><a  href="https://jira-staging.henkelgroup.net/"  >https://jira-staging.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>KEP Online</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5418"  >5418</a></td>
<td><a  href="http://geodata.henkelgroup.net"  >geodata.henkelgroup.net</a>.conf</td>
<td><a  href="http://geodata.henkelgroup.net"  >geodata.henkelgroup.net</a></td>
<td><a  href="http://dehensvm041.henkelgroup.net"  >http://dehensvm041.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Ronald Slickers</td>
<td><br/></td>
</tr>
<tr><td>KEP Online</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5419"  >5419</a></td>
<td><a  href="http://kepservices.henkelgroup.net"  >kepservices.henkelgroup.net</a>.conf</td>
<td><a  href="http://kepservices.henkelgroup.net"  >kepservices.henkelgroup.net</a></td>
<td><a  href="https://dehensvm041.henkelgroup.net:8443/kepservices"  >https://dehensvm041.henkelgroup.net:8443/kepservices</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ (Win2019+IIS)</td>
<td>Ronald Slickers</td>
<td><br/></td>
</tr>
<tr><td>LAMP Server</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5420"  >5420</a></td>
<td><a  href="http://canteen-holthausen.henkel.com"  >canteen-holthausen.henkel.com</a>.conf</td>
<td><a  href="http://canteen-holthausen.henkel.com"  >canteen-holthausen.henkel.com</a></td>
<td><a  href="https://portal-info.de.henkelgroup.net/menu/"  >https://portal-info.de.henkelgroup.net/menu/</a></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>still needed ?</td>
</tr>
<tr><td>LHC</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5422"  >5422</a></td>
<td><a  href="http://lhcmobile.henkelgroup.net"  >lhcmobile.henkelgroup.net</a>.conf</td>
<td><a  href="http://lhcmobile.henkelgroup.net"  >lhcmobile.henkelgroup.net</a></td>
<td><a  href="http://dehensv1063.de.henkelgroup.net:1205/sfadmz"  >http://dehensv1063.de.henkelgroup.net:1205/sfadmz</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ (Win2019+IIS) or Inner-DMZ (RHEL8+Tomcat)</td>
<td>Frank Arbeiter</td>
<td><br/></td>
</tr>
<tr><td>MediaOnline</td>
<td><br/></td>
<td><a  href="http://www.mediaonline.henkel.com"  >www.mediaonline.henkel.com</a>.conf</td>
<td><a  href="http://www.mediaonline.henkel.com"  >www.mediaonline.henkel.com</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>Milano</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5423"  >5423</a></td>
<td><a  href="http://eshop.henkel-adhesives.com"  >eshop.henkel-adhesives.com</a>.conf</td>
<td><a  href="http://eshop.henkel-adhesives.com"  >eshop.henkel-adhesives.com</a></td>
<td><a  href="https://dehensvh91.henkelgroup.net"  >https://dehensvh91.henkelgroup.net</a><br/><a  href="https://dehensvh92.henkelgroup.net"  >https://dehensvh92.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>to be checked</td>
</tr>
<tr><td>Milano TST</td>
<td><br/></td>
<td><a  href="http://eshop-uat.henkel-adhesives.com"  >eshop-uat.henkel-adhesives.com</a>.conf</td>
<td><a  href="http://eshop-uat.henkel-adhesives.com"  >eshop-uat.henkel-adhesives.com</a></td>
<td><a  href="https://dehensvh89.henkelgroup.net"  >https://dehensvh89.henkelgroup.net</a><br/><a  href="https://dehensvh90.henkelgroup.net"  >https://dehensvh90.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Milano TST</td>
<td><br/></td>
<td><a  href="http://eshop-uat.henkel-adhesives.com"  >eshop-uat.henkel-adhesives.com</a>.conf</td>
<td><a  href="http://eshop-uat.henkel-adhesives.com"  >eshop-uat.henkel-adhesives.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>MSDS</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5424"  >5424</a></td>
<td><a  href="http://mymsds.henkel.com"  >mymsds.henkel.com</a>.conf</td>
<td><a  href="http://mymsds.henkel.com"  >mymsds.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>same as <a  href="http://henkelconsumerinfo.com"  >henkelconsumerinfo.com</a></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>MyID</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5425"  >5425</a></td>
<td><a  href="http://myiddatahub.henkelgroup.net"  >myiddatahub.henkelgroup.net</a>.conf</td>
<td><a  href="http://myiddatahub.henkelgroup.net"  >myiddatahub.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>NA Chemmgt </td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5411"  >5411</a></td>
<td><a  href="http://nachemmgt.henkel.com"  >nachemmgt.henkel.com</a>.conf</td>
<td><a  href="http://nachemmgt.henkel.com"  >nachemmgt.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1</td>
<td>Inner-DMZ (RHEL8)</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>NA Dialstore</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5411"  >5411</a></td>
<td><a  href="http://www.thedialstore.com"  >www.thedialstore.com</a>.conf</td>
<td><a  href="http://www.thedialstore.com"  >www.thedialstore.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>same as <a  href="http://nachemmgt.henkel.com"  >nachemmgt.henkel.com</a></td>
<td>Ronald Oggert</td>
<td><br/></td>
</tr>
<tr><td>NA Netcharts</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5410"  >5410</a></td>
<td><a  href="http://nanetcharts.henkel.com"  >nanetcharts.henkel.com</a>.conf</td>
<td><a  href="http://nanetcharts.henkel.com"  >nanetcharts.henkel.com</a></td>
<td><a  href="http://10.175.247.161:6060/"  >http://10.175.247.161:6060/</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>server in Raleigh</td>
</tr>
<tr><td>NA Portal</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5411"  >5411</a></td>
<td><a  href="http://naportal.henkel.com"  >naportal.henkel.com</a>.conf</td>
<td><a  href="http://naportal.henkel.com"  >naportal.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>same as <a  href="http://nachemmgt.henkel.com"  >nachemmgt.henkel.com</a></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>OTM</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5426"  >5426</a></td>
<td><a  href="http://otm.henkelgroup.net"  >otm.henkelgroup.net</a>.conf</td>
<td><a  href="http://otm.henkelgroup.net"  >otm.henkelgroup.net</a></td>
<td><a  href="https://otm1.henkelgroup.net"  >https://otm1.henkelgroup.net</a><br/><a  href="https://otm2.henkelgroup.net"  >https://otm2.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>min. 2</td>
<td>Inner-DMZ (RHEL8) &quot;Sandwich&quot;</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>OTM TST</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5427"  >5427</a></td>
<td><a  href="http://otm-test.henkelgroup.net"  >otm-test.henkelgroup.net</a>.conf</td>
<td><a  href="http://otm-test.henkelgroup.net"  >otm-test.henkelgroup.net</a></td>
<td><a  href="https://otm-test1.henkelgroup.net"  >https://otm-test1.henkelgroup.net</a><br/><a  href="https://otm-test2.henkelgroup.net"  >https://otm-test2.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>min. 2</td>
<td>Inner-DMZ (RHEL8) &quot;Sandwich&quot;</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>PIM</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5429"  >5429</a></td>
<td><a  href="http://pim.henkelgroup.net"  >pim.henkelgroup.net</a>.conf</td>
<td><a  href="http://pim.henkelgroup.net"  >pim.henkelgroup.net</a></td>
<td><a  href="https://dehensvh32.henkelgroup.net"  >https://dehensvh32.henkelgroup.net</a><br/><a  href="https://dehensvh33.henkelgroup.net"  >https://dehensvh33.henkelgroup.net</a><br/><a  href="https://dehensvh34.henkelgroup.net"  >https://dehensvh34.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>?</td>
<td>Inner-DMZ</td>
<td>Thorsten vom Bovert</td>
<td>Docker Application / SAP Hybris</td>
</tr>
<tr><td>PIM</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5429"  >5429</a></td>
<td><a  href="http://pim-sloth.henkelgroup.net"  >pim-sloth.henkelgroup.net</a>.conf</td>
<td><a  href="http://pim-sloth.henkelgroup.net"  >pim-sloth.henkelgroup.net</a></td>
<td><a  href="https://dehensvh32.henkelgroup.net"  >https://dehensvh32.henkelgroup.net</a><br/><a  href="https://dehensvh33.henkelgroup.net"  >https://dehensvh33.henkelgroup.net</a><br/><a  href="https://dehensvh34.henkelgroup.net"  >https://dehensvh34.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>?</td>
<td>Inner-DMZ</td>
<td>Thorsten vom Bovert</td>
<td>Docker Application / SAP Hybris</td>
</tr>
<tr><td>PIM TST</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5428"  >5428</a></td>
<td><a  href="http://pim-test.henkelgroup.net"  >pim-test.henkelgroup.net</a>.conf</td>
<td><a  href="http://pim-test.henkelgroup.net"  >pim-test.henkelgroup.net</a></td>
<td><a  href="https://dehensvh38.henkelgroup.net"  >https://dehensvh38.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1</td>
<td>Inner-DMZ</td>
<td>Thorsten vom Bovert</td>
<td>Docker Application / SAP Hybris</td>
</tr>
<tr><td>PKI Repository</td>
<td><br/></td>
<td><a  href="http://ocsp.cert.henkel.com"  >ocsp.cert.henkel.com</a>.conf</td>
<td><a  href="http://ocsp.cert.henkel.com"  >ocsp.cert.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>2</td>
<td>Inner-DMZ (Win2019+IIS) &quot;Sandwich&quot;</td>
<td>Christoph Hallek</td>
<td><br/></td>
</tr>
<tr><td>Plant Equipment Mgmt</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5430"  >5430</a></td>
<td><a  href="http://www.pmequi.henkel.com"  >www.pmequi.henkel.com</a>.conf</td>
<td><a  href="http://www.pmequi.henkel.com"  >www.pmequi.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1-2</td>
<td>Inner-DMZ (RHEL8+Tomcat)</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>POD (Milano)</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5431"  >5431</a></td>
<td><a  href="http://extranetua.henkel.com"  >extranetua.henkel.com</a>.conf</td>
<td><a  href="http://extranetua.henkel.com"  >extranetua.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>same as <a  href="http://pod.henkel.com"  >pod.henkel.com</a></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>POD (Milano)</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5431"  >5431</a></td>
<td><a  href="http://eshop.schwarzkopf.com"  >eshop.schwarzkopf.com</a>.conf</td>
<td><a  href="http://eshop.schwarzkopf.com"  >eshop.schwarzkopf.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>POD (Milano)</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5431"  >5431</a></td>
<td><a  href="http://pod.henkel.com"  >pod.henkel.com</a>.conf</td>
<td><a  href="http://pod.henkel.com"  >pod.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Marc Siekmann</td>
<td><br/></td>
</tr>
<tr><td>POD (Milano)</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5431"  >5431</a></td>
<td><a  href="http://skp.pod.henkel.com"  >skp.pod.henkel.com</a>.conf</td>
<td><a  href="http://skp.pod.henkel.com"  >skp.pod.henkel.com</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Portal</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5432"  >5432</a></td>
<td><a  href="http://ssobouncer.henkel.com"  >ssobouncer.henkel.com</a>.conf</td>
<td><a  href="http://ssobouncer.henkel.com"  >ssobouncer.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1-2</td>
<td>Inner-DMZ (RHEL8+Tomcat)</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>PromoRoyal</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5433"  >5433</a></td>
<td><a  href="http://promoroyal.henkel.com"  >promoroyal.henkel.com</a>.conf</td>
<td><a  href="http://promoroyal.henkel.com"  >promoroyal.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1 or 2</td>
<td>Inner-DMZ (RHEL8+Tomcat)</td>
<td><br/></td>
<td>HA needed or not ?</td>
</tr>
<tr><td>Redmine</td>
<td><br/></td>
<td><a  href="http://exmine.henkelgroup.net"  >exmine.henkelgroup.net</a>.conf</td>
<td><a  href="http://exmine.henkelgroup.net"  >exmine.henkelgroup.net</a></td>
<td><a  href="https://dedussv-exmine.de.henkelgroup.net/exmine/"  >https://dedussv-exmine.de.henkelgroup.net/exmine/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Room Condition Monitoring</td>
<td><br/></td>
<td><a  href="http://rocomo.henkelgroup.net"  >rocomo.henkelgroup.net</a>.conf</td>
<td><a  href="http://rocomo.henkelgroup.net"  >rocomo.henkelgroup.net</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>Salonory (Schwarzkopf eShop)</td>
<td><br/></td>
<td><a  href="http://salonory.com"  >salonory.com</a>.conf</td>
<td><a  href="http://salonory.com"  >salonory.com</a></td>
<td><a  href="https://xlhenvi001.henkelgroup.net"  >https://xlhenvi001.henkelgroup.net</a><br/><a  href="https://xlhenvi002.henkelgroup.net"  >https://xlhenvi002.henkelgroup.net</a><br/><a  href="https://xlhenvi003.henkelgroup.net"  >https://xlhenvi003.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ</td>
<td><br/></td>
<td>Docker Application / SAP Hybris</td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-c38.henkelgroup.net"  >sap2hen-c38.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-c38.henkelgroup.net"  >sap2hen-c38.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-d38.henkelgroup.net"  >sap2hen-d38.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-d38.henkelgroup.net"  >sap2hen-d38.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-d89.henkelgroup.net"  >sap2hen-d89.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-d89.henkelgroup.net"  >sap2hen-d89.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-p38.henkelgroup.net"  >sap2hen-p38.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-p38.henkelgroup.net"  >sap2hen-p38.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-p92.henkelgroup.net"  >sap2hen-p92.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-p92.henkelgroup.net"  >sap2hen-p92.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-q92.henkelgroup.net"  >sap2hen-q92.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-q92.henkelgroup.net"  >sap2hen-q92.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-r92.henkelgroup.net"  >sap2hen-r92.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-r92.henkelgroup.net"  >sap2hen-r92.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-s90.henkelgroup.net"  >sap2hen-s90.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-s90.henkelgroup.net"  >sap2hen-s90.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5050"  >5050</a></td>
<td><a  href="http://sap2hen-z38.henkelgroup.net"  >sap2hen-z38.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-z38.henkelgroup.net"  >sap2hen-z38.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP Ariba</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5434"  >5434</a></td>
<td><a  href="http://sap2hen-dpo.henkelgroup.net"  >sap2hen-dpo.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-dpo.henkelgroup.net"  >sap2hen-dpo.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP Ariba</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5434"  >5434</a></td>
<td><a  href="http://sap2hen-ppo.henkelgroup.net"  >sap2hen-ppo.henkelgroup.net</a>.conf</td>
<td><a  href="http://sap2hen-ppo.henkelgroup.net"  >sap2hen-ppo.henkelgroup.net</a></td>
<td><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>SAP Cloud Connector</td>
<td>Mirko Feisel</td>
<td><br/></td>
</tr>
<tr><td>SAP P34 / eFolders</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5435"  >5435</a></td>
<td><a  href="http://www.efolders.henkel.com"  >www.efolders.henkel.com</a>.conf</td>
<td><a  href="http://www.efolders.henkel.com"  >www.efolders.henkel.com</a></td>
<td><a  href="http://sapp34.de.henkelgroup.net:8000/SAP/PUBLIC/BC/ITS/DESIGNS/henkel/"  >http://sapp34.de.henkelgroup.net:8000/SAP/PUBLIC/BC/ITS/DESIGNS/henkel/</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Tobias Voetz</td>
<td>still needed ?</td>
</tr>
<tr><td>SDB</td>
<td><br/></td>
<td><a  href="http://sdb.henkel.de"  >sdb.henkel.de</a>.conf</td>
<td><a  href="http://sdb.henkel.de"  >sdb.henkel.de</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>Sealmo</td>
<td><br/></td>
<td><a  href="http://sealmo.henkel.com"  >sealmo.henkel.com</a>.conf</td>
<td><a  href="http://sealmo.henkel.com"  >sealmo.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>Service Provider Portal</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5436"  >5436</a></td>
<td><a  href="http://spp.henkel.com"  >spp.henkel.com</a>.conf</td>
<td><a  href="http://spp.henkel.com"  >spp.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Static Web</td>
<td>Michael Leutgeb</td>
<td><br/></td>
</tr>
<tr><td>SFSExt</td>
<td><br/></td>
<td><a  href="http://sfsext.henkelgroup.net"  >sfsext.henkelgroup.net</a>.conf</td>
<td><a  href="http://sfsext.henkelgroup.net"  >sfsext.henkelgroup.net</a></td>
<td><a  href="https://dehensvm163.henkelgroup.net/iPAS/"  >https://dehensvm163.henkelgroup.net/iPAS/</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ (Win2019)</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SKP eShop</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5437"  >5437</a></td>
<td><a  href="http://shop.indola.at"  >shop.indola.at</a>.conf</td>
<td>shop.indola.*<br/>shop.indola-professional.*<br/>shop.schwarzkopf-professional.*</td>
<td><a  href="https://xlhenvi001.henkelgroup.net"  >https://xlhenvi001.henkelgroup.net</a><br/><a  href="https://xlhenvi002.henkelgroup.net"  >https://xlhenvi002.henkelgroup.net</a><br/><a  href="https://xlhenvi003.henkelgroup.net"  >https://xlhenvi003.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>same as <a  href="http://salonory.com"  >salonory.com</a></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SKP eShop</td>
<td><br/></td>
<td><a  href="http://shop.indola.pt"  >shop.indola.pt</a>.conf</td>
<td><a  href="http://shop.indola.pt"  >shop.indola.pt</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>N/A</td>
<td><br/></td>
<td>redirect only</td>
</tr>
<tr><td>Skype Broadcast</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5438"  >5438</a></td>
<td><a  href="http://smbc.henkelgroup.net"  >smbc.henkelgroup.net</a>.conf</td>
<td><a  href="http://smbc.henkelgroup.net"  >smbc.henkelgroup.net</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Smart Mosquito</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5439"  >5439</a></td>
<td><a  href="http://smartfrmupd.henkelgroup.net"  >smartfrmupd.henkelgroup.net</a>.conf</td>
<td><a  href="http://smartfrmupd.henkelgroup.net"  >smartfrmupd.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Static Content Push</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://aia.cert.henkel.com"  >aia.cert.henkel.com</a>.conf</td>
<td><a  href="http://aia.cert.henkel.com"  >aia.cert.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://aia.cert.henkeltest.net"  >aia.cert.henkeltest.net</a>.conf</td>
<td><a  href="http://aia.cert.henkeltest.net"  >aia.cert.henkeltest.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://cdp.cert.henkel.com"  >cdp.cert.henkel.com</a>.conf</td>
<td><a  href="http://cdp.cert.henkel.com"  >cdp.cert.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://cdp.cert.henkeltest.net"  >cdp.cert.henkeltest.net</a>.conf</td>
<td><a  href="http://cdp.cert.henkeltest.net"  >cdp.cert.henkeltest.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://cert.henkel.com"  >cert.henkel.com</a>.conf</td>
<td><a  href="http://cert.henkel.com"  >cert.henkel.com</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://cert.henkeltest.net"  >cert.henkeltest.net</a>.conf</td>
<td><a  href="http://cert.henkeltest.net"  >cert.henkeltest.net</a></td>
<td><br/></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://cp.cert.henkel.com"  >cp.cert.henkel.com</a>.conf</td>
<td><a  href="http://cp.cert.henkel.com"  >cp.cert.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://cp.cert.henkeltest.net"  >cp.cert.henkeltest.net</a>.conf</td>
<td><a  href="http://cp.cert.henkeltest.net"  >cp.cert.henkeltest.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://pki.cert.henkel.com"  >pki.cert.henkel.com</a>.conf</td>
<td><a  href="http://pki.cert.henkel.com"  >pki.cert.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>SSL CA</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5440"  >5440</a></td>
<td><a  href="http://pki.cert.henkeltest.net"  >pki.cert.henkeltest.net</a>.conf</td>
<td><a  href="http://pki.cert.henkeltest.net"  >pki.cert.henkeltest.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>same as OCSP</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Supplier Portal</td>
<td><br/></td>
<td><a  href="http://supplierapp-stage.henkelgroup.net"  >supplierapp-stage.henkelgroup.net</a>.conf</td>
<td><a  href="http://supplierapp-stage.henkelgroup.net"  >supplierapp-stage.henkelgroup.net</a></td>
<td><a  href="https://dedussv-sp16ext.henkelgroup.net/"  >https://dedussv-sp16ext.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td>1</td>
<td>Inner-DMZ Multiplexer (Win2019)</td>
<td><br/></td>
<td>still needed ? / migration to IBM ?</td>
</tr>
<tr><td>Supplier Portal</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5442"  >5442</a></td>
<td><a  href="http://supplierportal.henkelgroup.net"  >supplierportal.henkelgroup.net</a>.conf</td>
<td><a  href="http://supplierportal.henkelgroup.net"  >supplierportal.henkelgroup.net</a></td>
<td><a  href="https://dehensvm057.henkelgroup.net"  >https://dehensvm057.henkelgroup.net</a><br/><a  href="https://dehensvm058.henkelgroup.net"  >https://dehensvm058.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>2</td>
<td>Inner-DMZ (Win2019)</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Supplier Portal</td>
<td><br/></td>
<td><a  href="http://supplierportal-stage.henkelgroup.net"  >supplierportal-stage.henkelgroup.net</a>.conf</td>
<td><a  href="http://supplierportal-stage.henkelgroup.net"  >supplierportal-stage.henkelgroup.net</a></td>
<td><a  href="https://deibmsvn30009.henkelgroup.net/"  >https://deibmsvn30009.henkelgroup.net/</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>1</td>
<td>Inner-DMZ (Win2019)</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>Supplier Portal</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5441"  >5441</a></td>
<td><a  href="http://www.supplier-portal.henkel.com"  >www.supplier-portal.henkel.com</a>.conf</td>
<td><a  href="http://www.supplier-portal.henkel.com"  >www.supplier-portal.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>still needed / successor <a  href="http://supplierportal.henkelgroup.net"  >supplierportal.henkelgroup.net</a></td>
</tr>
<tr><td>SuseSMT</td>
<td><br/></td>
<td><a  href="http://dedussv-susesmt.henkelgroup.net"  >dedussv-susesmt.henkelgroup.net</a>.conf</td>
<td><a  href="http://dedussv-susesmt.henkelgroup.net"  >dedussv-susesmt.henkelgroup.net</a></td>
<td><br/></td>
<td>decom</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>decom</td>
</tr>
<tr><td>VISIT</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5444"  >5444</a></td>
<td><a  href="http://visit.henkel.com"  >visit.henkel.com</a>.conf</td>
<td><a  href="http://visit.henkel.com"  >visit.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td>2</td>
<td>Inner-DMZ (RHEL8+Tomcat) &quot;Sandwich&quot;</td>
<td>Carolina Betancourt</td>
<td><br/></td>
</tr>
<tr><td>VISIT</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5444"  >5444</a></td>
<td><a  href="http://visit.henkelgroup.net"  >visit.henkelgroup.net</a>.conf</td>
<td><a  href="http://visit.henkelgroup.net"  >visit.henkelgroup.net</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>same as <a  href="http://visit.henkel.com"  >visit.henkel.com</a></td>
<td>Carolina Betancourt</td>
<td><br/></td>
</tr>
<tr><td>VISIT DEV</td>
<td><br/></td>
<td><a  href="http://visit-dev.henkelgroup.net"  >visit-dev.henkelgroup.net</a>.conf</td>
<td><a  href="http://visit-dev.henkelgroup.net"  >visit-dev.henkelgroup.net</a></td>
<td><a  href="https://dedussv-sjsdevlb.de.henkelgroup.net/visit/"  >https://dedussv-sjsdevlb.de.henkelgroup.net/visit/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Carolina Betancourt</td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webextat01.henkelgroup.net"  >webextat01.henkelgroup.net</a>.conf</td>
<td><a  href="http://webextat01.henkelgroup.net"  >webextat01.henkelgroup.net</a></td>
<td><a  href="https://atviesvev01.henkelgroup.net:4443/"  >https://atviesvev01.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webextat02.henkelgroup.net"  >webextat02.henkelgroup.net</a>.conf</td>
<td><a  href="http://webextat02.henkelgroup.net"  >webextat02.henkelgroup.net</a></td>
<td><a  href="https://atviesvev02.henkelgroup.net:4443/"  >https://atviesvev02.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webexthk01.henkelgroup.net"  >webexthk01.henkelgroup.net</a>.conf</td>
<td><a  href="http://webexthk01.henkelgroup.net"  >webexthk01.henkelgroup.net</a></td>
<td><a  href="https://hkhkgsvevse01.henkelgroup.net:4443/"  >https://hkhkgsvevse01.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webexthk02.henkelgroup.net"  >webexthk02.henkelgroup.net</a>.conf</td>
<td><a  href="http://webexthk02.henkelgroup.net"  >webexthk02.henkelgroup.net</a></td>
<td><a  href="https://hkhkgsvevse02.henkelgroup.net:4443/"  >https://hkhkgsvevse02.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webextsk01.henkelgroup.net"  >webextsk01.henkelgroup.net</a>.conf</td>
<td><a  href="http://webextsk01.henkelgroup.net"  >webextsk01.henkelgroup.net</a></td>
<td><a  href="https://skbtssvev01.henkelgroup.net:4443/"  >https://skbtssvev01.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webextsk02.henkelgroup.net"  >webextsk02.henkelgroup.net</a>.conf</td>
<td><a  href="http://webextsk02.henkelgroup.net"  >webextsk02.henkelgroup.net</a></td>
<td><a  href="https://skbtssvev02.henkelgroup.net:4443/"  >https://skbtssvev02.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webextus01.henkelgroup.net"  >webextus01.henkelgroup.net</a>.conf</td>
<td><a  href="http://webextus01.henkelgroup.net"  >webextus01.henkelgroup.net</a></td>
<td><a  href="https://usrhlsvevse01.henkelgroup.net:4443/"  >https://usrhlsvevse01.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>WebExt</td>
<td><br/></td>
<td><a  href="http://webextus02.henkelgroup.net"  >webextus02.henkelgroup.net</a>.conf</td>
<td><a  href="http://webextus02.henkelgroup.net"  >webextus02.henkelgroup.net</a></td>
<td><a  href="https://usrhlsvevse02.henkelgroup.net:4443/"  >https://usrhlsvevse02.henkelgroup.net:4443/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Inner-DMZ Multiplexer</td>
<td><br/></td>
<td><br/></td>
</tr>
<tr><td>XIM</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5445"  >5445</a></td>
<td><a  href="http://xim.henkel.com"  >xim.henkel.com</a>.conf</td>
<td><a  href="http://xim.henkel.com"  >xim.henkel.com</a></td>
<td><a  href="https://dehensv613.de.henkelgroup.net"  >https://dehensv613.de.henkelgroup.net</a><br/><a  href="https://dehensv614.de.henkelgroup.net"  >https://dehensv614.de.henkelgroup.net</a></td>
<td>IBM</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Thomas Willms</td>
<td>relation to MyID</td>
</tr>
<tr><td>Z20rooms</td>
<td><a  href="https://exmine.henkelgroup.net/exmine/issues/5420"  >5420</a></td>
<td><a  href="http://z20rooms.henkelgroup.net"  >z20rooms.henkelgroup.net</a>.conf</td>
<td><a  href="http://z20rooms.henkelgroup.net"  >z20rooms.henkelgroup.net</a></td>
<td><a  href="https://dehensv530.de.henkelgroup.net/"  >https://dehensv530.de.henkelgroup.net/</a></td>
<td>DUS</td>
<td><br/></td>
<td><br/></td>
<td><br/></td>
<td>Static Web</td>
<td>Marc Siekmann</td>
<td><br/></td>
</tr>
</tbody></table>