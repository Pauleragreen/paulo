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
    local bolas = { "imagens/bola_lata1.png", "imagens/bola_banana.png", "imagens/bola_papel.png", "imagens/bola_vidro.png", "imagens/bola_papel1.png" }
    local bolaAleatoria = bolas[math.random(1, #bolas)]
    
    local function isBolaPapel(bola)
        return bola == "imagens/bola_papel.png" or bola == "imagens/bola_papel1.png"
    end
    
    if isBolaPapel(bolaAleatoria) then
        local chanceBolaPapel1 = 0.2 -- 20% de chance de ser "bola_papel1.png"
        if math.random() <= chanceBolaPapel1 then
            bolaAleatoria = "imagens/bola_papel1.png"
        end
    end
    
    local bola = display.newImageRect(sceneGroup, bolaAleatoria, 70, 70)
    bola.x = display.contentCenterX
    bola.y = display.contentHeight - 220
    bola.tipo = bolaAleatoria
    return bola
end

local function onCestaTap(event)
    local cesta = event.target
    if bolaEmMaos then
        if cesta.bolaCorreta == bolaEmMaos.tipo or cesta.bolaCorreta == bolaEmMaos.tipo:gsub("1", "") then
            if cesta.bolaCorreta == "imagens/bola_papel.png" or cesta.bolaCorreta == "imagens/bola_papel1.png" then
                pontuacao = pontuacao + 10
                pontuacaoText.text = "Pontuação: " .. pontuacao
            elseif cesta.bolaCorreta ~= "imagens/bola_papel1.png" then
                pontuacao = pontuacao + 10
                pontuacaoText.text = "Pontuação: " .. pontuacao
            end
            
            -- Verifica se a pontuação é maior ou igual a 100 para ir para a fase 2 (gameScene02)
            if pontuacao >= 100 then
                composer.gotoScene("gameScene02", { effect = "fade", time = 500 })
            end
            
            bolaEmMaos:removeSelf()
            bolaEmMaos = nil
            bolaEmMaos = gerarBolaAleatoria(scene.view)

            local randomIndex = math.random(1, #cestas)
            cestas[randomIndex], cestas[#cestas] = cestas[#cestas], cestas[randomIndex]

            local positions = { display.contentCenterX - 120, display.contentCenterX - 40, display.contentCenterX + 40, display.contentCenterX + 120 }
            for i = 1, #cestas do
                cestas[i].x = positions[i]
            end
        else
            vidas = vidas - 1
            vidasText.text = "Vidas: " .. vidas

            if vidas <= 0 then
                composer.gotoScene("gameOverScene", { effect = "fade", time = 500 })
            end
        end
    end
end

local function onBolaTap(event)
    if not bolaEmMaos then
        bolaEmMaos = event.target
        bolaEmMaos.x = display.contentCenterX
        bolaEmMaos.y = display.contentCenterY
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local bg = display.newImageRect(sceneGroup, "imagens/quadra2.jpg", 1024/2, 1024/2)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    local cestaLata = display.newImageRect(sceneGroup, "imagens/cestaLata.png", 140/2, 288/2)
    cestaLata.x = display.contentCenterX - 120
    cestaLata.y = 240
    cestaLata.bolaCorreta = "imagens/bola_lata1.png"
    cestaLata:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaLata)

    local cestaBanana = display.newImageRect(sceneGroup, "imagens/cestaBanana.png", 140/2, 288/2)
    cestaBanana.x = display.contentCenterX - 40
    cestaBanana.y = 240
    cestaBanana.bolaCorreta = "imagens/bola_banana.png"
    cestaBanana:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaBanana)

    local cestaPapel = display.newImageRect(sceneGroup, "imagens/cestaPapel.png", 140/2, 288/2)
    cestaPapel.x = display.contentCenterX + 40
    cestaPapel.y = 240
    cestaPapel.bolaCorreta = "imagens/bola_papel.png"
    cestaPapel:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaPapel)

    local cestaVidro = display.newImageRect(sceneGroup, "imagens/cestaVidro.png", 140/2, 288/2)
    cestaVidro.x = display.contentCenterX + 120
    cestaVidro.y = 240
    cestaVidro.bolaCorreta = "imagens/bola_vidro.png"
    cestaVidro:addEventListener("tap", onCestaTap)
    table.insert(cestas, cestaVidro)

    bolaEmMaos = gerarBolaAleatoria(sceneGroup)
    bolaEmMaos:addEventListener("tap", onBolaTap)
    
    personagem = display.newImageRect(sceneGroup, "imagens/player.png", 500, 500)
    personagem.x = display.contentCenterX - 60
    personagem.y = display.contentHeight - 90 

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
    pontuacaoText:setFillColor(0, 0, 0)
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
    vidasText:setFillColor(0, 0, 0)
    sceneGroup:insert(vidasText)
end

scene:addEventListener("create", scene)

function scene:destroy(event)
    local sceneGroup = self.view

    if personagem then
        personagem:removeSelf()
        personagem = nil
    end
end

scene:addEventListener("destroy", scene)

return scene