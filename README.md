# Cambio Físico

Dashboard móvil de transformación física para dos personas (David y Sabina):
racha, escáner de comida con IA, macros, innegociables diarios y récords
personales.

## Rutas

| Ruta | Qué es |
| --- | --- |
| `/` | Landing: elige perfil y ve lo que cada uno lleva hecho y le queda hoy |
| `/david`, `/sabina` | El panel diario de cada uno |
| `/api/analyze-food` | Visión: foto → desglose de ingredientes + macros |
| `/api/daily-suggestions` | 9 sugerencias (3 por comida) según los macros restantes |

Los perfiles se declaran en `src/lib/profiles.ts` (nombre, foto, color de
acento) y la ruta `/[perfil]` se prerenderiza para cada uno con
`generateStaticParams`.

## Arrancar

```bash
npm run dev
```

## IA (opcional)

Copia `.env.example` a `.env.local` y pon tu clave:

```bash
ANTHROPIC_API_KEY=sk-ant-...
```

Sin clave la app funciona igual: las dos rutas devuelven datos de demostración y
la UI lo marca como «modo demo». El modelo es `claude-opus-5` con structured
outputs, así que la respuesta siempre encaja con el esquema de
`src/lib/ai-schema.ts`.

## Datos

**Un store por perfil**, en `localStorage`, bajo `cambiofisico.v1.<perfil>`.
David y Sabina no comparten nada: ni racha, ni comidas, ni objetivos, y el reset
de Ajustes solo borra el perfil activo.

La persistencia está aislada en `src/lib/store.ts` — para pasar a Supabase solo
hay que reimplementar `read`/`write` de ese módulo; ningún componente toca el
almacenamiento directamente. Dentro del panel, `ProfileProvider`
(`src/components/profile-context.tsx`) inyecta el estado, las acciones y las
variables de acento del perfil activo.

Las fotos de las comidas se comprimen antes de guardarse (máx. 1024 px, JPEG).

## Fotos de perfil

`public/perfiles/*.png` son recortes sin fondo generados **en local** desde los
originales de estudio. Cada persona tiene dos: el busto (tarjeta de la landing)
y un cuadrado encuadrado en la cabeza (avatar de la barra superior).

```bash
node scripts/cutout.mjs <foto.jpg> public/perfiles/<n>.png        1400 bust
node scripts/cutout.mjs <foto.jpg> public/perfiles/<n>-avatar.png  512 avatar
```

El script hace flood fill del fondo desde el borde (así los dientes y el logo
blanco de la camiseta no se borran, porque no conectan con el marco) y calcula
un alfa parcial en el pelo, des-premultiplicando el blanco para que no quede
halo. No sube nada a ningún servicio.

Dos cosas que hay que respetar al usarlas:

- El avatar se recorta **en el script**, no con `object-cover` + un `scale` a
  ojo en CSS. Eso último cortaba la coronilla.
- `sizes` en `next/image` tiene que ir acorde al tamaño real de render (×2 para
  pantallas densas). Un `sizes="104px"` sirve un PNG de 104 px y se ve borroso.

## Diseño

- Mobile-first en todos los breakpoints; `sm:` en adelante solo ensancha.
- **Base neutra, color solo donde informa.** Superficies y texto son grises
  neutros; el color queda para los datos (proteína verde, calorías naranja,
  agua azul), los estados (verde hecho, rojo peligro) y el acento de cada
  persona. Si algo decorativo lleva color, sobra.
- Glassmorphism limpio: la capa de luz vive en `AmbientBackground` (z-index −10)
  y todo lo demás la refracta. **`body` tiene fondo transparente a propósito** —
  un fondo opaco taparía esa capa.
- Los colores viven en variables CSS (`src/app/globals.css`). Los componentes
  usan `var(--…)` y las utilidades `g-line` / `g-fill` / `g-sunk`, así que
  cambiar la paleta es editar un solo archivo. `--accent` lo sobrescribe cada
  perfil, así que los botones primarios salen rojos para David y azules para
  Sabina sin tocar nada más.
