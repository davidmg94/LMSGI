(:1.Extraer toda la información de los proveedores cuya ciudad sea Londres.:)
for $x in doc("codigo.xml")/datos/proveedores/proveedor
where $x/ciudad='Londres'
return $x,
(:2.Extraer solo el nombre de los proveedores cuya ciudad sea Londres.:)
for $x in doc("codigo.xml")/datos/proveedores/proveedor
where $x/ciudad='Londres'
return data($x/nombreprov),
(:3.Extraer el numero de parte de partes cuyo color sea Rojo:)
for $x in doc("codigo.xml")/datos/partes/parte
where $x/color='Rojo'
return data($x/@numparte),
(:4.Sin usar WHERE mostrar las partes que tienen un peso mayor de  14.:)
for $x in doc ('codigo.xml')/datos/partes/parte
return if ($x/peso > 14)
then $x,
(:5.Repetir la consulta anterior usando where:)
for $x in doc("codigo.xml")/datos/partes/parte
where $x/peso>14
return $x,
(:6.Extraer el nombre de parte y el peso de las partes cuyo color sea Azul:)
for $x in doc("codigo.xml")/datos/partes/parte
where $x/color='Azul'
return <parte>{($x/nombreparte),($x/peso)}</parte>,
(:7.Contar cuantas partes se han suministrado en una cantidad mayor de 400:)
for $x in doc('codigo.xml')/datos/suministros
let $y := $x/suministra[number(cantidad) > 400]
return count($y),
(:8.De la tabla suministros extraer el nombre de los proyectos con una cantidad suministrada menor que 700.:)
let $datos := doc("codigo.xml")/datos
let $proyectos := $datos/proyectos/proyecto
let $suministros := $datos/suministros/suministra

for $suministro in $suministros
where $suministro/cantidad < 700
let $numproyecto := $suministro/numproyecto
order by  $numproyecto
return <resultado>{data($proyectos[@numproyecto = $numproyecto]/nombreproyecto)}, {data($suministro/cantidad)}</resultado>
