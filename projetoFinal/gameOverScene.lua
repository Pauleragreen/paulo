local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Função para redefinir o estado do jogo
local function resetGame()
    -- Adicione aqui o código para redefinir as variáveis de estado do jogo
    -- Por exemplo: pontuações, vidas, níveis, etc.
    composer.removeScene("gameScene") -- Remove a cena do jogo atual para reiniciar
    composer.gotoScene("principal", { effect = "slideRight", time = 500 }) -- Vai para o menu
end

-- Função para ir para a cena principal (menu)
local function onMenuButtonTap(event)
    if (event.phase == "ended") then
        resetGame() -- Chama a função para redefinir o estado do jogo e ir para o menu
    end
    return true
end

function scene:create(event)
    local sceneGroup = self.view

    local gameOver4 = display.newImageRect(sceneGroup, "imagens/gameOver4.png", 1080/3, 1920/3)
    gameOver4.x = display.contentCenterX
    gameOver4.y = display.contentCenterY - 40

    -- Crie o botão "Menu"
    local menuButton = widget.newButton(
        {
            label = "Menu Principal",
            fontSize = 18,
            font = native.systemFontBold,
            labelColor = { default = { 255 }, over = { 128 } },
            onEvent = onMenuButtonTap
        }
    )
    menuButton.x = display.contentCenterX - 80
    menuButton.y = display.contentCenterY + 205
    sceneGroup:insert(menuButton)
end

scene:addEventListener("create", scene)

return scene
