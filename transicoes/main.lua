local circulo = display.newCircle (80, 50, 30)
-- Transições
-- Comandos: transition.to (variável, {parâmetros})
transition.to (circulo, {time=3000, y=400})
circulo: setFillColor (0.3, 0.2, 0.7)

local circulo1 = display.newCircle (150, 50, 30)
transition.to (circulo1, {time=3000, y=400, delta=true})

local circulo2 = display.newCircle (220, 50, 30)
transition.to (circulo2, {time=3000, y=400, iterations=4, transition=easing.outElastic} )

local circulo3 = display.newCircle (290, 50, 30)
transition.to (circulo3, {time=3000, y=400, iterations=4, transition=easing.inOutBounce})

local retangulo = display.newRect (200, 250, 50, 70)
transition.to (retangulo, {time=3000, rotation=90, yScale=2, aplha=0.5, iterations=-1})



