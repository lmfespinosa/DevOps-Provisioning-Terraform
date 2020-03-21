# StatusCake

## Introduction

StatusCake is a remote monitoring and logging platform. It is a monitoring and event platform that can be used when our system goes down and we need it to notify us and keep it under control in those cases.

## official Web Page

The official web page is:

https://www.statuscake.com/

## Script

You can find the script at:

[Script de integración  de Terraform con StatusCake](../../../../../Logs - StatusCake/StatusCake_Test.tf)

## Execution Steps

Before the scrit execution, ypu have to replace the next parameters into the script:

* statuscake_username
* statuskey_apikey

For have this requeriment, you have to go to the Web Page (https://www.statuscake.com/) and register your account.
Once Registerd, you should go to "User Panel" and check the parameters:

* statuscake_username:

![logo](https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/StatusCake/StatusCake_4.png)

* statuskey_apikey:

![logo](https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/StatusCake/StatusCake_5.png)

Once the script has been updated, we carry out the following steps:

1. Init the Terraform's Status with the next command:

```
terraform.exe init
```
![logo](https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/StatusCake/StatusCake_0.png)

2. Execute the provissioning command:
```
terraform.exe apply
```
![logo](https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/StatusCake/StatusCake_1.png)

3. confirm the plan (being a basic script has not been defined) and when initializing the state, Terraform has created a plan "by default" and awaits our confirmation, therefore, we confirm:
```
yes [ENTER]
```
![logo](https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/StatusCake/StatusCake_2.png )

4. Check in StatusCake page the result of the test:

![logo]( https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/StatusCake/StatusCake_3.png )
