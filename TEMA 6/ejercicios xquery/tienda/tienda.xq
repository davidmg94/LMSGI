(:1	Obtener el nombre de todos los clientes:)
for $x in doc("tienda.xml")/tienda/clientes/cliente
return data($x/nombre),
(:2	Obtener el nombre de todos los clientes de Alicante:)
for $x in doc("tienda.xml")/tienda/clientes/cliente
where $x/ciudad ='Alicante'
return data($x/nombre),
(:3	Obtener el nombre de todos los clientes ordenado descendentemente por nombre:)
for $x in doc("tienda.xml")/tienda/clientes/cliente
order by $x/nombre descending
return data($x/nombre),
(:4	Obtener todos los códigos de los artículos que ha comprado el cliente 22:)
for $compra in doc("tienda")/tienda/compras/compra
for $art in doc("tienda")/tienda/articulos/articulo
where $compra/@idcliente="_22" and $compra/@codigo=$art/@codigo
return 
<articulos>{'codigo:',data($art/@codigo)}, modelo: {data($art/modelo)}, marca: {data($art/marca)}</articulos>,
(:6	¿Cuántos clientes hay?:)
for $x in doc("tienda.xml")/tienda/clientes
return count($x/cliente),
(:7	¿Cuántas ventas se han hecho por un precio de más de 300 euros?:)
let $x := doc("tienda")/tienda/compras/compra[precio > 300]
return count($x),
(:8	Obtener un listado con los clientes de Alicante, junto con los modelos de los artículos que ha comprado y sus unidades:)
for $compra in doc("tienda")/tienda/compras/compra
for $art in doc("tienda")/tienda/articulos/articulo
for $cli in doc("tienda")/tienda/clientes/cliente
where $compra/@codigo=$art/@codigo and $compra/@idcliente=$cli/@idcliente and $cli/ciudad='Alicante'
return <listado>{$cli/@nombre} {$art/@codigo} {$art/modelo}</listado>,
(:9	Obtener los nombres de los clientes que han hecho compras por más de 300 euros:)
let $clientes := doc("tienda.xml")/tienda/clientes/cliente
let $compras := doc("tienda.xml")/tienda/compras/compra[precio > 300]
for $compra in $compras
let $cliente := $clientes[@idcliente = $compra/@idcliente]
return $cliente/nombre