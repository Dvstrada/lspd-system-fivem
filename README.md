# lspd-system-fivem

**Sistema Policía** inspirado en las jerarquías reales del LAPD y adaptado para el **Los Santos Police Department** (LSPD) en servidores FiveM. Incluye un menú de organizaciones accesible con la tecla **TAB** con categorías para empresas, organismos gubernamentales y bandas criminales. Actualmente solo se define el LSPD dentro de la categoría gubernamental.

## Características

- **Jerarquía de rangos realista:** se implementa una escala de 20 rangos descendentes basada en los grados oficiales del Departamento de Polic a de Los Ángeles (LAPD)【205271092347583†L77-L81】. El rango 20 corresponde al `Chief of Police` y el rango 1 al `Cadet`.
- **Menú de organizaciones (NUI):** se accede mediante la tecla **TAB**; muestra las categorías `Gobierno`, `Empresas` y `Bandas criminales`. Dentro de `Gobierno` se incluye `Los Santos Police Department` con sus rangos configurados.
- **Asignación de rangos:** el menú lista los rangos de cada organización para permitir asignar un rango a un jugador (requiere implementar la lógica de servidor).
- **Fácilmente extensible:** se pueden añadir nuevas organizaciones o categorías modificando `config.lua`.
- **Interfaz HTML/CSS/JS:** menús diseñados con NUI para una experiencia inmersiva.

## Rangos del LSPD

La jerarquía implementada asigna los siguientes rangos (20 el mayor, 1 el menor):

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

Estos rangos se basan en la estructura oficial de promoción del LAPD【205271092347583†L77-L81】 y permiten reflejar la cadena de mando dentro del servidor.

## Instalación

1. Clona o descarga este repositorio en la carpeta `resources` de tu servidor FiveM.
2. Asegúrate de que `fxmanifest.lua`, `config.lua`, la carpeta `client`, la carpeta `server` y la carpeta `html` estén en la ruta del recurso.
3. Añade la siguiente línea a tu `server.cfg` para iniciar el recurso:

   ```cfg
   ensure lspd-system-fivem
   ```

4. Reinicia el servidor.

## Uso

- Inicia sesión en el servidor con permisos adecuados.
- Pulsa la tecla **TAB** para abrir el menú de organizaciones.
- Selecciona la categoría `Gobierno` y luego `Los Santos Police Department` para ver la lista de rangos.
- Haz clic en un rango para asignarlo a un jugador (requiere implementar la lógica de asignación en `server/main.lua`).

## Configuración

El archivo `config.lua` define todas las categorías y organizaciones. Para añadir nuevas empresas o bandas criminales, sigue la estructura:

```lua
Config.Organizations['business'].organizations['nombre'] = {
    label = 'Nombre de la empresa',
    ranks = {
        [n] = 'Nombre del rango',
        ...
    }
}
```

Puedes duplicar la sección de LSPD como plantilla para tus propias organizaciones.

## Estructura del proyecto

- **fxmanifest.lua:** Metadata del recurso FiveM y lista de scripts.
- **config.lua:** Configuración de categorías, organizaciones y rangos.
- **client/main.lua:** Lógica del cliente (abrir/cerrar menú y comunicación con NUI).
- **server/main.lua:** Lógica del servidor para enviar datos al cliente (y asignar rangos).
- **html/**: Archivos para la interfaz NUI (`index.html`, `style.css`, `script.js`).

## Licencia

Distribuido bajo la licencia MIT. Consulta el archivo `LICENSE` para más información.
