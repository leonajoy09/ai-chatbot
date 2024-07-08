# Azure Tagging
Microsoft Azure allows users to provide additional information for subscriptions via tags. A tag can, for example, contain the person responsible for a subscription so that she can be contacted in case of an incident. We developed an automated process which requests the [Hybrid Cloud Portal](https://cloudportal.henkelgroup.cloud/) every hour and tags all subscriptions and resource groups (if they are managed in the Hybrid Cloud Portal) with available information (see below for a list of tags we currently use). Please make sure that the information available in the Hybrid Cloud Portal is up-to-date and do not forget to update especially owners and e-mail addresses in case of a change of responsibility. Furthermore, please do not use one of the below mentioned tags for your own purposes because it will be overriden by our process every hour. If you are interested in the tags for a subscription, open the subscription's overview page in Microsoft Azure and select the section "Tags" on the left sidebar.

## Currently Used Tags
| Tag Name                | Description                                                                                            |
|-------------------------|--------------------------------------------------------------------------------------------------------|
| app-name                | Name of the app                                                                                        |
| app-id                  | ID of the app                                                                                          |
| bu                      | Business unit                                                                                          |
| environment             | Environment of the subscription, usually dev, test, or prod                                            |
| criticality             | Criticality of the subscription (currently empty but will be used in future)                           |
| responsible-email-group | An e-mail group we can contact in case of an incident                                                  |
| personal-owner-email    | The e-mail of the subscription's current owner                                                         |
| clarity-id              | Clarity code                                                                                           |
| creator                 | Person who initially requested the subscription                                                        |
| service-type            | Service type of the subscription, i.e., whether the subscription is managed by Skaylink or by yourself |
| ticket-state            | Status of the corresponding ticket in the Hybrid Cloud Portal                                          |
| cloud-portal-ticket     | A reference to the cloud portal ticket ID                                                              |