*Docker Security Recommendations for Developers*

**Quick wins** 

- [ ] Avoid the use of `ADD` in favor of `COPY`
- [ ] Avoid the use of `apt/apk upgrade`
- [ ] Avoid curl bashing in `RUN` directives
- [ ] Ensure a `USER` directive is specified
- [ ] Ensure the base image version is pinned
- [ ] Ensure the OS packages versions are pinned
- [ ] Ensure that the base image has no known vulnerabilities

**Check for known vulnerabilities** 

Check your docker image for known vulnerabilities before you deploy. This should be done automatically in your build pipeline. 

This can be done manually using the following command:

```
docker scan python:alpine Testing python:alpine##...

Organization:      undefined

Package manager:   apk

Project name:      docker-image|python Docker image:      python:alpine Platform:          linux/amd64

✓Tested 37 dependencies for known vulnerabilities, no vulnerable paths found.
```

**SAST** 

You can run tools for static security testing against your Dockerfile like in other programming languages.

There are many open source tools out there, like Clair and Trivy which should run in your build pipeline to detect issues in an early stage. You also might have a look at the commercial products on the market to make the integration more convenient.

**Prevent Privilege Escalation** 

***Set a user during build time***
```
FROM python:alpine

RUN groupadd -r myuser #&& useradd -r -g myuser myuser

<HERE DO WHAT YOU HAVE TO DO AS A ROOT USER LIKE INSTALLING PACKAGES ETC.>

USER myuser
```
***Limit capabilities***

Drop all capabilities `--cap-drop all` and then add only required ones you need. For example:

```
docker run --cap-drop all --cap-add CHOWN python:alpine
```

In addition run your docker images with `--security-opt=no-new-privileges` in order to prevent escalate privileges using setuid or setgid binaries.

**Disable inter-container communication** 

By default inter-container communication (icc) is enabled - it means that all containers can talk with each other using the `docker0` interface. This can be disabled by running docker daemon with `--icc=false` flag.
