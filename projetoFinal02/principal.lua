local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local function onPlayButtonTap()
    composer.gotoScene("introScene", { effect = "fade", time = 500 })
end

local function onCreditsButtonTap()
    composer.gotoScene("creditsScene", { effect = "fade", time = 500 })
end

local function onSettingsButtonTap()
    composer.gotoScene("settingsScene", { effect = "fade", time = 500 })
end

function scene:create(event)
    local sceneGroup = self.view

    local bg_menu8 = display.newImageRect(sceneGroup, "imagens/bg_menu8.png", 928/2, 1312/2)
    bg_menu8.x = display.contentCenterX
    bg_menu8.y = display.contentCenterY

    local title = display.newText(sceneGroup, "Recycle Master", display.contentCenterX, 35, native.systemFont, 44)

    local playButton = display.newText(sceneGroup, "Jogar", 20, 460, native.systemFont, 22)
    playButton:addEventListener("tap", onPlayButtonTap)

    local creditsButton = display.newText(sceneGroup, "Créditos", 100, 460, native.systemFont, 22)
    creditsButton:addEventListener("tap", onCreditsButtonTap)

    local settingsButton = display.newText(sceneGroup, "Controles", 200, 460, native.systemFont, 22)
    settingsButton:addEventListener("tap", onSettingsButtonTap)
end

scene:addEventListener("create", scene)

return scene
