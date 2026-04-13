# Modern Esthete

![Next.js](https://img.shields.io/badge/Next.js-16-black?style=flat&logo=next.js)
![TypeScript](https://img.shields.io/badge/TypeScript-5-blue?style=flat&logo=typescript)
![Tailwind CSS](https://img.shields.io/badge/TailwindCSS-4.x-38B2AC?style=flat&logo=tailwind-css)
![Prisma](https://img.shields.io/badge/Prisma-6-2D3748?style=flat&logo=prisma)
![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-3ECF8E?style=flat&logo=supabase)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=flat&logo=docker)

---

## 🧠 Overview

Modern Esthete es una aplicación web full-stack de comercio electrónico construida con Next.js 16 y el App Router. El proyecto implementa un ecosistema completo de tienda en línea con autenticación segura de usuarios, gestión de sesiones y persistencia de datos mediante una base de datos PostgreSQL administrada a través de Prisma ORM y Supabase como proveedor cloud.

Este proyecto sigue una arquitectura de tipo serverless/edge: la lógica del servidor se ejecuta directamente a través de Server Actions y API Routes de Next.js, sin necesidad de un backend desacoplado independiente. El stack es completamente tipado en TypeScript y orientado a producción, con soporte para containerización mediante Docker.

---

## ⚙️ Features

- **Autenticación de usuarios** mediante Auth.js v5 (NextAuth Beta), con manejo seguro de sesiones y middleware de protección de rutas.
- **Gestión de contraseñas** con hash seguro usando `bcryptjs`.
- **Validación de datos** estricta en todas las entradas mediante esquemas `Zod`.
- **ORM tipado** con Prisma v6 para interacciones seguras y declarativas con la base de datos PostgreSQL.
- **Integración con Supabase** para lógica de base de datos en la nube con Row Level Security (RLS).
- **Interfaz de usuario moderna** construida con componentes React 19 y `lucide-react` como librería de iconografía.
- **Estilizado responsivo** con Tailwind CSS 4.x mediante PostCSS.
- **Soporte de contenedores** con Dockerfile multi-stage optimizado y `docker-compose.yml` para entorno local completo.
- **Pipeline de publicación automatizado** con script PowerShell para sincronización entre repositorios privado/público.
- **Testing** configurado con Vitest para pruebas unitarias (pipeline completo disponible en GitLab).

---

## 🛠️ Tech Stack

| Capa | Tecnología |
|------|-----------|
| Framework | Next.js 16 (App Router, Server Actions, Middleware) |
| Lenguaje | TypeScript 5 |
| UI | React 19 + lucide-react |
| Estilos | Tailwind CSS 4.x + PostCSS |
| ORM | Prisma v6 |
| Base de Datos | PostgreSQL 15 (Supabase / Docker local) |
| Autenticación | Auth.js v5 (NextAuth Beta) |
| Validación | Zod v4 |
| Seguridad de contraseñas | bcryptjs |
| Contenerización | Docker + Docker Compose |
| Testing | Vitest |
| Linting / Formato | ESLint 9 + Prettier |
| Runtime Node | Node.js 20 (LTS) — fijado en `.nvmrc` |

---

## 📦 Installation

### Prerrequisitos

- Node.js `>=20` (recomendado con `nvm`)
- npm `>=10`
- Docker y Docker Compose (opcional para entorno local containerizado)
- Cuenta en [Supabase](https://supabase.com) o instancia PostgreSQL local

### 1. Clonar el repositorio

```bash
git clone https://github.com/devsebastian44/Modern-Esthete.git
cd Modern-Esthete
```

### 2. Instalar dependencias

```bash
nvm use        # Usa la versión de Node definida en .nvmrc
npm install
```

### 3. Configurar variables de entorno

Crea un archivo `.env.local` en la raíz del proyecto con las siguientes variables:

```env
DATABASE_URL="postgresql://usuario:password@host:5432/modern_esthete"
DIRECT_URL="postgresql://usuario:password@host:5432/modern_esthete"

NEXTAUTH_SECRET="tu_secreto_seguro"
NEXTAUTH_URL="http://localhost:3000"

NEXT_PUBLIC_SUPABASE_URL="https://tu-proyecto.supabase.co"
NEXT_PUBLIC_SUPABASE_ANON_KEY="tu_anon_key"
```

### 4. Inicializar la base de datos

```bash
npx prisma generate
npx prisma db push
```

---

## ▶️ Usage

### Modo desarrollo

```bash
npm run dev
```

Accede a la aplicación en `http://localhost:3000`.

### Build de producción

```bash
npm run build
npm run start
```

### Con Docker (entorno completo local)

```bash
docker-compose up --build
```

Esto levanta dos servicios:
- `app`: la aplicación Next.js en el puerto `3000`
- `postgres`: base de datos PostgreSQL 15 en el puerto `5432`

---

## 📁 Project Structure

```
Modern-Esthete/
├── src/                        # Código fuente principal
│   └── app/                    # App Router de Next.js (páginas, layouts, API routes)
├── prisma/                     # Schema de base de datos y migraciones (Prisma)
│   └── schema.prisma
├── public/                     # Assets estáticos servidos directamente
├── diagrams/                   # Diagramas arquitectónicos del sistema
├── docs/                       # Documentación interna (guías de contribución)
├── Dockerfile                  # Imagen Docker multi-stage optimizada para producción
├── docker-compose.yml          # Orquestación local: app + PostgreSQL
├── next.config.ts              # Configuración del framework Next.js
├── tsconfig.json               # Configuración de TypeScript
├── eslint.config.mjs           # Reglas de linting
├── prettier.config.js          # Formato de código
├── postcss.config.mjs          # Procesador CSS para Tailwind
├── .nvmrc                      # Versión de Node.js fijada (v20)
├── publish_public.ps1          # Script DevSecOps de sincronización GitHub ↔ GitLab
└── package.json                # Dependencias y scripts npm
```

---

## 🔐 Security

Este proyecto incorpora múltiples capas de seguridad a nivel de aplicación, base de datos e infraestructura:

- **Row Level Security (RLS)** en Supabase: las políticas de acceso están definidas directamente en la base de datos PostgreSQL, garantizando que cada usuario solo acceda a sus propios datos incluso si hay vulnerabilidades en la capa de aplicación.
- **Validación estricta de entradas** con Zod en todas las Server Actions y endpoints API, previniendo inyecciones y datos malformados.
- **Hash de contraseñas** con `bcryptjs`, nunca almacenadas en texto plano.
- **Middleware de autenticación** con Auth.js v5 protegiendo rutas sensibles a nivel de servidor.
- **Docker hardening**: el servicio `postgres` en Docker Compose corre con `no-new-privileges:true`, sistema de archivos `read_only` y `tmpfs` para directorios temporales.
- **Arquitectura dual de repositorios**: los archivos de configuración de infraestructura, scripts CI/CD, dotfiles sensibles y datos de prueba se mantienen exclusivamente en el repositorio privado de GitLab, distribuyéndose al público únicamente el código de presentación mediante el script `publish_public.ps1`.
- **SAST con Semgrep** integrado en el pipeline GitLab CI/CD para análisis estático de seguridad en cada commit interno.

> ⚠️ Para despliegues en producción, asegúrate de rotar el `NEXTAUTH_SECRET`, usar variables de entorno cifradas, y configurar correctamente las políticas RLS en Supabase antes de exponer la aplicación públicamente.

---

## 🌐 Repository Architecture

Este proyecto sigue una arquitectura distribuida de repositorios con enfoque DevSecOps:

- **GitHub**: Presentación pública y portafolio — contiene el código fuente principal sanitizado, documentación técnica y diagramas de arquitectura.
- **GitLab**: Laboratorio de desarrollo completo — contiene la implementación íntegra con pipelines CI/CD, infraestructura de testing, configuraciones sensibles y scripts de automatización avanzados.

### 🔗 Full Source Code

👉 Código completo disponible en GitLab: [https://gitlab.com/group-programming-lab/Modern-Esthete](https://gitlab.com/group-programming-lab/Modern-Esthete)

---

## 🚀 Roadmap

Basado en el análisis de la arquitectura actual del código, estas son las mejoras técnicas sugeridas:

- [ ] Implementar paginación y filtros avanzados en el catálogo de productos
- [ ] Integrar un proveedor de pagos (Stripe o similar) con webhooks seguros
- [ ] Añadir caching con `unstable_cache` de Next.js o Redis para consultas frecuentes
- [ ] Expandir cobertura de tests unitarios y E2E (Playwright) en el pipeline GitLab
- [ ] Implementar sistema de roles (admin / cliente) a nivel de middleware y RLS
- [ ] Añadir gestión de imágenes de productos con Supabase Storage
- [ ] Configurar monitoreo de errores en producción (Sentry o similar)
- [ ] Migrar a versión estable de Auth.js cuando salga de beta

---

## 📄 License

Este proyecto está bajo la licencia **MIT**.

> Licencia detectada directamente desde el archivo `LICENSE` en la raíz del repositorio.

Puedes usar, copiar, modificar y distribuir este software libremente, siempre que se incluya el aviso de copyright original.

---

## 👨‍💻 Author

**Sebastian** — [@devsebastian44](https://github.com/devsebastian44)

Desarrollador full-stack con enfoque en aplicaciones web modernas, arquitecturas DevSecOps y buenas prácticas de ingeniería de software.

🌐 Demo en producción: [modernesthete.vercel.app](https://modernesthete.vercel.app)