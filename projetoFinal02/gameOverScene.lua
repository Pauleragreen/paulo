local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local function resetGame()
    
    composer.removeScene("gameScene") 
    composer.gotoScene("principal", { effect = "slideRight", time = 500 }) 
end

local function onMenuButtonTap(event)
    if (event.phase == "ended") then
        resetGame() 
    end
    return true
end

function scene:create(event)
    local sceneGroup = self.view

    local gameOver4 = display.newImageRect(sceneGroup, "imagens/gameOver4.png", 1080/3, 1920/3)
    gameOver4.x = display.contentCenterX
    gameOver4.y = display.contentCenterY - 40

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
