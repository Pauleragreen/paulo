local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local function onBackButtonTap(event)
    if (event.phase == "ended") then
        composer.gotoScene("principal", { effect = "slideRight", time = 500 })
    end
    return true
end

local function showCredits(sceneGroup)
    -- Adiciona um retângulo semi-transparente como fundo do scroll
    local bgRect = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth - 20, display.contentHeight - 100)
    bgRect:setFillColor(0, 0, 0, 0.85) -- Define a cor e a transparência (alpha) do retângulo

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
        text = [[Equipe de Desenvolvimento:

Rodrigo da Gama
Flavia de Souza
Alexandre Tourinho
Matheus Moraes
Paulo Roberto Nunes da Cruz

Recursos Utilizados:

Linguagem de Programação: Lua
Motor de Jogo: Solar 2D
Software de Design: Affinity Photo
Software de Edição de Som: Filmora 12

Agradecimentos:

CPDI - Comitê para Democratização da Informática
Professora: Juliana Oliveira
Cordenadora: Cleusa Kreusch
Assistente Social: Neida]],
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
    logo_cpdi3.y = display.contentCenterY

    local creditsTitle = display.newText(sceneGroup, "Créditos", display.contentCenterX, 30, native.systemFontBold, 24)
    creditsTitle:setFillColor(0, 0, 0)

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
