use Univ2;
go

-- 1 Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.
SELECT U.NombreUsuario, D.Nombres, D.Apellidos FROM Usuarios AS U
INNER JOIN Datos_Personales AS D ON U.ID = D.ID;
-- 2 Listado con apellidos, nombres, fecha de nacimiento y nombre del país de nacimiento. 
SELECT Apellidos, Nombres, Nacimiento, P.Nombre FROM Usuarios AS U
INNER JOIN Datos_Personales AS D ON U.ID = D.ID
INNER JOIN Localidades AS L ON D.IDLocalidad = L.ID
INNER JOIN Paises AS P ON P.ID = L.IDPais;
-- 3 Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio comience con vocal. NOTA: Si no tiene email, obtener el celular.
SELECT U.NombreUsuario, D.Apellidos, D.Nombres, COALESCE(D.Email, D.Celular), Nacimiento FROM Usuarios AS U
INNER JOIN Datos_Personales AS D ON U.ID = D.ID
WHERE D.Domicilio LIKE '[aeiouAEIOU]%';
-- 4 Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Información de contacto'. NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.
SELECT U.NombreUsuario, D.Apellidos, D.Nombres, COALESCE(D.Email, D.Celular, D.Domicilio) as "Informacion de contacto", Nacimiento FROM Usuarios AS U
INNER JOIN Datos_Personales AS D ON U.ID = D.ID
-- 5 Listado con apellido y nombres, nombre del curso y costo de la inscripción de todos los usuarios inscriptos a cursos. NOTA: No deben figurar los usuarios que no se inscribieron a ningún curso.
SELECT D.Apellidos, D.Nombres, C.Nombre as Nombre_Curso, C.CostoCurso as Costo_Inscripcion FROM Usuarios AS U
INNER JOIN Datos_Personales AS D ON U.ID = D.ID
INNER JOIN Inscripciones as I ON I.IDUsuario = U.ID
INNER JOIN Cursos as C ON C.ID = I.IDCurso;
-- 6 Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el año 2020.
SELECT C.Nombre, U.NombreUsuario, DP.Email FROM Usuarios as U
INNER JOIN Datos_Personales AS DP ON DP.ID = U.ID
INNER JOIN Inscripciones AS I ON I.IDUsuario = U.ID
INNER JOIN Cursos AS C ON C.ID = I.IDCurso
WHERE YEAR(C.Estreno) = 2020; 
-- 7 Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripción, costo de inscripción, fecha de pago e importe de pago. Sólo listar información de aquellos que hayan pagado.
SELECT C.Nombre, U.NombreUsuario, DP.Apellidos, DP.Nombres, I.Fecha as FechaInscripcion, I.Costo, P.Fecha as FechaPago, P.Importe FROM Usuarios AS U
LEFT JOIN Datos_Personales AS DP ON DP.ID = U.ID
LEFT JOIN Inscripciones AS I ON I.IDUsuario = U.ID
INNER JOIN Pagos AS P ON P.IDInscripcion = I.ID
LEFT JOIN Cursos AS C ON C.ID = I.IDCurso;
-- 8 Listado con nombre y apellidos, género, fecha de nacimiento, mail, nombre del curso y fecha de certificación de todos aquellos usuarios que se hayan certificado.
SELECT DP.Nombres, DP.Apellidos, DP.Genero, DP.Nacimiento, DP.Email, C.Nombre as NombreCurso, CE.Fecha as FechaCertificacion FROM Usuarios AS U
INNER JOIN Datos_Personales AS DP ON DP.ID = U.ID
INNER JOIN Inscripciones AS I ON I.IDUsuario = U.ID
INNER JOIN Cursos AS C ON C.ID = I.IDCurso
INNER JOIN Certificaciones AS CE ON CE.IDInscripcion = I.ID
-- 9 Listado de cursos con nombre, costo de cursado y certificación, costo total (cursado + certificación) con 10% de todos los cursos de nivel Principiante.
SELECT C.Nombre, C.CostoCurso, C.CostoCertificacion, (C.CostoCertificacion + C.CostoCurso) AS CostoTotal,
CASE
    WHEN N.Nombre = 'Principiante' THEN 
        ((C.CostoCurso + C.CostoCertificacion) * 0.9)
    ELSE
        (C.CostoCurso + C.CostoCertificacion)
END AS CostoTotalConDescuento
FROM Usuarios AS U
INNER JOIN Datos_Personales AS DP ON DP.ID = U.ID
INNER JOIN Inscripciones AS I ON I.IDUsuario = U.ID
INNER JOIN Cursos AS C ON C.ID = I.IDCurso
INNER JOIN Niveles AS N ON N.ID = C.IDNivel

-- 10 Listado con nombre y apellido y mail de todos los instructores. Sin repetir.
SELECT DISTINCT DP.Nombres, DP.Apellidos, DP.Email
FROM Usuarios AS U
INNER JOIN Datos_Personales AS DP ON DP.ID = U.ID
INNER JOIN Instructores_x_Curso AS IC ON IC.IDUsuario = U.ID;

-- 11 Listado con nombre y apellido de todos los usuarios que hayan cursado algún curso cuya categoría sea 'Historia'.

SELECT DISTINCT DP.Nombres, DP.Apellidos
FROM Usuarios AS U
INNER JOIN Inscripciones AS I ON U.ID = I.IDUsuario
INNER JOIN Cursos AS C ON I.IDCurso = C.ID
INNER JOIN Categorias_x_Curso AS CC ON C.ID = CC.IDCurso
INNER JOIN Categorias AS CAT ON CC.IDCategoria = CAT.ID
INNER JOIN Datos_Personales AS DP ON U.ID = DP.ID
WHERE CAT.Nombre = 'Historia';

