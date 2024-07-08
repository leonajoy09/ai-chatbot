# ![Under Construction](../images/../../images/gcp/pngtree-flat-under-construction-sign-background-design-png-image_6471962.png) 

# Objective 

Objective of this document is to: 
- Socialize GCP Architectural Blueprint for internet-facing applications.
- Share information about applicable security enforcements and governance for internet facing applications on GCP. 

!!! info
    TBD

## DMZ Concept on GCP

In general, A DMZ  or demilitarized zone is a perimeter network that protects and adds an extra layer of security to an organization’s internal local-area network from untrusted traffic.

The end goal of a demilitarized zone network is to allow an organization to access untrusted networks, such as the internet, while ensuring its private network or LAN remains secure. Organizations typically store external-facing services and resources such as front end facing web servers, in the DMZ while backend/db component of the application is kept in the internal/more isolated network. 

On GCP, DMZ concept is implemented via segmenting the network/environments. Respective internet exposed application's GCP project (service project)is provisioned in the respevtive DMz environment such as Dev-dmz, Test-dmz & Prod-dmz. 

![example GCP henkel org resource hierarchy](../images/../../images/gcp/GCP-ResourceHierarchy-DMZ.png)


## GCP Architectural Blueprint for internet-facing applications.  

As internet-facing applications move to the cloud, they must be able to scale, and they must have security controls and visibility that are equivalent to those controls in the on-premises environment.

In most cases, traditional web server/reverse proxy component is replaced by Google Cloud Load Balancing i.e. Global External HTTP/HTTPs Application Load Balancer. It serves the same purpose with added benefits e.g. fully managed service, advanced traffic management capabilities and so on. 

An external Application Load Balancer is a proxy-based Layer 7 load balancer that enables to run and scale services behind a single external IP address. The external Application Load Balancer distributes HTTP and HTTPS traffic to backends hosted on a variety of Google Cloud platform services (such as Compute Engine, Google Kubernetes Engine (GKE), Cloud Storage, and so on), as well as external backends connected over the internet or via hybrid connectivity.

