#Information for Ops

*Container Security Recommendations for Operators*

**General**
It is very important for your operational security to have a secure runtime enviroment.
To prevent from known, container escapes vulnerabilities, which typically end in escalating to root/administrator privileges, patching Docker Engine and Docker Machine is crucial.

In addition, containers (unlike in virtual machines) share the kernel with the host, therefore kernel exploits executed inside the container will directly hit host kernel.

Some of the following configuratoin parameters might have impact on the applications inside the containers. Speak to the developers about the configuration that you are going to use in production.

**Docker**

***Do not expose the Docker daemon socket***
Docker socket /var/run/docker.sock is the UNIX socket that Docker is listening to. This is the primary entry point for the Docker API. The owner of this socket is root. Giving someone access to it is equivalent to giving unrestricted root access to your host.

# Do not enable tcp Docker daemon socket.
# Do not expose /var/run/docker.sock to other containers

***Prevent Privilege Escalation***

Limit capabilities

Drop all capabilities `--cap-drop all` and then add only required ones you need. 
For example:

`docker run --cap-drop all --cap-add CHOWN python:alpine`

In addition run your docker images with `--security-opt=no-new-privileges` in order to prevent escalate privileges using setuid or setgid binaries. **Do not run containers with the `--privileged` flag!**


***Disable inter-container communication***

By default inter-container communication (icc) is enabled - it means that all containers can talk with each other using the `docker0` interface. This can be disabled by running docker daemon with `--icc=false` flag.

***Detect misconfigurations in Docker***

There are (sast) tools to detect misconfiguration in Docker:

* [dev-sec.io](https://dev-sec.io/baselines/docker/)
* [inspec.io](https://www.inspec.io/docs/reference/resources/docker/)

**Kubernetes**

***Limit capabilities***
Capabilities are a set of privileges that can be used by privileged. Drop all capabilities and add only those you really need.
In kubernetes this can be configured in Security Context using `capabilities` field e.g.:
```yaml
  containers:
  - name: ...
    image: ....
    securityContext:
          ...
          capabilities:
            drop:
              - all
            add:
              - CHOWN
          ...
``` 
Check also [Pod Security Policies](https://kubernetes.io/docs/concepts/policy/pod-security-policy/)

***Prevent Privilege Escalation***

In kubernetes, this can be configured in Security Context using allowPrivilegeEscalation field e.g.:

```yaml
  containers:
  - name: ...
    image: ....
    securityContext:
          ...
          allowPrivilegeEscalation: false
          ...
```
Check also [Pod Security Policies](https://kubernetes.io/docs/concepts/policy/pod-security-policy/)

***Set filesystem and volumes to read-only***
Run containers with a read-only filesystem. Speak to the developers if this has any effect on the application.

Set this to your kubernetes Security Context:

```yaml
  containers:
  - name: ...
    image: ....
    securityContext:
          ...
          readOnlyRootFilesystem: true
          ...
```
***Linux Security Module***

In addition to your default security profile you might want to use a security profile like seccomp, AppArmor, or SELinux.   
Check out the [Security Context documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

***Detect misconfigurations in Kubernetes***

There are (sast) tools to detect misconfiguration in your Kubernetes configuration:

* [kubeaudit](https://github.com/Shopify/kubeaudit)
* [kube-bench](https://github.com/aquasecurity/kube-bench)
* [kubesec.io](https://kubesec.io/)