-- 12 Listado con nombre de idioma, código de curso y código de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos relacionados.

SELECT I.Nombre, C.ID as CodigoCurso, I.ID as CodigoIdioma FROM Cursos AS C
INNER JOIN Idiomas_x_Curso AS IXC ON IXC.IDCurso = C.ID
INNER JOIN Idiomas AS I ON I.ID = IXC.IDIdioma

-- 13 Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.
SELECT I.Nombre FROM Idiomas AS I
LEFT JOIN Idiomas_x_Curso AS IXC ON I.ID = IXC.IDIdioma
WHERE IXC.IDCurso is NULL

-- 14 Listado con nombres de idioma que figuren como audio de algún curso. Sin repeticiones.
SELECT DISTINCT I.Nombre FROM Idiomas AS I
INNER JOIN Idiomas_x_Curso AS IXC ON I.ID = IXC.IDIdioma
INNER JOIN FormatosIdioma AS FI ON FI.ID = IXC.IDFormatoIdioma
INNER JOIN Cursos AS C ON C.ID = IXC.IDCurso
WHERE FI.Nombre = 'Audio';

-- 15 Listado con nombres y apellidos de todos los usuarios y el nombre del país en el que nacieron. Listar todos los países indistintamente si no tiene usuarios relacionados.
SELECT DP.Nombres, DP.Apellidos, P.Nombre FROM Usuarios AS U
INNER JOIN Datos_Personales AS DP ON DP.ID = U.ID
INNER JOIN Localidades AS L ON L.ID = DP.IDLocalidad
RIGHT JOIN Paises AS P ON P.ID = L.IDPais

-- 16 Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario indistintamente si no se inscribieron a ningún curso.
SELECT C.Nombre as NombreCurso, C.Estreno as FechaEstreno, U.NombreUsuario FROM Usuarios AS U
LEFT JOIN Datos_Personales AS DP ON DP.ID = U.ID
LEFT JOIN Inscripciones AS I ON I.IDUsuario = U.ID
LEFT JOIN Cursos AS C ON C.ID = I.IDCurso

-- 17 Listado con nombre de usuario, apellido, nombres, género, fecha de nacimiento y mail de todos los usuarios que no cursaron ningún curso.
SELECT U.NombreUsuario, DP.Apellidos, DP.Nombres, DP.Genero, DP.Nacimiento, DP.Email, C.Nombre as CursoNombre FROM Usuarios AS U
LEFT JOIN Datos_Personales AS DP ON DP.ID = U.ID
LEFT JOIN Inscripciones AS I ON I.IDUsuario = DP.ID
LEFT JOIN Cursos AS C ON C.ID = I.IDCurso
WHERE C.ID is NULL;

-- 18 Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la reseña. Sólo de aquellos usuarios que hayan realizado una reseña inapropiada.
SELECT DP.Nombres, DP.Apellidos, C.Nombre as Nombre_Curso, R.Puntaje as Puntaje_Otorgado, R.Observaciones as Puntaje_Observacion FROM Usuarios AS U
INNER JOIN Datos_Personales AS DP ON DP.ID = U.ID
INNER JOIN Inscripciones AS I ON DP.ID = I.IDUsuario
INNER JOIN Cursos AS C ON C.ID = I.IDCurso
INNER JOIN Reseñas AS R ON R.IDInscripcion = I.ID
WHERE R.Inapropiada = 1;

-- 19 Listado con nombre del curso, costo de cursado, costo de certificación, nombre del idioma y nombre del tipo de idioma de todos los cursos cuya fecha de estreno haya 
-- sido antes del año actual. Ordenado por nombre del curso y luego por nombre de tipo de idioma. Ambos ascendentemente.

SELECT 
    C.Nombre AS NombreCurso,
    C.CostoCurso,
    C.CostoCertificacion,
    I.Nombre AS NombreIdioma,
    FI.Nombre AS TipoIdioma
FROM 
    Cursos AS C
INNER JOIN 
    Idiomas_x_Curso AS IXC ON C.ID = IXC.IDCurso
INNER JOIN 
    Idiomas AS I ON IXC.IDIdioma = I.ID
INNER JOIN 
    FormatosIdioma AS FI ON IXC.IDFormatoIdioma = FI.ID
WHERE 
    YEAR(C.Estreno) < YEAR(GETDATE())
ORDER BY 
    NombreCurso ASC,
    TipoIdioma ASC;

-- 20 Listado con nombre del curso y todos los importes de los pagos relacionados.

SELECT C.Nombre, P.Importe as Importe_Pagos FROM Cursos as C
INNER JOIN Inscripciones AS I ON I.IDCurso = C.ID
INNER JOIN Pagos AS P ON P.IDInscripcion = I.ID

-- Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, 
-- "Accesible" si el costo de cursado está entre $2500 y $15000, "Barato" si el costo está entre $1 y $2499 y "Gratis" si el costo es $0.21

SELECT Nombre, CostoCurso,
    CASE 
        WHEN CostoCurso > 15000 THEN 'Costoso'
        WHEN CostoCurso BETWEEN 2500 AND 15000 THEN 'Accesible'
        WHEN CostoCurso BETWEEN 1 AND 2499 THEN 'Barato'
        WHEN CostoCurso = 0.21 THEN 'Gratis'
        ELSE 'Gratirola'
    END AS Leyeeenda
FROM Cursos;