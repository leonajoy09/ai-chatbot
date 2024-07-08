# Azure IoT Hub

```
Microsoft.Devices/iotHubs
Microsoft.Devices/iotHubs/*
```

## Minimum required configuration

- Use [Private Endpoint](https://learn.microsoft.com/en-us/azure/iot-hub/virtual-network-support#ingress-connectivity-to-iot-hub-using-azure-private-link) for inbound communication when IoT devices are on the Henkel network
- Public Network access by default should be disabled. An exemption will be granted for Iot Hub use cases for devices external to the Henkel network
- Ensure IoT devices support TLS 1.2 communication. IoT Hub should accept connections over TLS 1.2
- Use System-assigned identity to access other resources (e.g. Storage account, Key Vault)
- Enable [Defender for IoT](https://learn.microsoft.com/en-us/azure/defender-for-iot/device-builders/quickstart-onboard-iot-hub#create-an-iot-hub-with-microsoft-defender-for-iot) integration with IoT Hub
- Use [Identity-based authentication](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-dev-guide-azure-ad-rbac) for Service APIs. Disable authentication using Shared Access Key for Service APIs
- Use [X.509 certificate-based authentication](https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-x509ca-overview) for devices. Disable authentication using SAS tokens.

## Enforced Policies

{{ display_azure_policies('iothub') }}

## Terraform example

Coming soon
