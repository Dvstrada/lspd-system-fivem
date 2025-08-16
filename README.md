# lspd-system-fivem

**Sistema Policía** inspirado en las jerarquías reales del LAPD y adaptado para el **Los Santos Police Department** (LSPD) en servidores FiveM. El recurso incluye un sistema de rangos, un menú de organizaciones accesible con la tecla **TAB** y un conjunto de utilidades para la policía: armería, uniformes, vehículos y casilleros. Está diseñado para funcionar con los elementos vanilla de GTA V.

## Características

- **Jerarquía de rangos realista:** implementa una escala de 20 rangos descendentes basada en los grados oficiales del Departamento de Policía de Los Ángeles (LAPD)【205271092347583†L77-L81】. El rango 20 es **Chief of Police** y el rango 1 es **Cadet**.
- **Menú de organizaciones (NUI):** accesible mediante la tecla **TAB**; permite navegar por categorías como Gobierno, Empresas y Bandas criminales. Por defecto se incluye la organización **Los Santos Police Department** en la categoría de Gobierno.
- **Sistema de asignación de rangos:** el menú de organizaciones muestra los rangos configurados para cada organización y permite asignar un rango a un jugador (requiere implementar la lógica de asignación en `server/main.lua`).
- **Puntos interactivos configurables:** los administradores (rango 20) pueden colocar puntos de **armería**, **uniformes**, **garaje de patrullas** y **casilleros** con comandos (`/setarmory`, `/setuniform`, `/setgarage`, `/setlocker`). Estos puntos aparecen en el mundo como marcadores.
- **Armería:** permite solicitar armas del juego base (pistola, escopeta, rifle carbine, subfusil, porra) según el rango mínimo configurado en `config.lua`.
- **Garage de patrullas:** permite sacar vehículos policiales vanilla (`police`, `police2`, `police3`, `policeb` y `riot`), cada uno con un rango mínimo de acceso.
- **Uniformes predefinidos:** incluye conjuntos para **Clase B (Patrulla)** y **SWAT** utilizando variaciones de ropa vanilla; se aplican automáticamente según el género del jugador. Los rangos altos pueden ampliar la lista en `config.lua`.
- **Casilleros:** punto reservado para funcionalidades futuras (como almacenamiento personal).
- **Interfaz HTML/CSS/JS:** completamente escrita en NUI para ofrecer menús intuitivos y estéticos.

## Rangos del LSPD

Se implementan los siguientes rangos basados en la escala oficial del LAPD【469425258370981†L784-L820】 (20 el mayor, 1 el menor):

1. **20 – Chief of Police**  
2. **19 – Assistant Chief of Police**  
3. **18 – Deputy Chief of Police**  
4. **17 – Commander**  
5. **16 – Captain III**  
6. **15 – Captain II**  
7. **14 – Captain I**  
8. **13 – Lieutenant II**  
9. **12 – Lieutenant I**  
10. **11 – Sergeant II**  
11. **10 – Sergeant I**  
12. **9 – Detective III**  
13. **8 – Detective II**  
14. **7 – Detective I**  
15. **6 – Police Officer III**  
16. **5 – Police Officer II**  
17. **4 – Police Officer I**  
18. **3 – Probationary Officer**  
19. **2 – Recruit**  
20. **1 – Cadet**

## Instalación

1. Descarga o clona este repositorio en la carpeta **`resources`** de tu servidor FiveM.

```bash
cd resources
git clone https://github.com/Dvstrada/lspd-system-fivem.git
```

2. Asegúrate de que los archivos `fxmanifest.lua`, `config.lua`, la carpeta `client`, la carpeta `server` y la carpeta `html` estén en la raíz del recurso.

3. Añade la siguiente línea a tu archivo `server.cfg` para iniciar el recurso:

```
ensure lspd-system-fivem
```

4. Reinicia el servidor para cargar el recurso.

### Configuración de puntos interactivos

Solo los usuarios con rango máximo (20) pueden crear o mover los puntos de interacción. Colócate en el lugar deseado e introduce uno de los siguientes comandos en el chat:

- `/setarmory` – establece la ubicación de la armería.  
- `/setuniform` – establece la ubicación del vestidor de uniformes.  
- `/setgarage` – establece la ubicación del garaje de patrullas.  
- `/setlocker` – establece la ubicación de los casilleros.

Las ubicaciones se guardan en memoria mientras el recurso está activo. Puedes editar `config.lua` para establecer posiciones por defecto.

### Uso

- Pulsa **TAB** para abrir el menú de organizaciones y selecciona *Gobierno → Los Santos Police Department* para ver y asignar rangos.
- Acércate a los marcadores de **armería**, **uniformes** o **garaje** y pulsa **E** para abrir su menú.  
  - En la armería, selecciona un arma de la lista (solo verás las disponibles para tu rango).  
  - En el garaje, elige un vehículo policial.  
  - En el vestidor, elige entre los uniformes disponibles.
- Para cerrar cualquier menú NUI, pulsa el botón **Cerrar** o la tecla **Esc**.

### Personalización

- **Agregar organizaciones/categorías:** edita `config.lua` y añade entradas en `Config.Organizations` siguiendo la estructura existente. Puedes duplicar la plantilla del LSPD para tu propia organización.
- **Agregar armas o vehículos:** edita `Config.Weapons` y `Config.Vehicles` definiendo `label`, `name` o `model` y `minRank`.
- **Agregar uniformes:** añade nuevos presets a `Config.Uniforms` con componentes `component` y `drawable`/`texture` para hombre y mujer. Consulta la documentación de FiveM para conocer los IDs de componentes y ropa. Los números utilizados para la Clase B se basan en los componentes vanilla de policía del GTA V【447904251330106†L98-L107】.

## Estructura del proyecto

- `fxmanifest.lua`: Metadatos del recurso FiveM y lista de scripts incluidos.  
- `config.lua`: Configuración de categorías, organizaciones, rangos, ubicaciones y presets.  
- `client/main.lua`: Lógica del cliente; gestiona marcadores, menús NUI y aplica armas, vehículos y uniformes.  
- `server/main.lua`: Lógica del servidor; gestiona la memoria de ubicaciones, envía datos al cliente y ejecuta acciones (dar armas, generar vehículos, asignar rangos, aplicar uniformes).  
- `html/`: Archivos de interfaz NUI (`index.html`, `style.css`, `script.js`).  

## Licencia

Distribuido bajo la licencia MIT. Consulta el archivo `LICENSE` para más información.
