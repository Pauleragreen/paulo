-- Chamar a biblioteca de fisica (primeiro bloco de código)
local physics = require ("physics")
-- Iniciar o motor de física
physics.start ()
-- Definir a gravidade.
physics.setGravity(0, 0)
-- Definir o modo de renderização
physics.setDrawMode ("normal") -- normal, hybrid, debug

-- Remover a barra de notificações.
display.setStatusBar(display.HiddenStatusBar)

-- Criar bloco dos grupos de exibição. 
local grupoBg = display.newGroup() -- bloco do plano de fundo, objetos decorativos que ficam atrás do player e que (não tem interação com o jogo)
local grupoMain = display.newGroup() -- bloco principal de interação (tudo que precisar interagir com o player)
local grupoUI = display.newGroup() -- bloco de interface do usuário, botões, pontuação, barra de vida e poder.

-- Criar variáveis de pontos e vidas para atribuição de valor. (placar)
local pontos = 0
local vidas = 5

-- Adicionar background
--                              (grupo, "pasta/nome da imagem.png", largura, altura)
local bg = display.newImageRect (grupoBg, "imagens/fundo.png", 628, 419*1.2)
-- localizações da imagem
bg.x = display.contentCenterX -- localização horizontal
bg.y = display.contentCenterY -- localização vertical

-- Audio bg
local bgAudio = audio.loadStream ("audio/bg.mp3")
-- Reserva de canal de audio para o som de fundo
audio.reserveChannels (1)
-- Especificar o volume desse canal
audio.setVolume (0.6, {channel=1})
-- Reproduzir o audio
--          (audio a reproduzir, {canal, loopins (-1 infinito)})
audio.play (bgAudio, {channel=1, loops=-1})

-- Adicionar placar na tela.
-- (grupo, "texto:" concatenação.. pontos, localizaçãoX, localizaçãoY, fonte, tamanho da fonte)
local pontosText = display.newText (grupoUI, "Pontos: " .. pontos, 50, 30, native.systemFont, 20)

pontosText:setFillColor (1, 1, 1)

local vidasText = display.newText (grupoUI, "Vidas: " .. vidas, 250, 30, native.systemFont, 20)
vidasText:setFillColor (1, 1, 1)

-- Adicionar herói
local player = display.newImageRect (grupoMain, "imagens/rambo.png", 161/2, 312/2)
player.x = 30
player.y =  370
player.myName = "Rambo"
physics.addBody (player, "kinematic") -- corpo Kinematic colide apenas com o dinâmico e não tem interferência da gravidade.

-- Criar botões
local botaoCima = display.newImageRect (grupoMain, "imagens/button.png", 1280/30, 1279/30)
botaoCima.x = 220
botaoCima.y = 440
botaoCima.rotation = -90 -- faz a rotação da imagem em x graus.

local botaoBaixo = display.newImageRect (grupoMain, "imagens/button.png", 1280/30, 1279/30)
botaoBaixo.x = 100
botaoBaixo.y = 440
botaoBaixo.rotation = 90

-- Adicionar funções de movimentação
local function cima ()
    player.y = player.y - 40
end

local function baixo ()
    player.y = player.y + 40
end

-- Adicionar ouvinte e a função do botão: evento de clique
botaoCima:addEventListener ("tap", cima)
botaoBaixo:addEventListener ("tap", baixo)

-- Adicionar botão tiro:
local botaoTiro = display.newImageRect (grupoMain, "imagens/botaotiro.png", 260/4, 260/4)
botaoTiro.x = display.contentCenterX
botaoTiro.y = 440

-- Função para atirar:
local function atirar ()
    -- Toda vez que a função for executada ele cria um novo tiro.
    local tiroPlayer = display.newImageRect (grupoMain, "imagens/tiro.png", 733/15, 341/15)
    -- localização é a mesma do player
    tiroPlayer.x = player.x
    tiroPlayer.y = player.y -30
    tiroPlayer.rotation = 180
    -- determinamos que o projetil é um sensor, o que ativa a detecção continua de colisão.
    physics.addBody (tiroPlayer, "dynamic", {isSensor=true})
    transition.to (tiroPlayer, {x=500, time=900, 
                    onComplete = function () display.remove (tiroPlayer)
                    end})
    tiroPlayer.myName = "Bomba"
    tiroPlayer:toBack () --Joga o elemento pra trás dentro do grupo de exibição dele.
end

botaoTiro: addEventListener ("tap", atirar)

