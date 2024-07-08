# SSH Public Key Based Linux Access

Granting SSH based access using SSH public keys requires two things to be done:

1. Persons who should get access need to have maintained their personal SSH public key via MyID
1. Access to the technical account for certain persons needs to be granted via MyID


## SSH Key Management

### How can I generate an SSH Key Pair which is necessary to access Linux servers?

The following key types will be accepted as by Henkel’s security policy:

* ED25519, **Henkel default** (“ssh-ed25519 AAAAC3NzaC1lZDI1NTE5A...”)
* RSA with 3072 or 4096 bits key size (“ssh-rsa AAAAB3NzaC1yc2EAAAABJQAA...”)

In all cases, your private key **must be encrypted** by a password of your choice, and you need to **store it in a safe place**. Under no circumstances share your private key with anyone else.

**On Windows:** There are different tools on the market also free of charge that can be used for creating your pair SSH key pairs. Here you can find an example by using the [puttygen](https://www.ssh.com/ssh/putty/windows/puttygen) tool, but you can use any other tool.

1. Start puttygen
1. Select the key type “ED25519”
1. Click “Generate” and move the mouse randomly over the grey area
1. Enter a password under the “key passphrase” and confirm the key passphrase password
1. Save your private key
1. Copy the text from “Public key for pasting into OpenSSH public keys file” and save it to a text file. This is your public key that is needed by Henkel in order to authenticate you.


**On Linux:** You can run e.g. the following command: `ssh-keygen -t ed25519 ...`


### How can I upload my SSH public key to Linux servers?

For AD-joined Linux systems managed by IBM:

1. Access [myID](https://myid.henkelgroup.net/)
1. In the ‘SSH Key Management’ menu, click on ‘SSH Public Key Management (Personal)’
1. If you own multiple identities, please select the identity for which you want to upload the SSH public key
1. Choose “Add New or Update SSH Key”
1. Paste your SSH Public key into the textbox and click “Next”
1. Review and confirm your request: On bottom of the page, click on ‘Submit’ to confirm your request. Your changes are applied immediately.

For other Linux systems, please open a helpdesk ticket.

## How to Grant access to the technical / non-personal-primary account? (Example below)

<ol>
<li>Go to MyID web page: <a href="https://myid.henkelgroup.net/">https://myid.henkelgroup.net/</a></li>
<li>From MyID open side menu and go to Manage Access --&gt; Manage User Access<br /><br />
<img alt="Manage User Access" src="../../images/ssh-key-access01.png" />
</li>
<li>Select user name which should get the access (personal account). You can select <b>only one</b> personal account at a time and hit <b>Next</b>.<br /><br />
<img alt="Select User" src="../../images/ssh-key-access02.png" />
</li>
<li>Select Technical User which have access on the server already and hit <b>Next</b>.

Important is that Technical user need to have annotation as highlighted on the picture below, you can filter it out using Filter option. <b>Application: SSH Access, Attribute: SSH_LOGIN_AS</b><br /><br />
<img alt="Manage Access" src="../../images/ssh-key-access03.png" />
</li>
<li>Confirm the changes and hit <b>Submit</b>.<br /><br />
<img alt="Confirm the Changes" src="../../images/ssh-key-access04.png" />
</li>
<li>Wait for approval and implementation.</li>
</ol>