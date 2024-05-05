use Univ3
GO

-- 1 Listado con la cantidad de cursos.
SELECT Count(*) AS CantidadCursos FROM Cursos;

-- 2 Listado con la cantidad de usuarios.
SELECT Count(*) AS CANTIDAD_USUARIOS FROM Usuarios;

--3 Listado con el promedio de costo de certificación de los cursos.
SELECT AVG(C.CostoCertificacion) FROM Cursos AS C;
SELECT SUM(C.CostoCertificacion)/COUNT(C.CostoCertificacion) FROM Cursos AS C;

-- 4 Listado con el promedio general de calificación de reseñas.
SELECT AVG(R.Puntaje*1.0) AS PROMEDIO_CALIFICACION FROM CURSOS AS C
INNER JOIN Inscripciones AS I ON C.ID = I.IDCurso
INNER JOIN Reseñas AS R ON I.ID = R.IDInscripcion;

-- 5 Listado con la fecha de estreno de curso más antigua.
SELECT MIN(C.Estreno) AS ESTRENO_ANTIGUO FROM CURSOS AS C;

-- 6 Listado con el costo de certificación menos costoso.
SELECT MIN(C.CostoCertificacion) AS COSTO_CERT_BARATO FROM CURSOS AS C;

-- 7 Listado con el costo total de todos los cursos.
SELECT SUM(C.CostoCurso) AS COSTO_TOTAL FROM CURSOS AS C;

-- 8 Listado con la suma total de todos los pagos.
SELECT SUM(P.Importe) AS TOTAL_PAGOS FROM CURSOS AS C
INNER JOIN Inscripciones AS I ON C.ID = I.IDCurso
INNER JOIN Pagos AS P ON I.ID = P.IDInscripcion;

-- 9 Listado con la cantidad de cursos de nivel principiante.
SELECT COUNT(N.Nombre) AS CANT_PRINCIPIANTES FROM CURSOS AS C
INNER JOIN Niveles AS N ON C.IDNivel = N.ID
WHERE N.Nombre = 'Principiante';

-- 10 Listado con la suma total de todos los pagos realizados en 2020.
SELECT SUM(P.Importe) FROM CURSOS AS C
INNER JOIN Inscripciones AS I ON C.ID = I.IDCurso
INNER JOIN Pagos AS P ON P.IDInscripcion = I.ID
WHERE YEAR(P.Fecha) = 2020;

-- 11 Listado con la cantidad de usuarios que son instructores.
SELECT COUNT(DISTINCT IXC.IDUsuario) FROM Usuarios AS U
INNER JOIN Instructores_x_Curso AS IXC ON IXC.IDUsuario = U.ID

-- 12 Listado con la cantidad de usuarios distintos que se hayan certificado.
SELECT COUNT(DISTINCT U.ID) FROM Usuarios AS U
INNER JOIN Inscripciones AS I ON U.ID = I.IDUsuario
INNER JOIN Certificaciones AS C ON I.ID = C.IDInscripcion

-- 13 Listado con el nombre del país y la cantidad de usuarios de cada país.
SELECT P.Nombre AS NombrePais, COUNT(DP.ID) AS CantidadUsuarios
FROM Paises P
INNER JOIN Localidades L ON P.ID = L.IDPais
INNER JOIN Datos_Personales DP ON L.ID = DP.IDLocalidad
GROUP BY P.Nombre

-- 14 Listado con el apellido y nombres del usuario y el importe más costoso abonado como pago. Sólo listar aquellos que hayan abonado más de $7500.
SELECT DP.Apellidos, DP.Nombres, MAX(P.Importe) AS CantidadUsuarios
FROM Datos_Personales DP
INNER JOIN Inscripciones AS I ON DP.ID = I.IDUsuario
INNER JOIN Pagos AS P ON I.ID = P.IDInscripcion
WHERE P.Importe > 7500
GROUP BY DP.Apellidos, DP.Nombres

-- 15 Listado con el apellido y nombres de usuario de cada usuario y el importe más costoso del curso al cual se haya inscripto. 
-- Si hay usuarios sin inscripciones deben figurar en el listado de todas maneras.
SELECT DP.Apellidos, U.NombreUsuario, MAX(I.Costo) AS Inscripcion_Costosa
FROM Usuarios U
INNER JOIN Datos_Personales DP ON DP.ID = U.ID
LEFT JOIN Inscripciones AS I ON DP.ID = I.IDUsuario
GROUP BY DP.Apellidos, U.NombreUsuario

