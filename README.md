# Auxio E2E con Maestro

Tests end-to-end de Android con [Maestro](https://maestro.dev) sobre [Auxio](https://github.com/OxygenCobalt/Auxio), un reproductor de música open source (GPLv3).

Maru Aller · QA Automation Engineer

## Sobre este proyecto

Elegí Auxio porque funciona sin conexión, sin cuenta y sin servidores externos: los tests solo pueden fallar por la app o por el test, no por factores ajenos. Auxio es un proyecto de terceros y este repositorio no tiene relación con sus autores ni incluye su APK.

## Qué cubre hoy

| Flow | Qué verifica |
|------|--------------|
| `01-launch` | La app abre con datos limpios |
| `02-empty-state` | Usuario nuevo: pestañas Songs, Albums, Artists, Genres y Playlists, mensaje de biblioteca vacía y botón de fuentes |
| `03-music-sources-dialog` | El diálogo "Music sources" muestra sus elementos y al cancelar vuelve al estado anterior sin cambios |
| `04-music-sources-modes` | Con "No folders", Save está deshabilitado. Al elegir System, la sección de carpetas desaparece y Save se habilita. Al volver a File picker, todo se restaura |

## Requisitos

- Java 17 o superior
- Maestro 2.12.1
- Emulador Android API 34 (Pixel 8)
- Auxio 4.1.5 instalado en el emulador (APK desde las releases del proyecto)

## Cómo correrlos

```bash
# Con el emulador encendido
maestro test .maestro/            # todos los flows
maestro test .maestro/02-empty-state.yaml   # uno solo
```

## Decisiones de diseño

- **Estado limpio en cada flow:** todos arrancan con `clearState: true`, así ningún test depende del resultado de otro.
- **Textos visibles en vez de coordenadas:** los flows buscan elementos por el texto que ve el usuario, lo que los hace legibles y resistentes a cambios de layout.
- **Se prueba comportamiento, no solo presencia:** por ejemplo, el estado habilitado o deshabilitado de un botón según el contexto.
- **Límite conocido:** Maestro no puede verificar que el audio suene. Los tests de reproducción validan el estado de la interfaz (título, botón de pausa, progreso).

## Roadmap

- Carga de música y verificación en la biblioteca
- Reproducción, cola y playlists
- Búsqueda
- Datos de prueba propios, con metadatos pensados para casos borde
- Ejecución en CI
