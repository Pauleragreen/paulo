local bg = display.newImageRect ("imagens/sky.png", 960*3, 240*3) 
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ("imagens/ground.png", 1028 , 256)
chao.x = display.contentCenterX
chao.y = 490

local player = display.newImageRect ("imagens/player.png", 532/3, 469/3)
player.x = 50
player.y = 300

-- Andar para a direita
local function direita ()
    player.x = player.x + 10
end

local botaoDireita = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)
botaoDireita.x = 300
botaoDireita.y = 350
botaoDireita:addEventListener ("tap", direita)
---------------------------------------------------------------------
-- Andar para a esquerda
local function esquerda ()
    player.x = player.x - 10
    end
    local botaoEsquerda = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)
    botaoEsquerda.x = 220
    botaoEsquerda.y = 350
    botaoEsquerda.rotation = 180
    botaoEsquerda:addEventListener ("tap", esquerda)
-----------------------------------------------------------------------
-- Andar para cima
local function cima ()
    player.y = player.y - 10
    end
    local botaoCima = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)
    botaoCima.x = 260
    
    botaoCima.y = 300
    botaoCima.rotation = -90
    botaoCima:addEventListener ("tap", cima)
----------------------------------------------------------------------
-- Andar para baixo
local function baixo ()
    player.y = player.y + 10

    end
    local botaoBaixo = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)
    botaoBaixo.x = 260
    botaoBaixo.y = 400
    botaoBaixo.rotation = 90
    botaoBaixo:addEventListener ("tap", baixo)


-- Andar para diagonal

