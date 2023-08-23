local physics = require ("physics")
physics.start ()
physics.setGravity (2, 9.8)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local cima = display.newRect (display.contentCenterX, 0, 500, 50)
physics.addBody (cima, "static")
cima.myName = "Teto"

local baixo = display.newRect (display.contentCenterX, 480, 500, 50)
physics.addBody (baixo, "static")
baixo.myName = "Chão"

local esquerda = display.newRect (-15, display.contentCenterY, 50, 500)
physics.addBody (esquerda, "static")
esquerda.myName = "Parede esquerda"

local direita = display.newRect (330, display.contentCenterY, 50, 500)
physics.addBody (direita, "static")
direita.myName = "Parede direita"

local bola1 = display.newImageRect ("imagens/bola1.png", 481*0.2, 518*0.2)
bola1.x = display.contentCenterX
bola1.y = display.contentCenterY
physics.addBody (bola1, {bounce=0.8, radius=48})
bola1.myName = "Bola um"

local bola2 = display.newImageRect("imagens/bola2.png", 500*0.2, 500*0.2)
bola2.x = display.contentCenterX
bola2.y = 100
physics.addBody (bola2, {bounce=0.5, radius=45})
bola2.myName = "Bola dois"

-- Colisão local:
local function collisionLocal (event)
-- se a fase de colisão for igual a began
    if event.phase == "began" then
-- Print da colisão
        print ("Algo colidiu")
-- se não
    else
-- Print d co fim da colisão 
        print ("Fim da colisão")
        end
    end

bola1: addEventListener ("collision", collisionLocal)

-- Colisão Global
local function colisaoGlobal (event)
-- Se a fase de colisão for igual a began então
    if (event.phase == "began" ) then

        print ("Began: " .. event.object1.myName .. "e " .. event.object2.myName)

    elseif (event.phase == "ended") then

        print ("Ended: ".. event.object1.myName.. "e ".. event.object2.myName)

    end
end
    
Runtime:addEventListener ("collision", colisaoGlobal)

-- função mudar de cor da bola1 ao colidir com a bola2
local function mudarCorBola1 (event)
    if (event.phase == "began") then
        bola1.fill = {0, 0, 1}
        elseif (event.phase == "ended") then
            bola1.fill = {1, 0, 0}
            end
            end
            bola1: addEventListener ("collision", mudarCorBola1)
            -- função mudar de cor da bola2 ao colidir com a bola1

local function mudarCorBola2 (event)
    if (event.phase == "began") then
        bola2.fill = {0, 0, 1}
        elseif (event.phase == "ended") then
            bola2.fill = {243, 130, 89}
            end
            end
            bola2: addEventListener ("collision", mudarCorBola2)

 Runtime:addEventListener ("collision", colisaoGlobal)


