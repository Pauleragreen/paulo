local physics = require ("physics")
physics.start ()
physics.setGravity(1, 9.8)
physics.setDrawMode ("hybrid")

display.setStatusBar(display.HiddenStatusBar)

local joint

local staticBox = display.newRect (0, 0, 60, 60)
staticBox: setFillColor (0.2, 0.2, 1) 
physics.addBody (staticBox, "static", {isSensor=true})
staticBox.x, staticBox.y = display.contentCenterX, 80

local shape = display.newRect (0, 0, 40, 100)
shape: setFillColor (1, 0.2, 0.4)
physics.addBody (shape, "dynamic")
shape.x, shape.y, shape.rotation = 100, staticBox.y-40, 0

-- Criação da junta de pivô ("tipo de junta", objA, objB, ancoraX, ancoraY)
local jointPivot = physics.newJoint ("pivot", staticBox, shape, staticBox.x, staticBox.y)