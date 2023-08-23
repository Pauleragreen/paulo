local phhybridysics = require ("physics")
physics.start()
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local chao = display.newRect (display.contentCenterX, 470, 500, 50)
physics.addBody (chao, "static")

local paredeEsq = display.newRect (-50, display.contentCenterY, 50, 500)
physics.addBody (paredeEsq, "static")

local paredeDir = display.newRect (360, display.contentCenterY, 50, 500)
physics.addBody (paredeDir, "static")

local testeParticula = physics.newParticleSystem (
    {
        -- Nome do arquivo de partícula
        filename = "liquidParticle.png",
        -- radius fisico da partícula
        radius = 2,
        -- radius da imagem (usar sempre valor maior que o radius da particula para que elas se sobreponham e traga um efeito visual mais satisfatório.)
        imageRadius = 4
    }
)

local function onTimer (event)
    testeParticula:createParticle (
    {
        x=0,
        y=0,
        velocityX= 256,
        velocityY= 480,
        color= {1, 0.2, 0.4, 1}, -- define a cor da particula RGBA (A= alpha, transparência)
        lifeTime= 32.0, -- tempo de vida da particula
        flags= {"water", "colorMixing"} -- define o comportamento da partícula
    })
end
timer.performWithDelay (20, onTimer, 0)

testeParticula:createGroup (
    {
        x=50,
        y=0, 
        color={0, 0.3, 1, 1},
        halfWidth=64,
        halfHeight=32,
        flags= {"water", "colorMixing"}
    }
)
testeParticula:applyForce (0, -9.8*testeParticula.particleMass)