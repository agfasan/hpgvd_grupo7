# Infraestrucura Chess stats

El archivo main.tf contiene el codigo (IaaC) para crear la arquitectura necesaria para montar el sericio de Chess Stats en AWS. Este contiene los siguientes elementos:

1. Bucket S3 llamado RAW DATA.
2. Bucket S3 llamado CURATED.
3. Base de datos PostgreSQL (Llevara el registro de usuarios,  actividad y valoración de la recomendación)
4. Base de datos MongoDB (Donde guardaremos los resultados del modelo)
5. Una instancia de AWS Redshift para dar soporte analítico a la toma de decisiones.
6. AWS Glue Catalog y AWS Glue Connection para conectar AWS Athena a la instancia de AWS Redshift.

## Pasos a seguir

1. Instalar Terraform en la pc local y tener configuradas las credenciales de AWS (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`.).

2. Definir los usuarios y contraseñas de PostgreSQL, MongoDB y AWS Redshift.

3. Descargar de github el repositorio con el codigo en Terraform para crear la infraesturctura y posicionar se la carpeta infraestructura:

   ```
   git clone https://github.com/<your-username>/terraform-aws-example.git
   cd infraestructura
   ```

4. Inicializar Terraform:

   ```
   terraform init
   ```

5. Revisar la salida y verificar que todos los recursos estén configurados correctamente

   ```
   terraform plan
   ```

   Revise la salida y asegúrese de que todos los recursos estén configurados correctamente.

6. Aplicar los cambios de Terraform y luego confirmar cuando se solicite. Esto creará los recursos a utilizar definidos en el archivo main.tf

   ```
   terraform apply
   ```

7. Verificar los outputs del paso anterior.