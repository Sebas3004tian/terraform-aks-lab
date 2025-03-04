# terraform-aks-lab


Sebastian Lopez Garcia A00377582

## Introducción al Laboratorio de Terraform con Kubernetes
En este laboratorio, trabajaremos con Terraform para la gestión de infraestructura como código, utilizando kubectl para interactuar con un clúster de Kubernetes. El objetivo principal será desplegar un pod con Nginx y visualizarlo a través de Lens Desktop, una herramienta gráfica que facilita la administración de clústeres Kubernetes.

Instalacion de az-cli:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
sudo apt-get update
sudo apt-get install azure-cli
```







Es fundamental autenticarse en Microsoft Azure para gestionar los recursos desde Terraform y Kubernetes. Utilizaremos el comando az login de la Azure CLI para autenticar nuestra sesión y obtener acceso a la suscripción donde desplegaremos nuestro entorno.
Despues de estos pasos, ya tendríamos Az-cli:
![image](https://github.com/user-attachments/assets/e206e8a1-da9c-4a81-9fa7-3ce09443a14a)

 

Proveedor de Azure
![image](https://github.com/user-attachments/assets/4be203d6-93d5-4a6d-b02b-55bcaab4276a)

 
Este bloque define el proveedor de Azure Resource Manager (`azurerm`). El bloque `features {}` es necesario pero puede estar vacío.

Grupo de Recursos
![image](https://github.com/user-attachments/assets/71ebc447-3910-47e3-8b7b-43cc592a9fbd)

 
Este bloque crea un grupo de recursos en Azure llamado `labs_plataformas_rg` en la ubicación `East US`.

Cluster de Kubernetes
 ![image](https://github.com/user-attachments/assets/0aea67a1-5d1c-4b33-b56e-ac6bf5048934)

Este bloque crea un clúster de Kubernetes en Azure (AKS) llamado `sl-aks1`. Aquí están los detalles:
- `location` y `resource_group_name` se refieren al grupo de recursos creado anteriormente.
- `dns_prefix` es el prefijo DNS para el clúster.
- `default_node_pool` define el grupo de nodos por defecto con un solo nodo (`node_count = 1`) y un tamaño de máquina virtual `Standard_D2_v2`.
- `identity` establece que el clúster usará una identidad administrada por el sistema (`SystemAssigned`).
- `tags` añade una etiqueta para identificar el entorno como "testings".

Salidas
![image](https://github.com/user-attachments/assets/aec8bf28-c239-44b8-8d20-8beee3e99d4b)

 Estos bloques de salida (`output`) exponen información sensible del clúster de Kubernetes:
- `client_certificate` expone el certificado del cliente del clúster.
- `kube_config` expone la configuración completa del clúster en formato raw.
Ambos valores están marcados como `sensitive = true` para evitar que se muestren en los registros de salida de Terraform.

El siguiente paso es preparar Terraform para desplegar nuestra infraestructura. Primero, utilizamos el comando terraform init, que se encarga de inicializar el entorno de trabajo. Esto incluye la descarga de los proveedores necesarios y la configuración del backend donde se almacenará el estado de la infraestructura. Sin este paso, no podríamos ejecutar ninguna acción con Terraform.
![image](https://github.com/user-attachments/assets/8cc04efe-e334-489e-9a94-e67bb81d2c0e)
![image](https://github.com/user-attachments/assets/99faa70a-c4b2-466a-84e7-319f4c982aff)

 
 
Finalmente, aplicamos los cambios con terraform apply, que se encarga de crear o modificar la infraestructura según lo definido en los archivos de Terraform. Este comando genera un plan de ejecución y, tras la confirmación, procede a desplegar los recursos en Azure. Con esto, nuestra infraestructura queda lista para su uso.
![image](https://github.com/user-attachments/assets/303b6c23-733d-470f-b4db-af7810570845)

 


Una vez que hemos ejecutado terraform apply, podemos verificar que nuestro pod con Nginx está en ejecución dentro de Azure. Para ello, utilizamos kubectl, el cual nos permite interactuar con el clúster de Kubernetes. Con el comando kubectl get pods, podemos ver el estado de los pods y asegurarnos de que están en estado Running. También podemos inspeccionar los servicios con kubectl get services, lo que nos mostrará si la IP externa ha sido asignada correctamente.
 ![image](https://github.com/user-attachments/assets/158f89c5-19cc-4f1b-b4a6-62c932aa54fe)

 ![image](https://github.com/user-attachments/assets/d6b63499-1cd6-4267-ba98-84f1491cf487)

 ![image](https://github.com/user-attachments/assets/db8aa242-117e-4bed-9890-b452faf97ede)

Para acceder a la página web servida por Nginx, utilizamos la dirección IP pública asignada al servicio. Esto nos permitirá visualizar la página de bienvenida de Nginx y confirmar que el despliegue se realizó con éxito. 
![image](https://github.com/user-attachments/assets/a9618fa0-44cf-456c-822e-64966e6fa838)




Finalmente, podemos utilizar Lens Desktop para administrar visualmente nuestro clúster. Lens nos proporciona una interfaz gráfica donde podemos ver los pods, servicios y otros recursos desplegados en Kubernetes. Para conectarnos, añadimos el clúster a Lens utilizando el archivo kubeconfig, lo que nos permitirá monitorear el estado del sistema, revisar logs y gestionar los recursos de una manera más intuitiva.
![image](https://github.com/user-attachments/assets/16ec728e-6652-4a34-98be-6aa54ccc2684)
![image](https://github.com/user-attachments/assets/d9cc8663-ad83-444e-b29b-d7b58fd65ec5)
![image](https://github.com/user-attachments/assets/18a8b3ae-5c1a-4ee9-b940-2a35df739145)

 
