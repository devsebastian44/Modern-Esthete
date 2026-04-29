# Modern Esthete

![Next.js](https://img.shields.io/badge/Next.js-16-black?style=flat&logo=next.js)
![TypeScript](https://img.shields.io/badge/TypeScript-5-blue?style=flat&logo=typescript)
![Tailwind CSS](https://img.shields.io/badge/TailwindCSS-4.x-38B2AC?style=flat&logo=tailwind-css)
![Prisma](https://img.shields.io/badge/Prisma-6-2D3748?style=flat&logo=prisma)
![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-3ECF8E?style=flat&logo=supabase)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?style=flat&logo=github-actions&logoColor=white)

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
- **Testing** configurado con Vitest para pruebas unitarias y E2E.

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

## 🧪 Testing

Para ejecutar los tests funcionales de la aplicación:

```bash
npm run test
```

Los tests se ejecutan en un entorno seguro local o de CI, utilizando una base de datos mockeada mediante variables de entorno sintéticas, por lo que no requieren conexión a la base de datos de producción.

---

## 🤝 Contributing

¡Las contribuciones son bienvenidas! Para colaborar:

1. Haz un **Fork** del repositorio.
2. Crea una rama para tu feature (`git checkout -b feature/nueva-caracteristica`).
3. Haz **Commit** de tus cambios siguiendo [Conventional Commits](https://www.conventionalcommits.org/).
4. Sube tu rama (`git push origin feature/nueva-caracteristica`).
5. Abre un **Pull Request**.

Asegúrate de que los tests y el linter pasen correctamente antes de enviar tu PR. El pipeline de CI/CD (GitHub Actions) validará tus cambios automáticamente.

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
- **SAST con Semgrep** para análisis estático de seguridad continuo.

> ⚠️ Para despliegues en producción, asegúrate de rotar el `NEXTAUTH_SECRET`, usar variables de entorno cifradas, y configurar correctamente las políticas RLS en Supabase antes de exponer la aplicación públicamente.

---

## 🚀 Roadmap

Basado en el análisis de la arquitectura actual del código, estas son las mejoras técnicas sugeridas:

- [ ] Implementar paginación y filtros avanzados en el catálogo de productos
- [ ] Integrar un proveedor de pagos (Stripe o similar) con webhooks seguros
- [ ] Añadir caching con `unstable_cache` de Next.js o Redis para consultas frecuentes
- [ ] Expandir cobertura de tests unitarios y E2E (Playwright)
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