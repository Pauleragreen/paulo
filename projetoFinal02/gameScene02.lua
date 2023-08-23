local composer = require("composer")
local scene = composer.newScene()

local truck
local trashGroup = {}
local trashTimer
local score = 0
local lives = 3
local scoreText
local livesText

local function moveTruck()
    local targetX
    if truck.x < display.contentWidth * 0.5 then
        targetX = display.contentWidth - truck.width * 0.5
    else
        targetX = truck.width * 0.5
    end
    transition.to(truck, { x = targetX, time = 2000, onComplete = moveTruck })
end

local function onTrashCollected(trash)
    for i = #trashGroup, 1, -1 do
        if trashGroup[i] == trash then
            trashGroup[i]:removeSelf()
            table.remove(trashGroup, i)
            score = score + 10
            scoreText.text = "Score: " .. score
            break
        end
    end

    if score >= 100 then
        composer.gotoScene("introScene03")
    end
end

local function onTrashMissed(trash)
    for i = #trashGroup, 1, -1 do
        if trashGroup[i] == trash then
            trashGroup[i]:removeSelf()
            table.remove(trashGroup, i)
            lives = lives - 1
            livesText.text = "Lives: " .. lives
            break
        end
    end
end

local function createTrash()
    local trashTypes = { "imagens/sacoazul.png", "imagens/sacoverde.png", "imagens/sacoamarelo.png", "imagens/sacomarrom.png"}
    local trashType = trashTypes[math.random(1, #trashTypes)]
    local trash = display.newImageRect(scene.view, trashType, 50, 50)

    trash.x = math.random(trash.width * 0.5, display.contentWidth - trash.width * 0.5)
    trash.y = -trash.height * 0.5

    table.insert(trashGroup, trash)

    local targetY = display.contentHeight + trash.height * 0.5
    local transitionTime = 2700 + math.random(1000)
    transition.to(trash, { y = targetY, time = transitionTime, onComplete = function()
        if lives > 0 then
            onTrashMissed(trash)
        else
            composer.gotoScene("gameOverScene")
        end
    end })
end

local function checkCollisions()
    for i = #trashGroup, 1, -1 do
        local trash = trashGroup[i]
        if trash and truck then
            local truckBounds = truck.contentBounds
            local trashBounds = trash.contentBounds

            if truckBounds.xMax > trashBounds.xMin and truckBounds.xMin < trashBounds.xMax and
               truckBounds.yMax > trashBounds.yMin and truckBounds.yMin < trashBounds.yMax then
                onTrashCollected(trash)
            elseif trash.y > display.contentHeight then
                onTrashMissed(trash)
            end
        end
    end
end

local prevX = 0
local prevTime = 0

local function onTruckTouch(event)
    local phase = event.phase
    if phase == "began" or phase == "moved" then
        -- Mover o caminhão para a posição do toque, mas limitar dentro da tela
        local newX = event.x
        if newX < truck.width * 0.4 then
            newX = truck.width * 0.4
        elseif newX > display.contentWidth - truck.width * 0.4 then
            newX = display.contentWidth - truck.width * 0.4
        end
        truck.x = newX
    end
end

local function gameLoop()
    -- Verificar colisões em intervalos regulares
    checkCollisions()
end

function scene:create(event)
    local sceneGroup = self.view

    -- Criação do plano de fundo (background)
    local street2 = display.newImageRect(sceneGroup, "imagens/street2.jpg", 1024/2, 1024/2)
    street2.x = display.contentCenterX 
    street2.y = display.contentCenterY

    local logo_cpdi2 = display.newImageRect(sceneGroup, "imagens/logo_cpdi2.png", 666/2, 375/2)
    logo_cpdi2.x = 315
    logo_cpdi2.y = 330

    truck = display.newImageRect(sceneGroup, "imagens/truck.png", 2500/14, 907/14)
    truck.x = display.contentWidth * 0.2
    truck.y = display.contentHeight - truck.height * 1.5
    truck.rotation = 89

    scoreText = display.newText(sceneGroup, "Score: " .. score, display.contentWidth * 0.5, 30, native.systemFontBold, 24)
    livesText = display.newText(sceneGroup, "Vidas: " .. lives, display.contentWidth * 0.5, 70, native.systemFontBold, 24)

    truck:addEventListener("touch", onTruckTouch)

    -- Adicionar o event listener para o loop do jogo
    Runtime:addEventListener("enterFrame", gameLoop)

    trashTimer = timer.performWithDelay(1000, createTrash, 0)
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        if (trashTimer) then
            timer.cancel(trashTimer)
            trashTimer = nil
        end
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    truck:removeEventListener("touch", onTruckTouch)
    truck:removeSelf()
    truck = nil

    -- Remover o event listener do loop do jogo
    Runtime:removeEventListener("enterFrame", gameLoop)

    for i = #trashGroup, 1, -1 do
        if trashGroup[i] then
            trashGroup[i]:removeSelf()
            table.remove(trashGroup, i)
        end
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene