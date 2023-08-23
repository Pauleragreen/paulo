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
        composer.gotoScene("gameScene", { effect = "slideLeft", time = 500 })
    end
    return true
end

local function showCredits(sceneGroup)
    -- Adiciona um retângulo semi-transparente como fundo do scroll
    local bgRect = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth - 20, display.contentHeight - 100)
    bgRect:setFillColor(0, 0, 0, 0.65) -- Define a cor e a transparência (alpha) do retângulo

    local scrollView = widget.newScrollView(
        {
            x = display.contentCenterX,
            y = display.contentCenterY,
            width = display.contentWidth - 20,
            height = display.contentHeight - 100,
            backgroundColor = { 0, 0, 0, 0 }, -- Define o scroll como transparente
            horizontalScrollDisabled = true,
            hideScrollBar = false
        }
    )

    local creditsTextOptions = {
        text = [[         
        Recycle Master é um jogo educativo criado para conscientizar e ensinar sobre a importância da reciclagem de forma lúdica e divertida. O jogo combina elementos de basquete com lições valiosas sobre sustentabilidade e proteção ao meio ambiente. Os jogadores embarcam em uma jornada educativa onde devem aprender a separar corretamente os resíduos para reciclagem e utilizar o caminhão de reciclagem para limpar a cidade, promovendo a formação de cidadãos mais conscientes e responsáveis com o nosso planeta.
            

]],
        x = 0,
        y = 10,
        width = display.contentWidth - 20,
        font = native.systemFont,
        fontSize = 18,
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

    local bg_menu7 = display.newImageRect(sceneGroup, "imagens/bg_menu7.png", 928/2, 1312/2.2)
    bg_menu7.x = display.contentCenterX
    bg_menu7.y = display.contentCenterY -40

    local creditsTitle = display.newText(sceneGroup, "Introdução", display.contentCenterX, 30, native.systemFontBold, 24)

    showCredits(sceneGroup)

    local backButton = widget.newButton(
        {
            label = "Voltar",
            fontSize = 18,
            font = native.systemFontBold,
            labelColor = { default = { 255 }, over = { 128 } },
            onEvent = onBackButtonTap
        }
    )
    backButton.x = 30
    backButton.y = display.contentHeight - 20
    sceneGroup:insert(backButton)

    local followButton = widget.newButton(
        {
            label = "Seguir",
            fontSize = 18,
            font = native.systemFontBold,
            labelColor = { default = { 255 }, over = { 128 } },
            onEvent = onFollowButtonTap
        }
    )
    followButton.x = display.contentWidth - 60
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