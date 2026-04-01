# Contribuir a Modern Esthete

¡Gracias por tu interés en contribuir! Este documento proporciona guías para los contribuidores.

## Primeros Pasos

1. Fork del repositorio
2. Clona tu fork: `git clone https://github.com/tuusuario/modern-esthete.git`
3. Instala dependencias: `npm install`
4. Crea una rama de feature: `git checkout -b feature/caracteristica-increible`

## Configuración de Desarrollo

```bash
# Instalar dependencias
npm install

# Configurar variables de entorno
cp .env.example .env.local

# Ejecutar migraciones de base de datos
npx prisma migrate dev

# Iniciar servidor de desarrollo
npm run dev
```

## Estilo de Código

- Usa TypeScript para todo el código nuevo
- Sigue la configuración de ESLint
- Usa Prettier para formateo
- Escribe mensajes de commit significativos
- Agrega pruebas para nuevas características

## Proceso de Pull Request

1. Actualiza el README.md con detalles de los cambios si aplica
2. Asegúrate de que la descripción de tu PR describa claramente el problema y la solución
3. Enlaza cualquier issue relevante
4. Espera la revisión del código

## Pruebas

```bash
# Ejecutar pruebas
npm test

# Ejecutar linting
npm run lint

# Verificación de tipos
npm run type-check
```

## Seguridad

Este es un proyecto de portafolio para demostración de habilidades técnicas.
