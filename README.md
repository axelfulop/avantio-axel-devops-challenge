# avantio-axel-devops-challenge
Devops challenge

## Comentarios
  El proyecto está dividido en carpetas:
  
  ### Terraform:
  
  * Contiene el código de la infraestructura como código. 
  
  * Cada subcarpeta representa la región de implementación, y dentro de ellas, hay subcarpetas adicionales para elegir el entorno.
  
  * Elegí este enfoque para separar los entornos por cuentas, facilitando la lectura y comprensión del código.
  
  * El estado de Terraform se guarda en un S3 y se crea una tabla Dynamo para bloquear el estado en caso de trabajar simultáneamente.
  
  * Otros enfoques válidos podrían incluir el uso de Terragrunt, TF Cloud o los espacios de trabajo de Terraform.

### Tarea 1:
Dentro de la carpeta raíz, se encuentra el script deploy.sh.

Debe tener configuradas sus credenciales de AWS en ~/.aws/credentials para ejecutarlo => sh deploy.sh PROFILE ENV REGION
Para este ejemplo, asumimos que su PROFILE es avantio y que queremos implementar en el norte de Virginia en dev...

1) Ejecute el siguiente comando sh deploy.sh avantio dev us-east-1, luego elija la opción 1. Esto creará el S3 y la base de datos DynamoDB donde se almacenan los estados y los identificadores de bloqueo de estado.
2) Una vez ejecutado el apply, puede elegir la opción dos, que implementará la red, EKS y SQS.
3) Luego, puede eliminar los recursos con terraform destroy sobre la carpeta dev.

### Tarea 2: 

1) En este punto traté de utilizar la metodología keep it simple
2) Tuve que agregar babel types al package json de la app ya que faltaba agregarlo para poder correr la app
3) Para crear los charts de Helm utilice un helper que ayuda a la redudancia y repeticiôn de codigo
4) El pipeline fue creado en Jenkins, el cual me permite testearlo localmente, pero hubiese utilizado ArgoCI. Se deben configurar los secretos y el SCM.

Se pueden hacer algunas mejoras como optimizar el tiempo con la cache, paralelismo, self runners pero quería dejarlo simple

### Tarea 3:
