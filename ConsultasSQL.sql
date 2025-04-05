-- CREACIÓN DE BASE DE DATOS
CREATE DATABASE IF NOT EXISTS prueba_delphi;
USE prueba_delphi;

-- CREACIÓN DE TABLAS Pacientes y Citas
CREATE TABLE IF NOT EXISTS Pacientes (
    Id INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    FechaNacimiento DATE
);

CREATE TABLE IF NOT EXISTS Citas (
    Id INT PRIMARY KEY,
    PacienteId INT,
    Fecha DATE,
    Motivo VARCHAR(255),
    Estado VARCHAR(50), -- ('Pendiente', 'Atendida', 'Cancelada')
    Duracion INT, -- en minutos
    FOREIGN KEY (PacienteId) REFERENCES Pacientes(Id)
);

-- INSERCIÓN DE REGISTROS DE PRUEBA
INSERT INTO Pacientes (Id, Nombre, Apellido, FechaNacimiento) VALUES
(1, 'Juan', 'Pérez', '1985-06-12'),
(2, 'Ana', 'Gómez', '1990-08-25'),
(3, 'Carlos', 'Ramírez', '1978-03-10'),
(4, 'Lucía', 'Fernández', '1995-12-05'),
(5, 'Pedro', 'Sánchez', '1982-11-30'),
(6, 'Sofía', 'López', '2000-04-17'),
(7, 'Miguel', 'Martínez', '1987-01-22'),
(8, 'Laura', 'García', '1992-07-14'),
(9, 'Andrés', 'Ruiz', '1975-09-09'),
(10, 'Camila', 'Moreno', '1989-10-01');

INSERT INTO Citas (Id, PacienteId, Fecha, Motivo, Estado, Duracion) VALUES
(1, 1, DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 'Chequeo general', 'Atendida', 30),
(2, 1, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 'Control de presión', 'Atendida', 25),
(3, 1, DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 'Dolor de cabeza', 'Cancelada', 40),
(4, 1, DATE_SUB(CURDATE(), INTERVAL 5 MONTH), 'Chequeo general', 'Atendida', 35),
(5, 1, DATE_SUB(CURDATE(), INTERVAL 4 MONTH), 'Control de peso', 'Atendida', 20),
(6, 1, DATE_SUB(CURDATE(), INTERVAL 6 MONTH), 'Chequeo anual', 'Atendida', 50),
(7, 1, DATE_SUB(CURDATE(), INTERVAL 12 MONTH), 'Evaluación médica', 'Atendida', 60),
(8, 2, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 'Revisión de laboratorio', 'Atendida', 20),
(9, 2, DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 'Gripe', 'Atendida', 25),
(10, 2, DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 'Alergia', 'Atendida', 30),
(11, 3, DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 'Chequeo general', 'Atendida', 15),
(12, 3, DATE_SUB(CURDATE(), INTERVAL 5 MONTH), 'Consulta regular', 'Atendida', 10),
(13, 4, DATE_SUB(CURDATE(), INTERVAL 6 MONTH), 'Consulta dermatológica', 'Atendida', 50),
(14, 4, DATE_SUB(CURDATE(), INTERVAL 7 MONTH), 'Chequeo ginecológico', 'Atendida', 60),
(15, 5, DATE_SUB(CURDATE(), INTERVAL 8 MONTH), 'Chequeo cardiológico', 'Atendida', 30),
(16, 6, DATE_SUB(CURDATE(), INTERVAL 9 MONTH), 'Chequeo visual', 'Cancelada', 45),
(17, 7, DATE_SUB(CURDATE(), INTERVAL 10 MONTH), 'Chequeo auditivo', 'Atendida', 55),
(18, 8, DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 'Consulta general', 'Atendida', 35),
(19, 9, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 'Control diabetes', 'Atendida', 20),
(20, 10, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 'Consulta neurológica', 'Pendiente', 40);


-- CONSULTAS SOLICITADAS
-- Pacientes con más de 5 citas atendidas en los últimos 6 meses, y promedio de duración de sus citas.
SELECT 
    p.Id AS PacienteId,
    p.Nombre,
    p.Apellido,
    COUNT(c.Id) AS TotalCitasAtendidas,
    AVG(c.Duracion) AS PromedioDuracion
FROM Pacientes p
JOIN Citas c ON p.Id = c.PacienteId
WHERE c.Estado = 'Atendida'
  AND c.Fecha >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY p.Id, p.Nombre, p.Apellido
HAVING COUNT(c.Id) >= 5;



-- Paciente con mayor tiempo total en consultas médicas en el último año.
SELECT 
    p.Id AS PacienteId,
    p.Nombre,
    p.Apellido,
    SUM(c.Duracion) AS TotalDuracion
FROM Pacientes p
JOIN Citas c ON p.Id = c.PacienteId
WHERE c.Estado = 'Atendida'
  AND c.Fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.Id, p.Nombre, p.Apellido
ORDER BY TotalDuracion DESC
LIMIT 1;

