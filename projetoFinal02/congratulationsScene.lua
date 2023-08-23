local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local function onHomeButtonTap(event)
    if (event.phase == "ended") then
        composer.gotoScene("principal", { effect = "fade", time = 500 })
    end
    return true
end

function scene:create(event)
    local sceneGroup = self.view

    local parabens1 = display.newImageRect(sceneGroup, "imagens/parabens1.png", 1080 / 3, 1920 / 3)
    parabens1.x = display.contentCenterX
    parabens1.y = display.contentCenterY - 40

    local homeButton = widget.newButton(
        {
            label = "Voltar para o Menu",
            fontSize = 18,
            font = native.systemFontBold,
            labelColor = { default = { 255 }, over = { 128 } },
            onEvent = onHomeButtonTap
        }
    )
    homeButton.x = display.contentCenterX
    homeButton.y = display.contentHeight - 140
    sceneGroup:insert(homeButton)
end

scene:addEventListener("create", scene)

return scene
