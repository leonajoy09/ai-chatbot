# SSH/SFTP over Forward Proxy configuration for Linux clients (E.g. RHEL 8)

The following example configuration shows the entries required in the client ssh_config file (`~/.ssh/config`).

The tool `socat` is required to be installed.

## Proxy with authentication

With Authentication ~/.ssh/config for socat

```
# with authentication on the proxy
Host destination_host
User destination_user
IdentityFile /path/to/private/key/if/any
ProxyCommand socat - PROXY:ibm-proxy-de.henkelgroup.net:%h:%p,proxyport=9090,proxyauth='PROXY_USER':'PROXY_PASSWORD'
```


## Proxy with IP allowlist


With IP allowlisting: `~/.ssh/config` for `socat`

```
# with IP-based allow list on the proxy
Host destination_host
User destination_user
IdentityFile /path/to/private/key/if/any
ProxyCommand socat - PROXY:ibm-proxy-de.henkelgroup.net:%h:%p,proxyport=9090
```