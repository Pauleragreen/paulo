local bg = display.newImageRect ("imagens/namek.jpg", 1024, 576) 
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local physics = require ("physics")
physics.start ()
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local player = display.newImageRect ("imagens/goku.png", 351/2, 434/2)
player.x = 50
player.y = 360
player.myName = "Player"
 
-- inserir objeto dama


-- inserir objeto inimigo
local inimigo = display.newImageRect ("imagens/inimigo.png", 407/4, 613/4)
inimigo.x = 280
inimigo.y = 160
physics.addBody (inimigo, "static")
inimigo.myName = "Freeza"

