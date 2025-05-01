# Sistema de Regiones y Comunas

Este sistema permite administrar regiones y comunas de Chile. Incluye una interfaz web, una API REST y una base de datos SQL Server. La solución está organizada en tres proyectos separados, siguiendo una arquitectura limpia y modular.

---

## Proyectos incluidos

### 1. WebApiSDervicePrueba (API)
- Expone servicios REST para consultar, insertar y actualizar regiones y comunas.
- Incluye validaciones de datos y estructura XML.
- Registra logs usando `ILogger`.
- Responde con mensajes claros ante errores o entradas inválidas.

### 2. MvcAppPrueba (Interfaz Web)
- Consume los servicios de la API para mostrar regiones y comunas.
- Permite agregar y editar comunas desde un formulario.
- Valida los datos ingresados tanto en cliente como en servidor.
- Usa Bootstrap para la presentación visual.

### 3. PruebaDataAccess (Acceso a datos)
- Contiene los repositorios que acceden a la base de datos.
- Utiliza procedimientos almacenados para las operaciones.

---

## Base de Datos

El sistema utiliza SQL Server. Incluye dos tablas principales:

### Region
- IdRegion (INT, PK)
- Region (NVARCHAR)

### Comuna
- IdComuna (INT, PK)
- IdRegion (INT, FK)
- Comuna (NVARCHAR)
- InformacionAdicional (XML)

La columna `InformacionAdicional` debe tener esta estructura:
```xml
<Info>
  <Superficie>0</Superficie>
  <Poblacion Densidad="0">0</Poblacion>
</Info>
```

---

## Validaciones implementadas

- El campo "Comuna" no permite números ni caracteres extraños.
- El campo XML debe tener una estructura fija. Si está vacío o mal formado, se informa.
- En la vista, si se borra la estructura XML, se repone automáticamente.
- Si se dejan vacíos los valores del XML, se reemplazan con ceros.

---

## Registro de logs

La API registra:
- Peticiones exitosas
- Datos incorrectos
- Errores de ejecución

Esto ayuda a identificar problemas rápidamente durante el desarrollo o despliegue.

---

## Ejecución del sistema

1. Restaurar la base de datos y ejecutar los scripts de inserción.
2. Verificar la cadena de conexión en `appsettings.json` del proyecto `WebApiSDervicePrueba`.
3. En Visual Studio:
   - Ir a Propiedades de la solución > Proyectos de inicio.
   - Seleccionar "Varios proyectos de inicio".
   - Marcar `MvcAppPrueba` y `WebApiSDervicePrueba` como "Iniciar".
4. Ejecutar y navegar en el navegador al frontend MVC.

---

## Comentarios finales

Este proyecto cumple con los requisitos funcionales solicitados. Toda la estructura, validaciones y funcionalidades fueron programadas manualmente. La solución está pensada para ser clara, mantenible y fácil de extender.

---

Desarrollado por: **Luis Peñaloza Naranjo**
