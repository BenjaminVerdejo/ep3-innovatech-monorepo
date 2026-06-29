# Proyecto DevOps - Backend API

## Arquitectura y Docker Compose (IE2)
El entorno multi-contenedor está compuesto por 4 servicios esenciales:
1. `db`: Base de datos PostgreSQL (Imagen optimizada Alpine).
2. `ventas-service`: API REST para la gestión de ventas.
3. `despachos-service`: API REST para el control de despachos.
4. `auth-service`: Servicio de autenticación.

## Justificación de Persistencia de Datos (IE3)
Para el servicio de la base de datos (`db`), se definió explícitamente un **Named Volume** (`db_data`) en lugar de un *Bind Mount*.
* **Independencia del Host:** Los Named Volumes son gestionados completamente por el motor de Docker. Esto garantiza que si el proyecto se despliega en Windows (Local) o en Ubuntu (AWS EC2), los datos se guardarán de forma idéntica sin romper rutas absolutas de carpetas.
* **Rendimiento:** En sistemas Linux (como la instancia EC2), los volúmenes nativos de Docker tienen un rendimiento de lectura/escritura superior al mapeo directo de carpetas del sistema de archivos del host.