# 🦻 UYARIY - Sistema de Gestión Audiológica (Admin Panel)

Este proyecto es una plataforma administrativa construida con **Ruby on Rails**, diseñada para gestionar el flujo operativo de un centro audiológico ("UYARIY").

El sistema centraliza la gestión de pacientes, audiólogos, inventario de audífonos y recomendaciones médicas mediante un panel de administración intuitivo y seguro.

## 🚀 Tecnologías Principales

* **Core:** Ruby 3.4 + Rails 8.1.1
* **Base de Datos:** PostgreSQL
* **Interfaz Administrativa:** ActiveAdmin
* **Autenticación:** Devise
* **Autorización (Seguridad):** CanCanCan
* **Búsqueda y Filtros:** Ransack
* **Estilos:** SassC

---

## 📊 Características del Panel

### 1. Dashboard (Tablero de Control)
Esto permite tener una vista centralizada para la toma de decisiones rápidas.
* **Métricas en tiempo real:** Contadores de pacientes, audiólogos y stock total.
* **Actividad Reciente:** Tabla con las últimas recomendaciones generadas para supervisión inmediata.
* **Alertas de Inventario:** Visualización del valor total del inventario (Precio * Stock).

### 2. Gestión de Inventario (Audífonos)
CRUD completo para el catálogo de productos.
* Campos detallados: Marca, Modelo, Precio, Especificaciones Técnicas y Stock.
* Validaciones de precio y formato de moneda.

### 3. Sistema de Recomendaciones
Esto permite supervisar las recomendaciones generadas por el sistema. Vincula a un **Paciente** con un **Audífono** específico.
* Estados de gestión: *Pendiente, Aprobado, Rechazado, Comprado*.
* Notas clínicas adjuntas a cada recomendación.

---

## 🔐 Arquitectura de Seguridad y Roles (RBAC)

La seguridad es la prioridad número uno de este sistema por eso utilizamos una estrategia de **Control de Acceso Basado en Roles (RBAC)** dividida en dos capas de protección: Autenticación (¿Quién eres?) y Autorización (¿Qué puedes hacer?).





### 👮‍♂️ Capa 1: El "Cadenero" (Authentication)
Gestionada por **Devise** y un controlador personalizado.
* El sistema verifica si el usuario está logueado.
* **Regla estricta:** Si un usuario con rol de `Patient` (Paciente) intenta acceder a `/admin`, el sistema lo **desconecta automáticamente (Sign Out)** y lo redirige al login. El panel es exclusivo para el personal interno.

### 🛡️ Capa 2: El "Guardia" (Authorization)
Gestionada por **CanCanCan**. Una vez dentro del panel, el sistema define qué botones y datos puede ver cada usuario según su nivel:

| Rol | Permisos | Descripción |
| :--- | :--- | :--- |
| 🔴 **Super Admin** | `can :manage, :all` | Acceso total. Puede crear, editar y borrar cualquier registro (Usuarios, Inventario, etc.). |
| 🟠 **Audiólogo** | `can :read, :all` | Acceso de solo lectura. Puede ver estadísticas, pacientes e inventario, pero **NO** tiene botones de editar ni eliminar. |
| 🟢 **Paciente** | `banned` | Acceso denegado al panel administrativo. |

---

## 🛠️ Instalación y Configuración Local

Sigue estos pasos para levantar el proyecto en tu máquina:

1.  **Clonar el repositorio:**
    ```bash
    git clone <url-del-repo>
    cd hastoreadmin
    ```

2.  **Instalar dependencias:**
    ```bash
    bundle install
    ```

3.  **Configurar la Base de Datos:**
    ```bash
    bin/rails db:create
    bin/rails db:migrate
    bin/rails db:seed  # (Opcional: carga datos de prueba)
    ```

4.  **Iniciar el Servidor:**
    ```bash
    bin/rails server
    ```

5.  **Acceso:**
    Abre tu navegador en `http://localhost:3000`. Serás redirigido automáticamente al login del admin.

---

## 👤 Credenciales por Defecto (Desarrollo)

Para ingresar por primera vez:

* **Usuario:** `admin@example.com`
* **Contraseña:** `password`

> **Nota:** Asegúrate de cambiar estas credenciales o crear un nuevo administrador en producción.

---

## 🐛 Solución de Problemas Comunes

**Error: "Ransack needs attributes explicitly allowlisted"**
Si ves este error, es porque Ransack (el buscador) requiere permisos explícitos en Rails 8. Revisa que tus modelos (`User.rb`, `HearingAid.rb`) tengan definido el método `self.ransackable_attributes`.

**Ciclo de Redireccionamiento (Redirect Loop)**
Si no puedes salir del login, borra las cookies de `localhost` o intenta en modo incógnito. Esto sucede si un usuario sin permisos intenta entrar y el sistema intenta redirigirlo infinitamente.