-- Iniciar fisica
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("hybrid")

-- remover barra de notificações
display.setStatusBar (display.HiddenStatusBar)

-- criar sprites
local spriteOpcoes =
{
    frames=
    {
        {-- 1) Asteroide 1
            x=0,
            y=0,
            width=102,
            height=85
        },
        {-- 2) Asteroide 2
            x=0,
            y=85,
            width=90,
            height=83
        },
        {-- 3) Asteroide 3
            x=0,
            y=168,
            width=100,
            height=97
        },
        {-- 4) Nave
            x=0,
            y=265,
            width=98,
            height=79
        },
        {-- 5) Laser
            x=98,
            y=265,
            width=14,
            height=40
        }
    }
}

-- carregar o arquivo da sprite
local sprite = graphics.newImageSheet ("imagens/sprite.png", spriteOpcoes)

-- criar grupos backGroup, mainGroup e UIGroup
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local UIGroup = display.newGroup()

-- incluir background
local bg = display.newImageRect (backGroup, "imagens/bg.png", 800, 1400)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- Inserir o player Nave
local nave = display.newImageRect (mainGroup, sprite, 4, 98, 79)
nave.x = display.contentCenterX
nave.y = display.contentHeight -100
physics.addBody (nave, "dynamic", {radius=30, isSensor=true})
nave.myName = "Nave"

-- criar os placares
local vidas = 3
local pontos = 0
--criar string tabela para asteroides
local asteroidesTable = {}
math.randomseed (os.time()) -- Faz com que os math.randoms não tenham um padrão previsível.
local gameLoopTimer
local morto = false

-- colocar placares na tela
local vidasText = display.newText (UIGroup, "Vidas: " .. vidas, display.contentCenterX-150, display.contentHeight/2*0.1, native.SystemFont, 36)
local pontosText = display.newText (UIGroup, "Pontos: ".. pontos, display.contentCenterX+30, display.contentHeight/2*0.1, native.SystemFont, 36)

-- Função para criar Asteroide
local function criarAsteroide()
    local novoAsteroide = display.newImageRect (mainGroup, sprite, 1, 102, 85)
    -- Incluir o asteroide na tabela
    table.insert (asteroidesTable, novoAsteroide)
    physics.addBody (novoAsteroide, "dynamic", {radius=40, bounce=0.8})
    novoAsteroide.myName = "Asteroide"
    
    local localizacao = math.random (3)
    if (localizacao == 1) then
        novoAsteroide.x = -60
        novoAsteroide.y = math.random (500)
        novoAsteroide:setLinearVelocity (math.random(40,120), math.random(20,60))

    elseif (localizacao == 2) then
        novoAsteroide.x = math.random (display.contentWidth)
        novoAsteroide.y = -60
        novoAsteroide:setLinearVelocity (math.random(-40, 40), math.random(40, 120))
    
    elseif (localizacao == 3) then
        novoAsteroide.x = display.contentWidth + 60
        novoAsteroide.y = math.random (500)
        novoAsteroide:setLinearVelocity (math.random(-120, -40), math.random(20, 60))
    end

    novoAsteroide:applyTorque (math.random (-6, 6))
end

-- criar função atirar
local function atirar ()
    local laser = display.newImageRect (mainGroup, sprite, 5, 14, 40)
    physics.addBody (laser, "dynamic", {isSensor=true})
    laser.isBullet = true
    laser.myName = "Laser"
    laser.x, laser.y = nave.x, nave.y 
    laser:toBack ()

    transition.to (laser, {y=-40, time=500,
                    onComplete = function () display.remove (laser) end})
end

nave:addEventListener ("tap", atirar)

-- função mover nave
local function moverNave (event)

    local nave = event.target
    local phase = event.phase

    if ("began" == phase) then
        -- define a nave como foco do toque.
        display.currentStage:setFocus (nave)
        nave.touchOffsetX = event.x - nave.x
    elseif ("moved" == phase) then
        nave.x = event.x - nave.touchOffsetX
    elseif ("ended" == phase or "cancelled" == phase)
    then
        display.currentStage:setFocus (nil)
    end
    return true
end
nave:addEventListener ("touch", moverNave)
        
-- função aparecer asteroides na tela e excluir os que não vierem na tragetória visivel na tela
local function gameLoop ()
    criarAsteroide()

    for i = #asteroidesTable, 1, -1 do
        local thisAsteroide = asteroidesTable [i]

        if (thisAsteroide.x < -100 or thisAsteroide.x > display.contentWidth + 100 or thisAsteroide.y < -100 or thisAsteroide.y > display.contentHeight +100) then
            display.remove (thisAsteroide)
            table.remove (asteroidesTable, i)
        end
    end
end

gameLoopTimer = timer.performWithDelay (700, gameLoop, 0)

-- função para restaurar a nave
local function restauraNave ()

    nave.isBodyActive = false
    nave.x = display.contentCenterX
    nave.y = display.contentHeight - 100

    transition.to (nave, {alpha=1, time=4000, onComplete = function ()
                                            nave.isBodyActive = true
                                            morto = false
                                            end})
                                        end 

-- inserir colisão entre laser e asteroides
local function onCollision (event)
    if (event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "Laser" and obj2.myName == "Asteroide") or
            (obj1.myName == "Asteroide" and obj2.myName == "Laser")) then
                display.remove (obj1)
                display.remove (obj2)

                for i = #asteroidesTable, 1, -1 do
                    if (asteroidesTable [i] == obj2) then
                        table.remove (asteroidesTable, i)
                        break
                    end -- if asteroidestable
                end -- for
            pontos = pontos + 100
            pontosText.text = "Pontos: " .. pontos

        elseif ((obj1.myName == "Nave" and obj2.myName == "Asteroide") or
                (obj1.myName == "Asteroide" and obj2.myName == "Nave")) then
                if (morto == false) then
                    morto = true    
                    vidas = vidas -1
                    vidasText.text = "Vidas: " .. vidas
                    if (vidas == 0) then
                         display.remove (nave)
                    else
                        nave.alpha = 0

            timer.performWithDelay (1000, restauraNave)
                    end -- if vidas  
            end  -- if morto     
        end -- if myname
    end -- if event.phase
end -- function
Runtime:addEventListener ("collision", onCollision)




                    