More Details: [GCP External Application Load Balancer overview](https://cloud.google.com/load-balancing/docs/https)

![GCP Architectural Blueprint for internet-facing applications](../images/../../images/gcp/gcp-internet-ingress-concept.drawio.png)



## Governance

Governance policies are enforced via GCP Org policies. Below are list of policies which are relevant to internet facing applications. 

- **Disallow External IP to VMs(GCE Instances)**:
  - Directly attaching/assigning external IP(Public IP) to VMs/GCE instances is disallowed. 
  - This is enforced via GCP org policy constraint : ```constraints/compute.vmExternalIpAccess``` which is enforced on Org level. 
- **Restrict load balancer types**: 
  - For internet facing apps, Allowed Google cloud load balancer type is ```GLOBAL_EXTERNAL_MANAGED_HTTP_HTTPS```.
  - This is enforced via GCP org policy constraint: ```constraints/compute.restrictLoadBalancerCreationForTypes``` which is enforced on all DMZ area folders/networks. 
- **Allow External IP to Global External Application LB**:
  - For internet facing apps, External IP(Public IP) is allowed to be attached/assigned to Global External Application LBs only. 
- **Disable Creation of global self-managed SSL Certificates** 
  - Creation of global self-managed SSL Certificates is disabled. 
  - This is enforced via GCP org policy constraint: ```constraints/compute.disableGlobalSelfManagedSslCertificate``` which is enforced on Org level.


## Security 
- **DDoS protection and WAF**:
  - ***Google Cloud Armor:***
      Google Cloud Armor helps to protect Google Cloud deployments from multiple types of threats, including distributed denial-of-service (DDoS) attacks and application attacks like cross-site scripting (XSS) and SQL injection (SQLi). Google Cloud Armor features some automatic protections and some that we need to configure. 
      
      Google Cloud Armor provides always-on DDoS protection against network or protocol-based volumetric DDoS attacks. This protection is for applications or services behind load balancers.
      
      Google Cloud Armor security policies protect applications running behind a load balancer from distributed denial-of-service (DDoS) and other web-based attacks. The Google Cloud Armor security policies enforce custom Layer 7 filtering policies, including pre-configured WAF rules that mitigate OWASP top 10 web application vulnerability risks. Security policies are attached to the backend services of the load balancers e.g. Global external Application Load Balancer

      Google Cloud Armor security policies enables to allow or deny access to deployment at the Google Cloud edge, as close as possible to the source of incoming traffic. This prevents unwelcome traffic from consuming resources or entering Virtual Private Cloud (VPC) networks.

  - ***Google Cloud Armor Defualt Security Policy:*** 
      For every GCP Project provisioned via Project Factory in the dmz environment prod-dmz, dev-dmz, tst-dmz etc., Project Factory by defauly sets up default Google Cloud Armor security policy with several rules. Please refer screenshot below. 

      ![Google Cloud Armor Defualt Security Policy](../images/../../images/gcp/gcp-internet-facing-app-default-cloud-armor-policy.png)

      !!! info
          Default policy is usually created with naming convention:```<<projectid-default-casp>>``` e.g. hmcp-tstdz-zsclrapc-de-prj-ovq-default-casp 

      !!! IMPORTANT NOTE
          Project Factory only creates the Cloud Armor Default policy in your dmz project.It is not yet attached to any LB backend service. 
          There'a separate event based Platform automation running on GCP which automatically attaches the Default Cloud Armor Policy to every new or modified Load Balancer's backend service in the respective dmz project. 
          This Platform automation leverages the Cloud Asset Feed to continuously monitor Google Cloud Backend creations and edits.
          
  
  - ***Google Cloud Armor Additional Policies:*** 
      TBD - Explain the process of getting Additional Policies configured. 

  - ***Google Cloud Armor Policies - Exemption:*** 
      TBD - Explain the process of requesting exemptions for Cloud Armor Policy/Policies. 


- **SSL Certificates**:
  - Google Cloud Certificate Manager  
    On GCP, SSL certs are procured/stored/managed in the native SSL certificate management service [Google Cloud Certificate Manager](https://cloud.google.com/certificate-manager/docs/overview). Google Cloud Certificate Manager lets you acquire and manage Transport Layer Security (TLS)/SSL certificates for use with the following load balancer resources:  
      Target HTTPS proxies used by Application Load Balancers: 

        Global external Application Load Balancer  
        Classic Application Load Balancer  
        Regional external Application Load Balancer  
        Regional internal Application Load Balancer  
        Cross-region internal Application Load Balancer  
      Target SSL proxies used by proxy Network Load Balancers:  

        Global external proxy Network Load Balancer  
        Classic proxy Network Load Balancer  

    Certficat Manager supports both - Google-managed certificates and Self-managed certificates.  
    - *Google-managed certificates* are certificates that Google Cloud obtains and manages for you.  
    - *Self-managed certificates* are certificates that you obtain, provision, and renew yourself.

  - Existing SSL Certs  

      Most of Henkel's application use cases falls under this catagory i.e. Applications has existing Public SSL    certificate which is issued by Henkel's internal Public SSL certificate management team (C/O Thomas T Erdmann   (ext) <thomas.t.erdmann@henkel.com>)  

      In case of existing SSL cert, you need to manually upload it (.pem format) in the GCP certificate manager service     in your application's respective GCP project. Along side SSL cert, you would also need Private key which was used     to generate respective SSL cert's CSR (Certificate Signing Request) file. You can upload SSL cert into GCP    certificate manager either via GCP console or via gcloud CLI command. 
      #### Upload a self-managed certificate
      <a id="upload-ssl-cert"></a>  
      
      To upload a self-managed certificate, complete the steps in this section. You can upload global and regional X.509    TLS (SSL) certificates of the following types:

        - Certificates generated by third-party certificate authorities (CAs) of your choice
        - Certificates generated by certificate authorities under your control
        - Self-signed certificates.  

      You must upload the following PEM-encoded files:

          - The certificate (.crt) file
          - The corresponding private key (.key) file  

      To complete this task, you must have one of the following IAM roles on the target Google Cloud project. Use IAM     Factory to request/grant the IAM roles.  
          - Certificate Manager Editor  
          - Certificate Manager Owner  

      PSB gcloud CLI command example to upload SSL cert into GCP certificate manager:

      ```
      gcloud certificate-manager certificates create  CERTIFICATE_NAME \
        --certificate-file="CERTIFICATE_FILE" \
        --private-key-file="PRIVATE_KEY_FILE" \
        [--location="REGION"]
      ```  
      Replace the following:  

        CERTIFICATE_NAME: a unique name that describes this certificate.  
        CERTIFICATE_FILE: the path and filename of the .crt certificate file.  
        PRIVATE_KEY_FILE: the path and filename of the .key private key file.  
        REGION: the target Google Cloud region. The default is global. This setting is optional.  

        Reference:  
        [Upload a self-managed certificate ](https://cloud.google.com/certificate-manager/docs/certificates#cert-self) 

  - New SSL Certs  
      In case the application doesnt have existing public SSL certificate, Then you need to request a new SSL     certificate. Following is the high level steps involved in requesting and procuring the new public SSL cert.  

    1. Generate CSR (Certificate Signing Request) file. Please note - Usually you will need to generate neprivate key while generating CSR file. PSB example command to generate a Private Key and a CSR.  
      ```
        openssl req \
         -newkey rsa:2048 -nodes -keyout domain.key \
         -out domain.csr
      ```
      Answer the CSR information prompt to complete the process.  
              
      The -newkey rsa:2048 option specifies that the key should be 2048-bit, generated using thealgorithmTh-nodes option specifies that the private key should not be encrypted with a phrase. The -neoption, whicis not included here but implied, indicates that a CSR is bgenerated.  
      [Tutorial OpenSSL Essentials: Working with SSL Certificates, Private Keys and CSRs](httwwdigitalocean.cocommututorialopenssl-essentials-working-with-ssl-certificates-private-keys-and-csrs) 
        
    2. Share CSR file generated in step#1 with Henkel Public SSL cert management team via email. Contact perso-    Thomas T Erdman  (ext) <thomas.t.erdmann@henkel.com>  
    3. Receive SSL cert file (.crt) from Henkel Public SSL cert management team. Please note - Usually yowil     receive chained certificates from them.  

    After you recieve the SSL cert file, please follow the steps mentioned under [Upload a self-managed certificate] (./gcp-internet-facing-applications-blueprint.md#upload-ssl-cert) to manually upload it inthe GCPcertificatmanager service 

    

## Network
- **DNS**:
  - Existing domain/DNS record
  - New domain/DNS record

## Additional Resources 
- **Terraform Modules**:
  - GCLB 
  - GCE

## FAQs
