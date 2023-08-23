local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local function onBackButtonTap(event)
    if (event.phase == "ended") then
        composer.gotoScene("principal", { effect = "slideRight", time = 500 })
    end
    return true
end

local function onFollowButtonTap(event)
    if (event.phase == "ended") then
        composer.gotoScene("gameScene02", { effect = "slideLeft", time = 500 })
    end
    return true
end

local function showCredits(sceneGroup)
    
    local bgRect = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth - 20, display.contentHeight - 100)
    bgRect:setFillColor(0, 0, 0, 0.8) 

    local scrollView = widget.newScrollView(
        {
            x = display.contentCenterX,
            y = display.contentCenterY,
            width = display.contentWidth - 20,
            height = display.contentHeight - 100,
            backgroundColor = { 0, 0, 0, 0 }, 
            horizontalScrollDisabled = true,
            hideScrollBar = false
        }
    )

    local creditsTextOptions = {
        text = [[         
            Bem-vindo à segunda fase! Nesta etapa, mergulhamos fundo em uma atividade vital para manter nossas cidades limpas e nosso meio ambiente saudável: a coleta de lixo com o caminhão de lixo. Como motoristas virtuais deste caminhão, temos a importante tarefa de coletar o lixo reciclável que está caindo das ruas e contribuir para um mundo mais limpo e sustentável.

A coleta de lixo desempenha um papel essencial em nossa sociedade, assegurando que os resíduos sejam descartados adequadamente e direcionados para reciclagem. É uma ação crucial para preservar nossos recursos naturais, prevenir a poluição e criar um ambiente mais saudável para todos. Nossa missão agora é coletar o lixo reciclável que está caindo, certificando-nos de que ele seja depositado no caminhão de coleta e encaminhado para reciclagem adequada.

Cada peça de lixo coletada representa um passo em direção a um planeta mais limpo e sustentável. Quando você tocar no caminhão e movê-lo para coletar o lixo que cai das ruas, você está desempenhando um papel ativo na promoção da reciclagem e na redução do desperdício. Cada pedaço de lixo coletado contribui para a conservação de recursos valiosos e a diminuição do impacto ambiental negativo.

Lembre-se de que, à medida que você coleta o lixo, ganha pontos para cada peça coletada com sucesso. Com cada vitória, estamos um passo mais perto de alcançar a pontuação necessária para avançar para a próxima fase emocionante do jogo. No entanto, tenha cuidado para não perder nenhum lixo, pois cada pedaço que cai sem ser coletado resultará na perda de uma vida.

Junte-se a nós nessa jornada de coleta de lixo e reciclagem, onde sua participação é vital para o sucesso da missão. Vamos nos unir como jogadores comprometidos e defensores do meio ambiente, e mostrar que pequenos gestos, como coletar o lixo com o caminhão, podem fazer uma grande diferença para um futuro mais sustentável.

Vamos começar a coleta de lixo com determinação e empolgação, lembrando que cada peça de lixo coletada nos aproxima do nosso objetivo de pontuação e nos ajuda a avançar para desafios ainda maiores na próxima fase. Sua contribuição é inestimável, e juntos, podemos tornar o mundo um lugar mais limpo, mais verde e mais saudável. Boa sorte na sua missão de coleta de lixo e avanço para a próxima etapa!
            

]],
        x = 0,
        y = 10,
        width = display.contentWidth - 20,
        font = native.systemFont,
        fontSize = 14,
        align = "left"
    }

    local creditsText = display.newText(creditsTextOptions)
    creditsText.anchorX, creditsText.anchorY = 0, 0
    creditsText:setFillColor(255, 255, 255) 
    scrollView:insert(creditsText)

    sceneGroup:insert(scrollView)
end

function scene:create(event)
    local sceneGroup = self.view

    local bg_menu777 = display.newImageRect(sceneGroup, "imagens/bg_menu777.png", 1024/1.8, 1024/1.8)
    bg_menu777.x = display.contentCenterX
    bg_menu777.y = display.contentCenterY -40

    local logo_cpdi3 = display.newImageRect(sceneGroup, "imagens/logo_cpdi3.png", 548/2, 456/2)
    logo_cpdi3.x = display.contentCenterX
    logo_cpdi3.y = 200

    local creditsTitle = display.newText(sceneGroup, "Bem-Vindos a Segunda Fase", display.contentCenterX, 30, native.systemFontBold, 24)
    creditsTitle:setFillColor(0, 0, 0)

    showCredits(sceneGroup)

    local backButton = widget.newButton(
        {
            label = "Voltar",
            fontSize = 22,
            font = native.systemFontBold,
            labelColor = { default = { 0 }, over = { 128 } },
            onEvent = onBackButtonTap
        }
    )
    backButton.x = 30
    backButton.y = display.contentHeight - 20
    sceneGroup:insert(backButton)

    local followButton = widget.newButton(
        {
            label = "Seguir",
            fontSize = 22,
            font = native.systemFontBold,
            labelColor = { default = { 0 }, over = { 128 } },
            onEvent = onFollowButtonTap
        }
    )
    followButton.x = display.contentWidth - 30
    followButton.y = display.contentHeight - 20
    sceneGroup:insert(followButton)
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        if (sceneGroup.scrollView) then
            sceneGroup.scrollView:removeSelf()
            sceneGroup.scrollView = nil
        end
    end
end

function scene:show(event)
    local phase = event.phase

    if (phase == "will") then
        local sceneGroup = self.view
        if (sceneGroup.scrollView) then
            sceneGroup.scrollView.isVisible = true
        end
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("show", scene)

return scene