# Infraestructura MEAN en AWS

## Introducción

Este script en terraform va a desplegar una aplicación en multicapa con el stack MEAN. Para ello se va a desplegar en la instancia App1 los servicios de frontal (NGINX y Node) y en la instancia App2 los servicios de backend (MongoDB).

Para que dichas instancias puedan conectarse a internet y poder acceder a internet, se implementará una NAT Gateway en la cual sus tablas de enrutamiento irán al internet Gateway.

Cada instancia estará en subred, la instancia de front (App1), en una subred pública para publicar el servicio web por el puerto 80, y la instancia de backend (App2) en la red privada para que esté protegida.

## Esquema

![logo](https://raw.githubusercontent.com/lmfespinosa/DevOps-Provisioning-Terraform/master/Documentation/images/Projects/AWS/MEAN_infrastructure/MEAN_AWS_0.png)

## Script

La ruta del script del repositorio es:

[Script de despliegue de infraestructura MEAN con Terraform en AWS](../../../../../AWS - MEAN infrastructure/)

A continuación se detalla cada uno de ellos:
* Files:
    * Static/webnode:
        * Example.js.tpl -> Template de página web de ejemplo en nodejs.
    * Templates/
        * Mongodb:
            * Mongod.service -> Contiene la configuración deseada de la base de datos MongoDB.
        * nginx:
            * Nginx.conf.tpl -> Contiene el template de configuración deseada de nginx.
* Keys:
    * Prod_key -> clave privada.
    * Prod_key.plub -> clave pública
* Scrips:
    * Config_app1.sh -> script de instalación de node, npm y build-essential y preparación del entorno web.
* Gateway.tf -> definición de la pasarela que controla el acceso a las dos subredes (pública y privada), así como tablas de ruta y sus permisos.
* Os_ami_app1.tf -> Definición de la imagen para la máquina app1 (Front).
* Os_ami_app2.tf -> Definición de la imagen para la máquina app2 (DataBase).
* Provider.tf -> Definición del provider de AWS y sus credenciales.
* Resources_app1.tf -> Definición de la instancia app1 (Front) así como el aprovisionamiento del script.
* Resources_app2.tf -> Definición de la instancia app2 (Database) así como el aprovisionamiento del script.
* Security_groups_app1.tf -> Definición de las políticas de seguridad de la instancia App1.
* Security_groups_app2.tf -> Definición de las políticas de seguridad de la instancia App2.
* Subnet_private_app2.tf -> Definición del recurso subnet private.
* Subnet_public_app1.tf -> Definición del recurso subnet public.
* Vars.tf -> Definición de variables usadas en el script.
* Versión.tf -> Definición de la versión mínima de Terraform para ejecutar el scrip.
* VPC.tf -> Definición del recurso VPC.

Como se ha comentado anteriormente, el script global está compuesto por una serie de ficheros, scripts bash y un fichero json, en el que se lanza la secuencia de comandos.

El fichero aws_mean.json, dispone de las siguientes partes y pasos (en el orden expuesto):

* Variables: Definimos las variables que serán usadas en el script.
* Builders: Construcción de la maquina en AWS con las especificaicones deseadas.
* Provisioners: Parte del scriot que se ejecuta para provisionar las acciones pertinentes una vez finalizado el proceso de building.

El scrip sigue una serie de pautas. A continuación, se expone los pasos de provisionamiento que se efectúa una vez finalizado el builder:

1.	Crear folder para ficheros
2.	Crear folder para web
3.	Subir fichero web
4.	Subir fichero configuración nginx
5.	Ejecutar script instalación node
6.	Ejecutar script instalación nginx
7.	Ejecutar script preparación entorno web


## Pasos de ejecución

Antes de la ejecución del scrit, deberemos de sustituir dentro del propio script (fichero vars.tf) los siguientes parámetros:

* access_key
* secret_key

Una vez actualizado el script, efectuamos los siguientes pasos:

1. Inicializar el estado de Terraform

```
terraform.exe init
```

2. Aplicamos el aprovisionamiento mediante el comando:
```
terraform.exe apply
```

3. Confirmamos el plan (al ser un script básico no se ha defindo) y al inicializar el estado, Terraform ha creado un plan "por defecto" y espera nuestra confirmación, por tanto, confirmamos:
```
yes [ENTER]
```







