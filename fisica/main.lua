-- Física
-- Chamar a biblioteca: atribuir a biblioteca interna de fisica a variável physics.
local physics = require ("physics")
-- Iniciar a fisica no projeto:
physics.start ()
-- Definir a gravidade do projeto: Definimos a gravidade x e y do projeto.
physics.setGravity (0, 9.8)
-- Definir a renderização da visualização da fisica (usado somente durante o desenvolvimento para testes)
-- Modos: normal: Aparece apenas as imagens, corpos fisicos invisiveis (padrão do sistema), hybrid: Mostra as imagens e os corpos fisicos, debug: Mostra apenas os corpos fisicos.
physics.setDrawMode ("hybrid")

-- Adicionando objetos fisicos:
local retangulo = display.newRect (150, display.contentCenterY, 150,100)
-- Corpo dinâmico: interage com a gravidade e colide com todos os corpos.
physics.addBody (retangulo, "dynamic")

local chao = display.newRect (display.contentCenterX, 400, 450, 30)
-- Corpo estático: não se movimenta e colide apenas com dinâmico
physics.addBody (chao, "static")

local circulo = display.newCircle (300, 50, 30)       
-- Corpo cinemático: não interage com a gravidade e colide apenas com dinâmico
physics.addBody (circulo, "kinematic", {radius=30})

local quadrado = display.newRect (display.contentCenterX, 0, 50, 50)
physics.addBody (quadrado, "dynamic", {bounce=1, friction=0, density=0})
--Aplicando o torque adiciona rotação em torno do próprio eixo. Valor positivo gira no sentido horário e negativo sentido anti-horario
quadrado:applyTorque (-9)
