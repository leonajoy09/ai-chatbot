# Configuration Reference

Landing Zones are managed in configuration files where Application Teams can request changes and request provisioning of the managed Platform features.

The section provides a configuration reference for the configuration files containted for each landing zone. The configuration guidance also exists as a json schema such that common code editors like Visual Studio Code will provide IntelliSense and linting when editing a configuration file.

* [Landing Zone Configuration (`config.json`)](configuration-reference-lz.md)
* [Network Configuration (`network.<env>.json`)](configuration-reference-network.md)

## Raising a Pull Request

Application Teams can request changes to their landing zone configuration and network resources.

All members of the Landing Zone provided developers myId group (`APP-ALZ-<LZ>-developers`) have Pull Request contributor access to the Landing Zones configuration repository [hmanagedcloud/AzurePlatform/landing-zones](https://dev.azure.com/hmanagedcloud/AzurePlatform/_git/landing-zones).

Team members can request changes to any Landing Zone feature for their own Landing Zone configuration. The Azure Platform team will review and fullfill the deployment of the requested changes.
