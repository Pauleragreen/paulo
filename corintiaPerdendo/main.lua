local physics = require ("physics")
physics.start ()
physics.setGravity(0, 0)
physics.setDrawMode ("normal")

display.setStatusBar(display.HiddenStatusBar)

local grupoBg = display.newGroup() 
local grupoMain = display.newGroup() 
local grupoUI = display.newGroup()

local gols = 0

local bg = display.newImageRect (grupoBg, "imagens/campo.jpg", 650, 400*1.6)
bg.x = display.contentCenterX 
bg.y = 160

local golsText = display.newText (grupoUI, "Gols: " .. gols, 50, 30, native.systemFont, 20)

golsText:setFillColor (1, 1, 1)

local player = display.newImageRect (grupoMain, "imagens/time.png", 249/1.5, 324/1.5)
player.x = display.contentCenterX
player.y =  370
player.myName = "Time"
physics.addBody (player, "kinematic")

local botaoEsquerda = display.newImageRect (grupoMain, "imagens/button.png", 1280/30, 1279/30)
botaoEsquerda.x = 290
botaoEsquerda.y = 460


local botaoDireita = display.newImageRect (grupoMain, "imagens/button.png", 1280/30, 1279/30)
botaoDireita.x = 20
botaoDireita.y = 460
botaoDireita.rotation = 180

local function esquerda ()
    player.x = player.x + 40
end

local function direita ()
    player.x = player.x - 40
end

botaoEsquerda:addEventListener ("tap", esquerda)
botaoDireita:addEventListener ("tap", direita)

local botaoTiro = display.newImageRect (grupoMain, "imagens/botaotiro.png", 260/4, 260/4)
botaoTiro.x = display.contentCenterX
botaoTiro.y = 460

local meta = display.newImageRect (grupoMain, "imagens/gol.png", 397/2, 146/2)
meta.x = display.contentCenterX
meta.y = 205
meta.myName = "Gol"
physics.addBody (meta, "static")

local inimigo = display.newImageRect (grupoMain, "imagens/goleiro.png", 275/3.5, 183/3.5)
inimigo.x = display.contentCenterX
inimigo.y = 220
inimigo.myName = "Cassio"
physics.addBody (inimigo, "kinematic")
local direcaoInimigo = "esquerda"

local function atirar ()
    
    local tiroPlayer = display.newImageRect (grupoMain, "imagens/bola.png", 225/8, 225/8)
    
    tiroPlayer.x = player.x
    tiroPlayer.y = player.y +50

    physics.addBody (tiroPlayer, "dynamic", {bounce=1, friction=0, density=0, isSensor=true})

    transition.to (tiroPlayer, {y=100, time=900, 
                    onComplete = function () display.remove (tiroPlayer)
                    end})
    tiroPlayer.myName = "Chute"
end


botaoTiro: addEventListener ("tap", atirar)

local function moverInimigo ()
    
        if not (inimigo.y == nil) then
    
            if (direcaoInimigo == "esquerda") then
                inimigo.x = inimigo.x - 1
    
                if (inimigo.x <=90 ) then
                
                    direcaoInimigo = "direita"
                end 
    
            elseif (direcaoInimigo == "direita") then
                    inimigo.x = inimigo.x + 1
   
                if (inimigo.x >= 240) then
                        direcaoInimigo = "esquerda"
                end 
            end 
        else
            print ("Inimigo morreu!")
            
    end
end
Runtime: addEventListener ("enterFrame", moverInimigo)

local function onCollision (event)
    
        if (event.phase == "began") then
    
            local obj1 = event.object1
            local obj2 = event.object2
            
            if ((obj1.myName == "Chute" and obj2.myName == "Gol") or (obj1.myName == "Gol" and obj2.myName == "Chute")) then
               
                if (obj1.myName == "Chute") then
                
                    display.remove (obj1)
                else
                    display.remove (obj2)
                end
    
                gols = gols + 1
                golsText.text = "Gols: " .. gols
            end 
        end 
    end 

Runtime:addEventListener ("collision", onCollision)

local function onCollision (event)
    
    if (event.phase == "began") then

        local obj1 = event.object1
        local obj2 = event.object2
        
        if ((obj1.myName == "Chute" and obj2.myName == "Cassio") or (obj1.myName == "Cassio" and obj2.myName == "Chute")) then
           
            if (obj1.myName == "Chute") then
            
                display.remove (obj1)
            else
                display.remove (obj2)
            end

        end 
    end 
end 
Runtime:addEventListener ("collision", onCollision)

