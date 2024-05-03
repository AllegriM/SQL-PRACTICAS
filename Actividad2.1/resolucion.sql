-- 1 - Listado de todos los idiomas.
SELECT * FROM Idiomas;
-- 2 - Listado de todos los cursos. 
SELECT * FROM Cursos;
-- 3 - Listado con nombre, costo de inscripci�n (costo de curso), costo de certificaci�n y fecha de estreno de todos los cursos.
SELECT C.Nombre, C.CostoCurso, C.CostoCertificacion, C.FechaEstreno FROM Cursos as C;
-- 4 - Listado con ID, nombre, costo de inscripci�n y ID de nivel de todos los cursos cuyo costo de certificaci�n sea menor a $5000.
SELECT C.ID, C.Nombre, C.CostoCurso, C.IDNivel FROM Cursos as C  WHERE C.CostoCertificacion < 5000;
-- 5 - Listado con ID, nombre, costo de inscripci�n y ID de nivel de todos los cursos cuyo costo de certificaci�n sea mayor a $1200.
SELECT C.ID, C.Nombre, C.CostoCurso, C.IDNivel FROM Cursos as C  WHERE C.CostoCertificacion > 1200;
-- 6 - Listado con nombre, n�mero y duraci�n de todas las clases del curso con ID n�mero 6.
SELECT C.Nombre, C.Numero, C.Duracion FROM Clases as C  WHERE C.IDCurso = 6;
-- 7 - Listado con nombre, n�mero y duraci�n de todas las clases del curso con ID n�mero 10.
SELECT C.Nombre, C.Numero, C.Duracion FROM Clases as C  WHERE C.IDCurso = 10;
-- 8 - Listado con nombre y duraci�n de todas las clases del curso con ID n�mero 4. Ordenado por duraci�n de mayor a menor.
SELECT C.Nombre, C.Duracion FROM Clases as C  WHERE C.IDCurso = 4 ORDER BY C.Duracion DESC;
-- 9 - Listado de cursos con nombre, fecha de estreno, costo del curso, costo de certificaci�n ordenados por fecha de estreno de manera creciente.
SELECT C.Nombre, C.FechaEstreno, C.CostoCurso, C.CostoCertificacion FROM Cursos as C ORDER BY C.FechaEstreno ASC;
-- 10 - Listado con nombre, fecha de estreno y costo del curso de todos aquellos cuyo ID de nivel sea 1, 5, 9 o 10.
SELECT Nombre, FechaEstreno, CostoCurso FROM Cursos as C WHERE ID IN (1, 5, 9, 10);
-- 11 - Listado con nombre, fecha de estreno y costo de cursado de los tres cursos m�s caros de certificar.
SELECT TOP 3 Nombre, FechaEstreno, CostoCurso FROM Cursos ORDER BY CostoCertificacion DESC;
-- 12 - Listado con nombre, duraci�n y n�mero de todas las clases de los cursos con ID 2, 5 y 7. Ordenados por ID de Curso ascendente y luego por n�mero de clase ascendente.
SELECT Nombre, Duracion, Numero FROM Clases as C WHERE ID IN (2, 5, 7) 
ORDER BY IDCurso ASC, Numero ASC;
-- 13 - Listado con nombre y fecha de estreno de todos los cursos cuya fecha de estreno haya sido en el primer semestre del a�o 2019.
SELECT Nombre, FechaEstreno FROM Cursos WHERE YEAR(FechaEstreno) = 2019 AND MONTH(FechaEstreno) BETWEEN 1 AND 6;
-- 14 - Listado de cursos cuya fecha de estreno haya sido en el a�o 2020.
SELECT * FROM Cursos WHERE YEAR(FechaEstreno) = 2020;
-- 15 Listado de cursos cuyo mes de estreno haya sido entre el 1 y el 4.
SELECT * FROM Cursos WHERE MONTH(FechaEstreno) BETWEEN 1 AND 4;
-- 16 Listado de clases cuya duraci�n se encuentre entre 15 y 90 minutos.
SELECT * FROM Clases WHERE Duracion BETWEEN 15 AND 90;
-- 17 Listado de contenidos cuyo tama�o supere los 5000MB y sean de tipo 4 o sean menores a 400MB y sean de tipo 1.
SELECT * FROM Contenidos as C WHERE  (Tamanio > 5000 AND IDTipoContenido = 4) OR (Tamanio < 400 AND IDTipoContenido = 1);
-- 18 Listado de cursos que no posean ID de nivel.
SELECT * FROM Cursos WHERE IDNivel is NULL;
-- 19 Listado de cursos cuyo costo de certificaci�n corresponda al 20% o m�s del costo del curso.
SELECT * FROM Cursos WHERE CostoCertificacion >= CostoCurso * 0.2;
-- 20 Listado de costos de cursado de todos los cursos sin repetir y ordenados de mayor a menor.
SELECT DISTINCT CostoCurso FROM Cursos ORDER BY CostoCurso DESC;

