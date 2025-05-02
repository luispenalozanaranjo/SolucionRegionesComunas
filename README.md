# Sistema de Regiones y Comunas

Este sistema permite administrar regiones y comunas de Chile. Está compuesto por una interfaz web, una API REST y una base de datos en SQL Server. La solución está dividida en tres proyectos para mantener una estructura clara y modular.

## Proyectos incluidos

### 1. WebApiSDervicePrueba (API)
- Expone servicios REST para consultar, insertar y actualizar regiones y comunas.
- Valida la estructura XML y los datos ingresados.
- Registra eventos mediante `ILogger` y `Serilog`.
- Manejo de errores con respuestas claras.
- Los eventos se almacenan automáticamente en archivos de texto diarios dentro de la carpeta `/Logs`.

### 2. MvcAppPrueba (Interfaz Web)
- Consume la API para mostrar regiones y comunas.
- Permite agregar y editar comunas desde formularios.
- Validaciones en cliente y servidor.
- Interfaz responsiva desarrollada con Bootstrap.

### 3. PruebaDataAccess (Capa de acceso a datos)
- Contiene los repositorios que se conectan a la base de datos.
- Todas las operaciones se realizan mediante procedimientos almacenados.

## Base de Datos

El sistema utiliza SQL Server con dos tablas principales:

- **Region**
  - `IdRegion` (INT, PK)
  - `Region` (NVARCHAR)

- **Comuna**
  - `IdComuna` (INT, PK)
  - `IdRegion` (INT, FK)
  - `Comuna` (NVARCHAR)
  - `InformacionAdicional` (XML)

### Formato del campo `InformacionAdicional`:

```xml
<Info>
  <Superficie>0</Superficie>
  <Poblacion Densidad="0">0</Poblacion>
</Info>
```

## Instalación de la base de datos

1. Descargar el script SQL desde el repositorio:  
   [RegionComuna.sql](https://github.com/luispenalozanaranjo/SolucionRegionesComunas/blob/master/Database/RegionComuna.sql)

2. Ejecutar el script en una nueva base de datos en SQL Server (por ejemplo: `RegionesComunasDB`).

3. Verificar que las tablas y procedimientos almacenados estén correctamente creados.

## Validaciones implementadas

- El nombre de comuna no permite números ni caracteres especiales.
- Si el XML es nulo o inválido, se reemplaza por una estructura válida.
- Los valores vacíos en el XML se reemplazan automáticamente por cero.
- La vista web permite restaurar el XML si ha sido eliminado manualmente.

## Registro de Logs

El proyecto `WebApiSDervicePrueba` utiliza Serilog para registrar la actividad del sistema. Los eventos se almacenan en archivos de texto diarios dentro de la carpeta `Logs`, generando un nuevo archivo por día.  
El registro incluye:

- Peticiones exitosas
- Datos inválidos recibidos
- Errores en tiempo de ejecución

Esta funcionalidad permite realizar trazabilidad y diagnóstico durante el desarrollo y en ambientes productivos.

## Ejecución del sistema

1. Restaurar la base de datos utilizando el script mencionado.
2. Configurar la cadena de conexión en `appsettings.json` del proyecto `WebApiSDervicePrueba`.
3. En Visual Studio:
   - Ir a **Propiedades de la solución > Proyectos de inicio**
   - Seleccionar **"Varios proyectos de inicio"**
   - Marcar `MvcAppPrueba` y `WebApiSDervicePrueba` como **"Iniciar"**
4. Ejecutar la solución y acceder al frontend desde el navegador.

## Autor

Luis Peñaloza Naranjo
