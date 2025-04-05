# Prueba Técnica - Desarrollador Senior
**Autor:** Jesús Alfredo Maza Sánchez

**desarrollado en Delphi ver 11.3**

# Solicitudes
- Consumo de API REST y Patrones de Diseño
- Backend - Delphi (Manejo de concurrencia y paralelismo)
- SQL - Optimización, Consultas Complejas y Normalización
- Delphi - Integración con Base de Datos (ORM y Patrones de Diseño)
- Gestión de Datos en una Grilla Personalizada

# Contenido 
- `Concurrencia.pas`: Llamadas concurrentes a 3 APIs REST usando `TTask` y `WaitForAll`.
- `ConsultasSQL.sql`: Consultas optimizadas a base de datos para estadísticas clínicas.
- `PacienteORM.pas`: Clase ORM con constructor sobrecargado y función de cálculo de edad.
- `GrillaFormulario.pas`: Grilla visual que permite búsqueda, ordenación y carga asincrónica.

# Cómo ejecutar la prueba
### 1. Archivos `.pas` (Delphi)
Para ejecutar los archivos `.pas`, tener instalado Delphi (tengo 12.3):

- Abrir Delphi.
- Crea un nuevo proyecto de tipo VCL Forms Application.
- Agrega los archivos `.pas` al proyecto (click derecho en el explorador del proyecto → Add → Existing Unit).
- Se pueden usar los procedimientos y clases desde el formulario principal (`Form1`) para probar su funcionamiento.

### 2. Archivo `ConsultasSQL.sql`
Consultas listas para ejecutarse en **MySQL** o **MariaDB**. Se incluyó el script para la creación de la base de datos y tablas.

Para hacerlo PHPMyAdmin (usando XAMPP) copiando y pegando el contenido del archivo ConsultasSQL.sql en la consola.

Optimización en caso que la tabla Citas tiene millones de registros:
  - Creación de un índice compuesto sobre (PacienteId, Fecha, Estado) para acelerar filtros frecuentes: CREATE INDEX idx_citas_paciente_fecha_estado ON Citas(PacienteId, Fecha, Estado);
  - Las columnas utilizadas en WHERE, JOIN y ORDER BY tienen índices.
  - Archivar citas antiguas en otra tabla para reducir el volumen de datos activos.
  - Usar partición por fecha (ej. por año o trimestre).

Denormalización:
- Justificación: Puede ser útil cuando necesitas mejorar el rendimiento de lecturas frecuentes a costa de aumentar el tamaño del almacenamiento o la complejidad de actualizaciones.

Por ejemplo, se podría duplicar el nombre y apellido del paciente directamente en la tabla Citas:

ALTER TABLE Citas ADD COLUMN NombrePaciente VARCHAR(100);
ALTER TABLE Citas ADD COLUMN ApellidoPaciente VARCHAR(100);

Esto permitiría evitar el JOIN con Pacientes para reportes rápidos.

- Impacto en el rendimiento:
 * Mejora el rendimiento de consultas frecuentes (menos JOINs).
 * Aumenta el tamaño de la tabla.
 * Hace más complejas las operaciones de actualización si los datos del paciente cambian.
 * Es útil especialmente en sistemas de solo lectura o reportes históricos.


## Observaciones
- La grilla visual (`GrillaFormulario.pas`) está hecha para ser usada en un `TStringGrid`.
- Se simulan llamadas a la API en lugar de usar componentes reales de red para facilitar la revisión.
