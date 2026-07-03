Markdown
# 🚀 Proyecto InnovaTech - Evaluación 3 (Monorepo)

Bienvenido al repositorio central (Monorepo) de **InnovaTech**. Este proyecto consolida el código fuente de la aplicación web (Backend y Frontend), la automatización de despliegue continuo (CI/CD) y la Infraestructura como Código (IaC) en la nube de Amazon Web Services (AWS).

---

## 🛠️ Stack Tecnológico

El proyecto hace uso de las siguientes herramientas y servicios cloud:
* **Cloud Provider:** Amazon Web Services (AWS)
* **Infraestructura como Código (IaC):** HashiCorp Terraform
* **Orquestación:** Kubernetes (Amazon EKS)
* **Contenedores:** Docker & Amazon ECR (Elastic Container Registry)
* **CI/CD:** GitHub Actions
* **Redes:** AWS VPC, Internet Gateway, Load Balancers

---

## 📂 Estructura del Repositorio

El proyecto sigue una arquitectura de Monorepo estructurada de la siguiente manera:

* **`.github/workflows/`**: Pipelines de CI/CD para automatizar subidas a ECR.
* **`backend/`**: Código fuente de la API.
* **`frontend/`**: Código fuente de la interfaz web.
* **`infra/`**: Archivos `.tf` (Terraform) para crear la VPC y el clúster EKS.
* **`k8s/`**: Manifiestos YAML para desplegar la app en Kubernetes.
* **`README.md`**: Documentación principal del proyecto.

---

## ⚙️ Integración y Despliegue Continuo (CI/CD)

El proyecto cuenta con flujos automatizados usando **GitHub Actions**. 
Cada vez que se realiza un `push` a la rama `main` que modifique las carpetas `/backend` o `/frontend`, GitHub Actions se encarga automáticamente de:
1. Construir (Build) las nuevas imágenes de Docker.
2. Etiquetar las imágenes con `latest`.
3. Subir (Push) las imágenes al repositorio de **Amazon ECR** correspondiente.

---

## 🚀 Guía de Despliegue de Infraestructura y Aplicación

Para desplegar este proyecto desde cero, recomendamos utilizar **AWS CloudShell**, ya que cuenta con las herramientas de AWS CLI preinstaladas.

### 1. Preparar el entorno
Clonar el repositorio dentro de la terminal de AWS CloudShell:
```bash
git clone [https://github.com/BenjaminVerdejo/ep3-innovatech-monorepo.git](https://github.com/BenjaminVerdejo/ep3-innovatech-monorepo.git)
cd ep3-innovatech-monorepo
2. Aprovisionar la Infraestructura (Terraform)
Este paso construirá la red (VPC, Subredes Públicas/Privadas, Route Tables, Internet Gateway) y levantará el clúster de Amazon EKS (innovatech-cluster).

Bash
cd infra
terraform init
terraform apply -auto-approve
Nota: La creación del clúster de EKS y los nodos de trabajo (t3.medium) tomará aproximadamente entre 10 a 15 minutos.

3. Conectar el entorno a Kubernetes
Una vez que Terraform finalice y muestre Apply complete!, conectamos la terminal al nuevo clúster:

Bash
aws eks update-kubeconfig --region us-east-1 --name innovatech-cluster
4. Desplegar la Aplicación
Volvemos a la raíz del proyecto e inyectamos los manifiestos de Kubernetes para levantar el Backend y el Frontend:

Bash
cd ..
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml
5. Verificar y Obtener la URL Pública
Comprobamos que los contenedores estén funcionando correctamente (Running):

Bash
kubectl get pods
Finalmente, obtenemos la URL del balanceador de carga para acceder a la página web:

Bash
kubectl get svc innovatech-frontend-service
Copie la dirección mostrada en la columna EXTERNAL-IP y péguela en su navegador web para ver la plataforma de InnovaTech en funcionamiento.

🧹 Limpieza del Entorno (Destrucción)
Para evitar cobros innecesarios en AWS, una vez finalizadas las pruebas, destruya toda la infraestructura con el siguiente comando:

Bash
cd infra
terraform destroy -auto-approve
Desarrollado por: Benjamín Verdejo y Juaquin Tapia

Evaluación: Evaluación 3 - Infraestructura y Cloud
