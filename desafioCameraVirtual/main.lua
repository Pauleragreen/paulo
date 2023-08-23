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

local bg = display.newImageRect ("imagens/bg.png", 1986, 852)
bg.x, bg.y = display.contentCenterX, display.contentCenterY
camera:add (bg, 4)

for i = 0, 4 do
    local chaoFundo = display.newImageRect ("imagens/chao.png", 174, 31)
    chaoFundo.x = -100 + (chaoFundo.width*i)
    chaoFundo.y = 80
    physics.addBody (chaoFundo, "static", {friction=1, box = {x=0, y=0, halfWidth=chaoFundo.width/2, halfHeight=chaoFundo.height/5}})
    camera:add (chaoFundo, 3)
end

for i = 0, 4 do
    local chaoMeio = display.newImageRect ("imagens/chao.png", 174, 31)
    chaoMeio.x = -266 + (128*i)
    chaoMeio.y = 180
    physics.addBody (chaoMeio, "static", {friction=1, box = {x=0, y=0, halfWidth=chaoMeio.width/2, halfHeight=chaoMeio.height/5}})
    camera:add (chaoMeio, 4)
end

for i = 0, 4 do
    local chao = display.newImageRect ("imagens/chao.png",  174, 31)
    chao.x = -266 + (56*i)
    chao.y = 250
    physics.addBody (chao, "static", {friction=1, box = {x=0, y=0, halfWidth=chao.width/2, halfHeight=chao.height/5}})
    camera:add (chao, 2)
end

for i = 0, 4 do
    local chaoPrincipal = display.newImageRect ("imagens/chao.png",  174, 31)
    chaoPrincipal.x = -500 + (chaoPrincipal.width*i)
    chaoPrincipal.y = 380
    chaoPrincipal.id = "chaoPrincipal"
    physics.addBody (chaoPrincipal, "static", {friction=1, box = {x=0, y=0, halfWidth=chaoPrincipal.width/2, halfHeight=chaoPrincipal.height/5}})
    camera:add (chaoPrincipal, 1)
end

local player = scriptPlayer.novo (240, 0)
camera:add (player, 1)


-- efeito parallax trás ilusão de profundidade ao jogo.
-- as posições das vírulas representam os números dos layers
camera:setParallax (1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0)
camera.damping = 10 -- Controla a fluidez da camera ao seguir o player.
camera:setFocus (player) -- Define o player é o foco da câmera.
camera:track() -- inicia a perseguição da camera.