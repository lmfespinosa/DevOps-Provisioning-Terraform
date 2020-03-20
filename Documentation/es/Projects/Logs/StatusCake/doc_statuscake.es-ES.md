# StatusCake

## Introducción

StatusCake es una plataforma de monitorización y de logs remota. Es una plataforma de monitorización y de eventos que puede usarse cuando nuestro sistema cae y necesitamos que en esos casos, nos avise y tenerlo controlado.

## Página oficial

La página oficial es:

https://www.statuscake.com/

## Script

La ruta del script del repositorio es:

[Script de integración  de Terraform con StatusCake](../../../../../Logs - StatusCake/StatusCake_Test.tf)

## Pasos de ejecución

Antes de la ejecución del scrit, deberemos de sustituir dentro del propio script los siguientes parámetros:

* statuscake_username
* statuskey_apikey

Para conseguir estos datos nos debemos dirigir a la página web (https://www.statuscake.com/) y registrarnos.
Una vez registrados, nos vamos al "User Panel" y obtenemos los datos:

* statuscake_username
[logo]: ../../../../../images/Projects/StatusCake/StatusCake_4.png "Username"

* statuskey_apikey
[logo]: ../../../../../images/Projects/StatusCake/StatusCake_5.png "key"

Una vez actualizado el script, efectuamos los siguientes pasos:

1. Inicializar el estado de Terraform

```
terraform.exe init
```
[logo]: ../../../../../images/Projects/StatusCake/StatusCake_0.png "Inicialización de estado"

2. Aplicamos el aprovisionamiento mediante el comando:
```
terraform.exe apply
```
[logo]: ../../../../../images/Projects/StatusCake/StatusCake_1.png "Inicio de provisionamiento"

3. Confirmamos el plan (al ser un script básico no se ha defindo) y al inicializar el estado, Terraform ha creado un plan "por defecto" y espera nuestra confirmación, por tanto, confirmamos:
```
yes [ENTER]
```
[logo]: ../../../../../images/Projects/StatusCake/StatusCake_2.png "Finalización del provisionamiento sin errores"

4. Verificamos en StatusCake el resultado de la prueba:
[logo]: ../../../../../images/Projects/StatusCake/StatusCake_3.png "Resultado OK de la prueba"





