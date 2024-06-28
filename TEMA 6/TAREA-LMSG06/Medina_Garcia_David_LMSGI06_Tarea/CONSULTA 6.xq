(:Modelo de las impresoras de tipo “matricial”.:)
for $x in doc("impresoras.xml")/impresoras/impresora
where $x/@tipo="matricial"
return $x/modelo