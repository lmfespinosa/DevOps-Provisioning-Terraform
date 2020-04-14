# MEAN Infraestructura in AWS

## Introduction

This script will deploy a multilayer application with the MEAN stack. For this, the front-end services (NGINX and Node) will be deployed in the App1 instance and in the App2 instance the backend services (MongoDB).

In order for these instances to connect to the internet and be able to access the internet, a NAT Gateway will be implemented in which their routing tables will go to the internet Gateway.

Each instance will be subnetted, the front instance (App1), on a public subnet to publish the web service on port 80, and the backend instance (App2) on the private network so that it is protected.

## Scheme of infrastructure:

![logo](https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/AWS/MEAN_infrastructure/MEAN_AWS_0.png)

## Script

You can find the script at:

[Script de despliegue de infraestructura MEAN con Terraform en AWS](../../../../../AWS - MEAN infrastructure/)

Each of them is detailed below:
* Files:
    * Static / webnode:
        * Example.js.tpl -> Example web page template in nodejs.
    * Templates /
        * Mongodb:
            * Mongod.service -> Contains the desired configuration of the MongoDB database.
        * nginx:
            * Nginx.conf.tpl -> Contains the desired nginx configuration template.
* Keys:
    * Prod_key -> private key.
    * Prod_key.plub -> public key
* Scrips:
    * Config_app1.sh -> node installation script, npm and build-essential and preparation of the web environment.
* Gateway.tf -> definition of the gateway that controls access to the two subnets (public and private), as well as route tables and their permissions.
* Os_ami_app1.tf -> Image definition for machine app1 (Front).
* Os_ami_app2.tf -> Definition of the image for the app2 machine (DataBase).
* Provider.tf -> Definition of the AWS provider and its credentials.
* Resources_app1.tf -> Definition of the instance app1 (Front) as well as the provisioning of the script.
* Resources_app2.tf -> Definition of the instance app2 (Database) as well as the provisioning of the script.
* Security_groups_app1.tf -> Definition of the security policies of the App1 instance.
* Security_groups_app2.tf -> Definition of the security policies of the App2 instance.
* Subnet_private_app2.tf -> Definition of the private subnet resource.
* Subnet_public_app1.tf -> Definition of the subnet public resource.
* Vars.tf -> Definition of variables used in the script.
* Version.tf -> Definition of the minimum version of Terraform to run the scrip.
* VPC.tf -> Definition of the VPC resource.

As previously discussed, the global script is made up of a series of files, bash scripts and a json file, in which the script is launched.

The aws_mean.json file has the following parts and steps (in the order shown):

* Variables: We define the variables that will be used in the script.
* Builders: Construction of the machine in AWS with the desired specifications.
* Provisioners: Part of the scriot that is executed to provision the pertinent actions once the building process has finished.

The scrip follows a series of guidelines. The following is the provisioning steps that are carried out once the builder is finished:

1. Create folder for files
2. Create folder for web
3. Upload web file
4. Upload nginx configuration file
5. Run node installation script
6. Run nginx install script
7. Run web environment setup script

## Execution steps:

Before the scrit execution, you have to replace the next parameters into the script (vars.tf):

* access_key
* secret_key

Once the script has been updated, we carry out the following steps:

1. Init the Terraform's Status with the next command:

```
terraform.exe init
```

2. Execute the provissioning command:
```
terraform.exe apply
```

3. confirm the plan (being a basic script has not been defined) and when initializing the state, Terraform has created a plan "by default" and awaits our confirmation, therefore, we confirm:
```
yes [ENTER]
```

