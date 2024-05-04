# Actividad 2.2 - Consultas de Selección - Cláusula Join
## Realizar consultas en lenguaje T-SQL que permitan obtener los siguientes listados. Utilizar la base de datos Univ y los datos habilitados en la semana 05.

## Ejercicio
- Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.
- Listado con apellidos, nombres, fecha de nacimiento y nombre del país de nacimiento.
- Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio comience con vocal.
NOTA: Si no tiene email, obtener el celular.
- Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Información de contacto'.
NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.
- Listado con apellido y nombres, nombre del curso y costo de la inscripción de todos los usuarios inscriptos a cursos.
NOTA: No deben figurar los usuarios que no se inscribieron a ningún curso.
- Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el año 2020.
- Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripción, costo de inscripción, fecha de pago e importe de pago. Sólo listar información de aquellos que hayan pagado.
- Listado con nombre y apellidos, género, fecha de nacimiento, mail, nombre del curso y fecha de certificación de todos aquellos usuarios que se hayan certificado.
- Listado de cursos con nombre, costo de cursado y certificación, costo total (cursado + certificación) con 10% de todos los cursos de nivel Principiante.
- Listado con nombre y apellido y mail de todos los instructores. Sin repetir.
- Listado con nombre y apellido de todos los usuarios que hayan cursado algún curso cuya categoría sea 'Historia'.
- Listado con nombre de idioma, código de curso y código de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos relacionados.
- Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.
- Listado con nombres de idioma que figuren como audio de algún curso. Sin repeticiones.
- Listado con nombres y apellidos de todos los usuarios y el nombre del país en el que nacieron. Listar todos los países indistintamente si no tiene usuarios relacionados.
- Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario indistintamente si no se inscribieron a ningún curso.
- Listado con nombre de usuario, apellido, nombres, género, fecha de nacimiento y mail de todos los usuarios que no cursaron ningún curso.
- Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la reseña. Sólo de aquellos usuarios que hayan realizado una reseña inapropiada.
- Listado con nombre del curso, costo de cursado, costo de certificación, nombre del idioma y nombre del tipo de idioma de todos los cursos cuya fecha de estreno haya sido antes del año actual. Ordenado por nombre del curso y luego por nombre de tipo de idioma. Ambos ascendentemente.
- Listado con nombre del curso y todos los importes de los pagos relacionados.
- Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, "Accesible" si el costo de cursado está entre $2500 y $15000, "Barato" si el costo está entre $1 y $2499 y "Gratis" si el costo es $0.