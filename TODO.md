# Qué le falta a Cambio Físico

Estado a 9 de agosto de 2026. Ordenado por lo que más duele si no se hace.

---

## P0 · Riesgo de perder cosas

- [ ] **Poner el proyecto en git.** Ahora mismo no hay repositorio: la única
      copia es la carpeta de OneDrive. Un `git init` + commit inicial y, si
      quieres, un repo privado en GitHub.
- [ ] **Exportar / importar datos.** Todo vive en `localStorage`. Si limpias el
      navegador, cambias de móvil o entras en incógnito, se pierde la racha y
      los PRs. Un botón «Descargar copia» (JSON) e «Importar» en Ajustes es
      media hora y quita el miedo.
- [ ] **Decidir el backend.** Es la decisión que quedó abierta. Mientras no
      exista, tu móvil y tu portátil son dos apps distintas, y Sabina y tú no
      podéis veros el progreso desde vuestros propios móviles. La capa de datos
      está aislada en `src/lib/store.ts` a propósito para que este cambio sea
      reescribir `read`/`write`, no tocar la UI.

## P1 · Para que se pueda usar de verdad a diario

- [ ] **Desplegarla.** Hoy solo funciona en `localhost`. Sin una URL real no la
      podéis abrir desde el móvil, que es justo para lo que está hecha.
- [ ] **Convertirla en PWA.** Falta `manifest.json`, iconos y service worker.
      Sin eso no se instala en la pantalla de inicio ni funciona sin cobertura,
      y se abre con la barra del navegador comiéndose la pantalla.
- [ ] **Poner la `ANTHROPIC_API_KEY`.** El escáner de comida y las sugerencias
      funcionan en modo demo: devuelven platos de ejemplo, no analizan tu foto.
      Es la función estrella de la app y está apagada. Copia `.env.example` a
      `.env.local` y pega la clave.
- [ ] **Escribir vuestras razones del Día 1.** El botón de pánico enseña textos
      de relleno que escribí yo. Ese botón solo funciona si lo que hay dentro es
      vuestro. Ajustes → Tus razones del Día 1.
- [ ] **Ver días anteriores.** El panel siempre muestra hoy. No hay forma de
      corregir el desayuno de ayer ni de mirar atrás. Hace falta un selector de
      fecha o un deslizamiento entre días.

## P2 · Funciones a medias

- [ ] **Editar una comida ya guardada.** Ahora solo se puede borrar y volver a
      meterla.
- [ ] **Gráfica de peso.** Se guarda el peso diario pero no se ve la tendencia,
      que es lo único que importa en el peso.
- [ ] **Historial de PRs por ejercicio.** Solo se ve la mejor marca; no la
      progresión.
- [ ] **Calendario de racha.** Una cuadrícula del mes con los días ganados
      motiva más que un número suelto.
- [ ] **Recordatorios.** Un aviso a las 21:00 con lo que queda por marcar.
      Requiere PWA + permiso de notificaciones.
- [ ] **Agua más rápida.** Solo hay ±250 ml; un vaso grande son 6 toques.

## P3 · Calidad

- [ ] **Tests del store.** La lógica de racha, «día ganado», el reset por perfil
      y el aislamiento entre David y Sabina son cosas que se pueden romper sin
      que se note en pantalla. Lo comprobé a mano; debería estar automatizado.
- [ ] **Repasar accesibilidad.** Contraste del texto gris claro, foco de teclado
      en las hojas, `aria-live` en los avisos.
- [ ] **Limpiar `public/`.** Siguen los SVG de ejemplo de Next
      (`next.svg`, `vercel.svg`, `file.svg`, `globe.svg`, `window.svg`).
- [ ] **Favicon e imagen para compartir** propios, en vez del de Next.
- [ ] **Página 404 propia**, coherente con el diseño.
- [ ] **Zona horaria y cambio de día.** El día rueda cada 60 s comparando la
      fecha local; conviene probar qué pasa si se cambia de día con la app
      abierta o se viaja de huso.

---

## Decisiones tuyas, no técnicas

- **Objetivos de Sabina**: los puse a ojo (1800 kcal / 130 g proteína / 2,5 L)
  frente a los tuyos (2200 / 180 / 3). Habría que ajustarlos a lo que os toque
  de verdad.
- **¿PIN por perfil?** Ahora cualquiera que abra la web entra en los dos.
- **¿Os veis el progreso el uno al otro?** La landing ya enseña lo de ambos.
  Si preferís que cada uno vea solo lo suyo, hay que cambiarlo.
- **¿Qué pasa el día que se rompe la racha?** Ahora vuelve a 0 y ya. Igual
  merece un mensaje distinto al de un día normal.
