local composer = require("composer")
local scene = composer.newScene()

local cestas = {}
local personagem
local bolaEmMaos
local pontuacao = 0
local pontuacaoText
local vidas = 3
local vidasText

local function gerarBolaAleatoria(sceneGroup)
    local bolas = { "imagens/sacoazul.png", "imagens/sacoverde.png", "imagens/sacoamarelo.png", "imagens/sacomarrom.png"}
    local bolaAleatoria = bolas[math.random(1, #bolas)]
    
    local function isBolaPapel(bola)
        return bola == "imagens/sacoazul.png" or bola == "imagens/sacoazul.png"
    end
    
    if isBolaPapel(bolaAleatoria) then
        local chanceBolaPapel1 = 0.2 -- 20% de chance de ser "bola_papel1.png"
        if math.random() <= chanceBolaPapel1 then
            bolaAleatoria = "imagens/sacoazul.png"
        end
    end
    
    local bola = display.newImageRect(sceneGroup, bolaAleatoria, 60, 60)
    bola.x = 180
    bola.y = display.contentHeight - 120
    bola.tipo = bolaAleatoria
    return bola
end

local function onCestaTap(event)
    local cesta = event.target
    if bolaEmMaos then
        if cesta.bolaCorreta == bolaEmMaos.tipo or cesta.bolaCorreta == bolaEmMaos.tipo:gsub("1", "") then
            pontuacao = pontuacao + 10
            pontuacaoText.text = "Pontuação: " .. pontuacao
            
            if pontuacao >= 100 then
                composer.gotoScene("congratulationsScene", { effect = "fade", time = 500 })
            end
            
            transition.to(bolaEmMaos, { x = cesta.x, y = cesta.y, time = 700, onComplete = function()
                bolaEmMaos:removeSelf()
                bolaEmMaos = nil
                bolaEmMaos = gerarBolaAleatoria(scene.view)
                
                local randomIndex = math.random(1, #cestas)
                cestas[randomIndex], cestas[#cestas] = cestas[#cestas], cestas[randomIndex]
                
                local positions = { display.contentCenterX - 120, display.contentCenterX - 40, display.contentCenterX + 40, display.contentCenterX + 120 }
                for i = 1, #cestas do
                    cestas[i].x = positions[i]
                end
            end })
        else
            vidas = vidas - 1
            vidasText.text = "Vidas: " .. vidas

            if vidas <= 0 then
                composer.gotoScene("gameOverScene03", { effect = "fade", time = 500 })
            else
                local touchX, touchY = event.x, event.y
                
                transition.to(bolaEmMaos, { x = touchX, y = touchY, time = 700, onComplete = function()
                    bolaEmMaos:removeSelf()
                    bolaEmMaos = nil
                    bolaEmMaos = gerarBolaAleatoria(scene.view)
                    
                    local randomIndex = math.random(1, #cestas)
                    cestas[randomIndex], cestas[#cestas] = cestas[#cestas], cestas[randomIndex]
                    
                    local positions = { display.contentCenterX - 120, display.contentCenterX - 40, display.contentCenterX + 40, display.contentCenterX + 120 }
                    for i = 1, #cestas do
                        cestas[i].x = positions[i]
                    end
                end })
            end
        end
    end
end


local function onBolaTap(event)
    if not bolaEmMaos then
        bolaEmMaos = event.target
        transition.to(bolaEmMaos, { x = display.contentCenterX, y = display.contentCenterY, time = 500 })
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local bg2_gameScene03 = display.newImageRect(sceneGroup, "imagens/bg2_gameScene03.jpg", 1024/2.5, 1024/2)
    bg2_gameScene03.x = display.contentCenterX 
    bg2_gameScene03.y = display.contentCenterY

    local cestaLata = display.newImageRect(sceneGroup, "imagens/cacambaamarela.png", 270/3, 217/2.4)
    cestaLata.x = display.contentCenterX - 120
    cestaLata.y = 280
    cestaLata.bolaCorreta = "imagens/sacoamarelo.png"
    cestaLata:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaLata)

    local cestaBanana = display.newImageRect(sceneGroup, "imagens/cacambamarrom.png", 270/3, 217/2.4)
    cestaBanana.x = display.contentCenterX - 40
    cestaBanana.y = 280
    cestaBanana.bolaCorreta = "imagens/sacomarrom.png"
    cestaBanana:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaBanana)

    local cestaPapel = display.newImageRect(sceneGroup, "imagens/cacambaazul.png", 270/3, 217/2.4)
    cestaPapel.x = display.contentCenterX + 40
    cestaPapel.y = 280
    cestaPapel.bolaCorreta = "imagens/sacoazul.png"
    cestaPapel:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaPapel)

    local cestaVidro = display.newImageRect(sceneGroup, "imagens/cacambaverde.png", 270/3, 217/2.4)
    cestaVidro.x = display.contentCenterX + 120
    cestaVidro.y = 280
    cestaVidro.bolaCorreta = "imagens/sacoverde.png"
    cestaVidro:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaVidro)

    bolaEmMaos = gerarBolaAleatoria(sceneGroup)
    bolaEmMaos:addEventListener("tap", onBolaTap)
    
    personagem = display.newImageRect(sceneGroup, "imagens/truck02.png", 618/3.8, 311/3.8)
    personagem.x = display.contentCenterX 
    personagem.y = display.contentHeight - 50

    local pontuacaoOptions = {
        text = "Pontuação: " .. pontuacao,
        x = display.contentCenterX,
        y = 20,
        width = display.actualContentWidth,
        font = native.systemFontBold,
        fontSize = 20,
        align = "center",
    }
    
    pontuacaoText = display.newText(pontuacaoOptions)
    pontuacaoText:setFillColor(1, 1, 1)
    sceneGroup:insert(pontuacaoText)

    local vidasTextOptions = {
        text = "Vidas: " .. vidas,
        x = display.contentCenterX,
        y = 50,
        width = display.actualContentWidth,
        font = native.systemFontBold,
        fontSize = 20,
        align = "center",
    }
    
    vidasText = display.newText(vidasTextOptions)
    vidasText:setFillColor(1, 1, 1)
    sceneGroup:insert(vidasText)
end

function scene:show(event)
    local phase = event.phase
    if phase == "did" then
        -- código para mostrar a cena
    end
end

function scene:hide(event)
    local phase = event.phase
    if phase == "will" then
        -- código para ocultar a cena
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    if personagem then
        personagem:removeSelf()
        personagem = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene