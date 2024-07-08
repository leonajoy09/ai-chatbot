# What is Terraform?

Terraform is an opensource Infrastructure as code product
It can Automate your cloud Infrastructure and build one or many environments using Declarative Templates.

- [Terraform](https://www.terraform.io/)
- [Github](https://github.com/hashicorp/terraform)

## How is Terraform different from ARM Templates

First lets discuss the similarities both are Declarative type templates with key/value syntax
and both are executed in a similar manner. However Terraform is easier to read and has a functionality of state where your current infrastructure and desired infrastructure can be easily maintained depdending on your changing needs.

Also terraform has detailed plan execution that allows you to review your changes before executing them as to prevent any mishaps or cause any unplanned outages.

In addition Terraform supports other cloud vendors and different providers. More information can be found [here](https://www.terraform.io/docs/providers/index.html).

## How much is Terraform?

For basic use it is free however if you are looking to mature your development and build teams
then an Enterprise Licence can be added on for sharing complex workflows.

## Where can I download terraform

Terraform is supported on most OS such as Windows, OSX, or Linux 
you can download the binary as listed below or check your packaging documentation i.e. homebrew if you are on a Mac

- [Downloading terraform](https://www.terraform.io/downloads.html)
- [Homebrew terraform](https://formulae.brew.sh/formula/terraform)

## How do I get started?

Hashicorp Azure section has a great tutorial site to help you get started

- [Hashicorp Azure Tutorial](https://learn.hashicorp.com/terraform?track=azure#azure)

Also Microsoft on site has a tutorial page as well with some nice examples

- [Azure Tutorial](https://docs.microsoft.com/en-us/azure/developer/terraform/)

## Advanced Topics

- [Managing secrets in Terraform](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1)