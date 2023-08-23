local scriptPlayer = require ("Player")
local perspective = require ("perspective")
local physics = require ("physics")

physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("normal")

-- Criar Camera Virtual
local camera = perspective.createView()
camera:prependLayer () -- prepara os layer da camera

display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/bg.jpg", 509, 360)
bg.x, bg.y = display.contentCenterX, display.contentCenterY
camera:add (bg, 8) -- adiciona a imagem ao layer específico.

local sol = display.newImageRect ("imagens/sun.png", 96, 96)
sol.x = 400
sol.y = 20
camera:add (sol, 7)

for i = 0, 4 do
    local nuvens = display. newImageRect ("imagens/cloud.png", 920*0.2, 384*0.2)
    nuvens.x = 128*i
    nuvens.y = math.random (-60, 60)
    nuvens.alpha = 0.8
    camera:add (nuvens, 7)
end

for i = 0, 3 do
    local nuvem = display.newImageRect ("imagens/cloud.png", 902*0.2, 384*0.2)
    nuvem.x = 128*i
    nuvem.y = math.random (-160, 160)
    nuvem.alpha = 0.7
    camera:add (nuvem, 6)
end

for i = 0, 4 do
    local chaoFundo = display.newImageRect ("imagens/chao.png", 4503*0.15, 613*0.15)
    chaoFundo.x = -256 + (chaoFundo.width*i)
    chaoFundo.y = 210
    camera:add (chaoFundo, 6)
end

for i = 0, 6 do
    local arvoreFundo = display.newImageRect ("imagens/tree.png", 96, 96)
    arvoreFundo.x = -256 + (128*i)
    arvoreFundo.y = 140
    camera:add (arvoreFundo, 6)
end

for i = 0, 4 do
    local chaoMeio = display.newImageRect ("imagens/chao.png", 4503*0.15, 613*0.15)
    chaoMeio.x = -266 + (128*i)
    chaoMeio.y = 180
    camera:add (chaoMeio, 4)
end

for i = 0, 6 do
    local arvoreMeio = display.newImageRect ("imagens/tree.png", 96, 96)
    arvoreMeio.x = -256 + (128*i)
    arvoreMeio.y = 180
    camera:add (arvoreMeio, 4)
end

for i = 0, 4 do
    local chao = display.newImageRect ("imagens/chao.png", 4503*0.15, 613*0.15)
    chao.x = -266 + (chao.width*i)
    chao.y = 290
    chao.id = "chao"
    physics.addBody (chao, "static", {friction=1, box = {x=0, y=0, halfWidth=chao.width/2, halfHeight=chao.height/5}})
    camera:add (chao, 1)
end

for i = 0, 6 do
    local arvore = display.newImageRect ("imagens/tree.png", 96, 96)
    arvore.x = - 234 + (128*i)
    arvore.y = 220
    camera:add (arvore, 1)
end

local player = scriptPlayer.novo (240, 0)
camera:add (player, 1)


-- efeito parallax trás ilusão de profundidade ao jogo.
-- as posições das vírulas representam os números dos layers
camera:setParallax (1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0)
camera.damping = 10 -- Controla a fluidez da camera ao seguir o player.
camera:setFocus (player) -- Define o player é o foco da câmera.
camera:track() -- inicia a perseguição da camera.