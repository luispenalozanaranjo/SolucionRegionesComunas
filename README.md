# Sistema de Regiones y Comunas

Este sistema permite administrar regiones y comunas de Chile. Está compuesto por una interfaz web, una API REST y una base de datos en SQL Server. La solución está dividida en tres proyectos para mantener una estructura clara y modular.

## Proyectos incluidos

### 1. WebApiSDervicePrueba (API)
- Expone servicios REST para consultar, insertar y actualizar regiones y comunas.
- Valida estructura XML y datos ingresados.
- Registra eventos mediante `ILogger`.
- Manejo de errores con respuestas descriptivas.

### 2. MvcAppPrueba (Interfaz Web)
- Consume la API para mostrar regiones y comunas.
- Permite agregar y editar comunas desde formularios.
- Validaciones en cliente y servidor.
- Diseño responsivo con Bootstrap.

### 3. PruebaDataAccess (Capa de acceso a datos)
- Contiene los repositorios que se conectan a la base de datos.
- Utiliza procedimientos almacenados para las operaciones CRUD.

## Base de Datos

El sistema utiliza SQL Server con dos tablas principales:

### Tabla `Region`
- `IdRegion` (INT, PK)  
- `Region` (NVARCHAR)

### Tabla `Comuna`
- `IdComuna` (INT, PK)  
- `IdRegion` (INT, FK)  
- `Comuna` (NVARCHAR)  
- `InformacionAdicional` (XML)

#### Estructura del campo `InformacionAdicional`:

```xml
<Info>
  <Superficie>0</Superficie>
  <Poblacion Densidad="0">0</Poblacion>
</Info>
```

## Validaciones implementadas

- El nombre de comuna no admite números ni caracteres especiales.
- La estructura XML es fija; si está vacía o incorrecta, se reemplaza.
- Valores vacíos dentro del XML se reemplazan automáticamente por ceros.
- La vista web restaura el XML si se elimina manualmente.

## Registro de logs

La API registra:
- Peticiones exitosas
- Datos inválidos
- Errores de ejecución

Esto permite una trazabilidad efectiva durante el desarrollo y operación.

## Ejecución del sistema

1. Restaurar la base de datos y ejecutar los scripts de inserción.
2. Configurar la cadena de conexión en `appsettings.json` del proyecto WebApiSDervicePrueba.
3. En Visual Studio:
   - Ir a **Propiedades de la solución > Proyectos de inicio**
   - Seleccionar **"Varios proyectos de inicio"**
   - Marcar `MvcAppPrueba` y `WebApiSDervicePrueba` como **"Iniciar"**
4. Ejecutar y acceder al frontend desde el navegador.

## Autor

**Luis Peñaloza Naranjo**