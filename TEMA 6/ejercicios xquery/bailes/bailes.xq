(:1. Muestra el nombre de todos los bailes.:)
for $x in doc("bailes.xml")/bailes/baile
return data($x/nombre),
(:2. Muestra el nombre y precio de todos los bailes.:)
for $x in doc("bailes.xml")/bailes/baile
return <baile>
  <nombre>{data($x/nombre)}</nombre>
  <precio>{data($x/precio)}</precio>    
</baile>,
(:3. Muestra el nombre y precio de todos los bailes cuyo precio es mayor de 40.:)
for $x in doc("bailes.xml")/bailes/baile
where number ($x/precio) >40
return <baile>
        <nombre>{data($x/nombre)}</nombre>
        <precio>{data($x/precio)}</precio>
       </baile>,
(:4. Muestra todos los bailes ordenados por nombre.:)
for $x in doc("bailes.xml")/bailes/baile
order by ($x/nombre)
return data($x/nombre),
(:5. Muestra el nombre de todos los bailes que contienen la a.:)
for $x in doc("bailes.xml")/bailes/baile
where contains($x/nombre, "a")
return data($x/nombre),
(:6. Mostrar el nombre de los bailes donde el apellido del profesor sea Lozano.:)
for $x in doc("bailes.xml")/bailes/baile
where contains($x/profesor, "Lozano")
return data($x/nombre),
(:7. Mostrar todos los bailes, excepto el 3 y 5.:)
for $x in doc("bailes.xml")/bailes/baile
where $x/@id != 3 and $x/@id != 5
return data($x/nombre),
(:8. Mostrar profesores que den clases de bailes por una cuota mensual.:)
for $x in doc("bailes.xml")/bailes/baile
where $x/precio/@cuota="mensual"
return data($x/profesor),
(:9. Mostrar el nombre de los bailes de la sala 1, que se pague con euros y el precio sea menor a 35.:)
for $x in doc("bailes.xml")/bailes/baile
where number($x/precio)<35
and $x/sala=1
and $x/precio/@moneda="euro"
return data($x/nombre),
(:10. Obtener el precio del baile con el precio más caro.:)
max(for $x in doc("bailes.xml")/bailes/baile
return data($x/precio)),
(:11. Obtener el precio y el nombre del baile con el precio más caro.:)
let $max:= max(for $x in doc("bailes.xml")/bailes/baile
return data($x/precio))
for $x in doc("bailes.xml")/bailes/baile
where $x/precio=$max
return <baile>
  <nombre>{data($x/nombre)}</nombre>
  <precio>{data($x/precio)}</precio>    
</baile>,
(:11. Obtener el precio del baile con el precio menos caro.:)
min(for $x in doc("bailes.xml")/bailes/baile
return data($x/precio)),
(:12. Obtener el precio del baile con el precio menos caro.:)
let $min:= min(for $x in doc("bailes.xml")/bailes/baile
return data($x/precio))
for $x in doc("bailes.xml")/bailes/baile
where $x/precio=$min
return <baile>
  <nombre>{data($x/nombre)}</nombre>
  <precio>{data($x/precio)}</precio>    
</baile>,
(:14. Obtener la suma del precio de todas las clases.:)
sum(for $x in doc("bailes.xml")/bailes/baile
return $x/precio*$x/plazas),
(:15. Obtener la suma del precio de todas las clases, teniendo en cuenta la moneda usada.:)
sum(for $x in doc("bailes.xml")/bailes/baile
where $x/precio/@moneda='euro'
return $x/precio*$x/plazas),
sum(for $x in doc("bailes.xml")/bailes/baile
where $x/precio/@moneda='dolares'
return $x/precio*$x/plazas),
(:16. Obtener el dia, mes y año de los bailes mensuales, tanto del comienzo como del final.:)
for $x in doc("bailes.xml")/bailes/baile
where $x/precio/@cuota='mensual'
return <baile>
          <comienzo>
            <dia>{day-from-date($x/comienzo)}</dia>
            <mes>{month-from-date($x/comienzo)}</mes>
            <año>{year-from-date($x/comienzo)}</año>
          </comienzo>         
           <fin>
            <dia>{day-from-date($x/fin)}</dia>
            <mes>{month-from-date($x/fin)}</mes>
            <año>{year-from-date($x/fin)}</año>
          </fin>
        </baile>,
(:17. Obtener los bailes que tengan mas de 100 dias de diferencia.:)
for $x in doc("bailes.xml")/bailes/baile
where days-from-duration(xs:date($x/fin)-xs:date($x/comienzo))>100
return data($x/nombre),
(:18. Obtener la diferencia de dias del comienzo del baile con la fecha actual.:)
for $x in doc("bailes.xml")/bailes/baile
return days-from-duration(current-date()-xs:date($x/comienzo))