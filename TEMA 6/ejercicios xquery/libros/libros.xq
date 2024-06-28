(:1. Título y editorial de todos los libros:)
for $x in doc("libros.xml")/biblioteca/libros/libro
return <libro>{$x/titulo,$x/editorial}</libro>,
(:2. El títullo (sin etiquetas) de todos los libros de menos de 100 páginas.:)
for $x in doc("libros.xml")/biblioteca/libros/libro
where $x/paginas<100
return data($x/titulo),
(:3. El número de  libros de menos de 100 páginas.:)
for $x in doc("libros.xml")/biblioteca/libros
let $y:= $x/libro[paginas<100]
return count($y),
(:4. Una lista HTML con el título de los libros de la editorial “O'Reilly” ordenados por título.:)
<ul>{
for $x in doc("libros.xml")/biblioteca/libros/libro
where $x/editorial ="O'Reilly" 
order by $x/titulo
return <li>{data($x/titulo)}</li>}
</ul>,
(:5. Título y editorial de los libros de 2002:)
for $x in doc("libros.xml")/biblioteca/libros/libro
where $x/@publicacion=200
return <libro>{$x/titulo,$x/editorial}</libro>,
(:6. Título y editorial de los libros con más de un autor.:)
for $x in doc("libros.xml")/biblioteca/libros/libro
where count($x/autor)>1
return <libro>{$x/titulo, $x/editorial}</libro>,
(:7. Título y editorial de los libros que tienen versión electrónica.:)
for $x in doc("libros.xml")/biblioteca/libros/libro
where $x/versionElectronica
return <libro>{$x/titulo, $x/editorial}</libro>,
(:8. Título de los libros que no tienen versión electrónica.:)
for $x in doc("libros.xml")/biblioteca/libros/libro
where not($x/versionElectronica)
return $x/titulo