local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local settingsText = display.newText(sceneGroup, "Configurações", display.contentCenterX, display.contentCenterY, native.systemFont, 24)

end

scene:addEventListener("create", scene)

return scene