-- 16 Listado con el nombre del curso, nombre del nivel, cantidad total de clases y duración total del curso en minutos.
SELECT C.Nombre AS CURSO, N.Nombre AS NIVEL, COUNT(CL.Numero) AS CANT_CLASES, SUM(CL.Duracion) AS DURACION_CURSO FROM Cursos C
INNER JOIN Niveles N ON C.IDNivel = N.ID
INNER JOIN Clases CL ON CL.IDCurso = C.ID
GROUP BY C.Nombre, N.Nombre

-- 17 Listado con el nombre del curso y cantidad de contenidos registrados. Sólo listar aquellos cursos que tengan más de 10 contenidos registrados.
SELECT C.Nombre, COUNT(CO.ID) AS CANT_CONTENIDOS FROM Cursos C
INNER JOIN Clases AS CL ON C.ID = CL.IDCurso
INNER JOIN Contenidos AS CO ON CL.ID = CO.IDClase
GROUP BY C.Nombre
HAVING COUNT(CO.ID) > 10;

-- 18 Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.
SELECT C.Nombre, I.Nombre, COUNT(FI.ID) AS CANT_FORMATOS FROM Cursos C
INNER JOIN Idiomas_x_Curso IXC ON IXC.IDCurso = C.ID
INNER JOIN Idiomas I ON IXC.IDIdioma = I.ID
INNER JOIN FormatosIdioma FI ON IXC.IDFormatoIdioma = FI.ID
GROUP BY C.Nombre, I.Nombre

-- 19 Listado con el nombre del curso y cantidad de idiomas distintos disponibles.
SELECT C.Nombre AS CURSO_NOMBRE, COUNT(DISTINCT IXC.IDIdioma) AS CANT_IDIOMAS FROM Cursos C
INNER JOIN Idiomas_x_Curso IXC ON IXC.IDCurso = C.ID
GROUP BY C.Nombre

-- 20 Listado de categorías de curso y cantidad de cursos asociadas a cada categoría. 
-- Sólo mostrar las categorías con más de 5 cursos.
SELECT CAT.Nombre, COUNT(CAT.ID) AS NUM_CATEGORIAS FROM Cursos C 
INNER JOIN Categorias_x_Curso CXC ON CXC.IDCurso = C.ID
INNER JOIN Categorias CAT ON CAT.ID = CXC.IDCategoria
GROUP BY CAT.Nombre
HAVING COUNT(CAT.ID) > 5

-- 21 Listado con tipos de contenido y la cantidad de contenidos asociados a cada tipo. 
-- Mostrar también aquellos tipos que no hayan registrado contenidos con cantidad 0.
SELECT TC.Nombre AS TIPOS_CONTENIDO, COUNT(CO.ID) AS CANT_CONTENIDOS FROM TiposContenido TC
LEFT JOIN Contenidos CO ON TC.ID = CO.IDTipo
GROUP BY TC.Nombre
ORDER BY TC.Nombre;

-- 22 Listado con Nombre del curso, nivel, año de estreno y el total recaudado en concepto de inscripciones. 
-- Listar también aquellos cursos sin inscripciones con total igual a $0.

SELECT C.Nombre AS CURSO, N.Nombre  AS NIVEL, C.Estreno, COALESCE(SUM(P.Importe), 0) AS TOTAL_RECAUDADO FROM Cursos C
LEFT JOIN Niveles N ON N.ID = C.IDNivel
LEFT JOIN Inscripciones I ON I.IDCurso = C.ID
LEFT JOIN Pagos P ON P.IDInscripcion = I.ID 
GROUP BY C.Nombre, N.Nombre, C.Estreno

-- 23 Listado con Nombre del curso, costo de cursado y certificación y 
-- cantidad de usuarios distintos inscriptos cuyo costo de cursado sea menor a $10000 y 
-- cuya cantidad de usuarios inscriptos sea menor a 5. 
-- Listar también aquellos cursos sin inscripciones con cantidad 0.

SELECT 
    C.Nombre AS CURSO, 
    C.CostoCurso, 
    C.CostoCertificacion, 
    ISNULL(COUNT(DISTINCT I.IDUsuario), 0) AS CantidadUsuariosInscriptos
FROM Cursos C
LEFT JOIN 
    Inscripciones I ON C.ID = I.IDCurso
GROUP BY 
    C.Nombre, 
    C.CostoCertificacion,
    C.CostoCurso
HAVING 
    C.CostoCurso < 10000
    AND COUNT(DISTINCT I.IDUsuario) < 5
    OR COUNT(DISTINCT I.IDUsuario) = 0;


