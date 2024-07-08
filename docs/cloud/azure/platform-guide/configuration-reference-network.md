---
hide:
  - toc
---

# Network Configuration Reference

An Azure Landing Zone has a network configuration file for each environment, e.g. `network.dev.json` and `network.prd.json` for a Landing Zone with a `dev` and `prd` environment.

The network configuration contains specifications of the virtual networks and related resources (subnets, Network Security Groups, Application Security Groups, Bastion, NAT Gateways, Build Agent).

## `network.<env>.json` Reference
--8<-- "schemas/network-7.schema.md"
