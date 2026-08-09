# Cambio Físico

Dashboard móvil de transformación física: racha, escáner de comida con IA, macros,
innegociables diarios, comparador de fotos y récords personales.

## Rutas

| Ruta | Qué es |
| --- | --- |
| `/` | Landing page |
| `/app` | El panel diario |
| `/api/analyze-food` | Visión: foto → desglose de ingredientes + macros |
| `/api/daily-suggestions` | 9 sugerencias (3 por comida) según los macros restantes |

## Arrancar

```bash
npm run dev
```

## IA (opcional)

Copia `.env.example` a `.env.local` y pon tu clave:

```bash
ANTHROPIC_API_KEY=sk-ant-...
```

Sin clave la app funciona igual: las dos rutas devuelven datos de demostración y la
UI lo marca como «modo demo». El modelo usado es `claude-opus-5` con
structured outputs, así que la respuesta siempre encaja con el esquema de
`src/lib/ai-schema.ts`.

## Datos

Todo se guarda en `localStorage` bajo la clave `cambiofisico.v1`. La persistencia
está aislada en `src/lib/store.ts` — para pasar a Supabase solo hay que
reimplementar `read`/`write` de ese módulo; ningún componente toca el
almacenamiento directamente.

Las fotos se comprimen antes de guardarse (máx. 1080 px, JPEG). Si `localStorage`
se llena, el store descarta automáticamente las fotos más antiguas.

## Diseño

- Mobile-first en todos los breakpoints; `sm:` en adelante solo ensancha.
- Glassmorphism cálido: la capa de luz vive en `AmbientBackground` (z-index −10) y
  todo lo demás la refracta. **`body` tiene fondo transparente a propósito** — un
  fondo opaco taparía esa capa.
- Los colores viven en variables CSS (`src/app/globals.css`). Los componentes usan
  `var(--…)` y las utilidades `g-line` / `g-fill` / `g-sunk`, así que cambiar la
  paleta es editar un solo archivo.
