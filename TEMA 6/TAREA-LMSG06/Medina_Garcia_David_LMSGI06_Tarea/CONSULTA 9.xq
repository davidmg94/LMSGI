(:Marca y modelo de las impresoras con tamaño A5 como único tamaño.:)
(:No obtenemos ningún resultado pues ninguna impresora tiene como tamaño único el A5:)
for $x in doc("impresoras.xml")/impresoras/impresora
where count($x/tamaño) = 1 and $x/tamaño = 'A5'
return <impresora>{$x/marca,$x/modelo}</impresora>