-- Adicionar inimigo
local inimigo = display.newImageRect (grupoMain, "imagens/inimigo.png", 232/1.7, 282/1.7)
inimigo.x = 290
inimigo.y = 370
inimigo.myName = "Exterminator"
physics.addBody (inimigo, "kinematic")
local direcaoInimigo = "cima"

-- Função para o inimigo atirar:
local function inimigoAtirar ()
    local tiroInimigo = display.newImageRect (grupoMain, "imagens/tiro.png", 733/15, 341/15)
    tiroInimigo.x = inimigo.x 
    tiroInimigo.y = inimigo.y -40
    physics.addBody (tiroInimigo, "dynamic", {isSensor=true})
    transition.to (tiroInimigo, {x=-200, time=900,
                    onComplete = function ()
                     display.remove (tiroInimigo)
                    end})
    tiroInimigo.myName = "BombaInimigo"
end

-- Criando o timer de disparo do inimigo:
-- Comandos timer: (tempo repetição (1s, 1.5s) função, quantidade de repetições no timer)
inimigo.timer = timer.performWithDelay (math.random (1000, 2000), inimigoAtirar, 0)

-- Movimentação do inimigo:
local function moverInimigo ()
-- se a localização x não for igual a nulo então 
    if not (inimigo.x == nil) then
-- Quando a direção do inimigo for cima então
        if (direcaoInimigo == "cima") then
            inimigo.y = inimigo.y - 1
-- Se a localização y do inimigo for menor ou igual a 50 então, altera a direção do inimigo para baixo
            if (inimigo.y <=80 ) then
            -- altera a variável para "baixo"
                direcaoInimigo = "baixo"
            end -- if (inimigo.y.....)
-- Se a direção do inimigo for igual a baixo, então
        elseif (direcaoInimigo == "baixo") then
                inimigo.y = inimigo.y + 1
-- Se a localização de y do inimigo for maior ou igual a 400, então
            if (inimigo.y >= 400) then
                    direcaoInimigo = "cima"
            end -- if (inimigo.y...)
        end -- if (direçãoInimigo...)
-- Se não
    else
        print ("Inimigo morreu!")
-- Rumtime: representa todo o jogo ( evento é executado para todos), enterframe: está ligado ao valor de FPS do jogo (frames por segundo), no caso, a função vai ser executada 60 vezes por segundo.
        Rumtime:removeEventListener ("enterFrame", moverInimigo)
    end
end

Runtime: addEventListener ("enterFrame", moverInimigo)

-- Adicionar a função de colisão:
local function onCollision (event)
-- Quando a fase de evento for began então
    if (event.phase == "began") then
-- Variáveis criadas para facilitar a escrita do código.
        local obj1 = event.object1
        local obj2 = event.object2
-- Quando o myName do objeto 1 for ... e o nome do obj2 for ...
        if ((obj1.myName == "Bomba" and obj2.myName == "Exterminator") or (obj1.myName == "Exterminator" and obj2.myName == "Bomba")) then
            -- Se o obj1 for ... then 
            if (obj1.myName == "Bomba") then
            -- Remove o projétil do jogo.
                display.remove (obj1)
            else
                display.remove (obj2)
            end
-- Somar 10 pontos a cada colisão
            pontos = pontos + 10
-- Atualizo os pontos na tela.
            pontosText.text = "Pontos: " .. pontos
-- Se o obj1 for Player e o 2 for projetil
        elseif ((obj1.myName == "Rambo" and obj2.myName == "BombaInimigo") or (obj1.myName == "BombaInimigo" and obj2.myName == "Rambo")) then
            if (obj1.myName == "BombaInimigo") then
                display.remove (obj1)
            else
                display.remove (obj2)
            end
-- Reduz uma vida do player a cada colisão
        vidas = vidas -1
        vidasText.text = "Vidas: " .. vidas
            if (vidas <= 0) then
                Runtime:removeEventListener ("collision", onCollision)
                Runtime:removeEventListener ("enterFrame", moverInimigo)
                timer.pause (inimigo.timer) -- Colocar sempre o nome que foi criado no timerWithDelay
                botaoBaixo:removeEventListener ("tap", baixo)
                botaoCima:removeEventListener ("tap", cima)
                botaoTiro:removeEventListener ("tap", atirar)
            
                local gameOver = display.newImageRect (grupoUI,"imagens/gameover.png", 1080/5, 1080/5)
                gameOver.x = display.contentCenterX
                gameOver.y = display.contentCenterY
            end
        end -- fecha o if myName
    end -- fecha o if event.phase
end -- fecha a function

Runtime:addEventListener ("collision", onCollision)







