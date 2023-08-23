local retangulo = display.newRect (120, 80, 200, 140)
retangulo: setFillColor (0.4, 0.2, 0.3)

local circulo = display.newCircle (330,80,80)
circulo:setFillColor (0.2, 0.7, 0.4)

local quadrado = display.newRect (530, 80, 140, 140)
quadrado:setFillColor (0.6, 0.7, 0.2)
-- Adicionar um retangulo/quadrado arredondado:
-- Comandos: display.newRoundedRect (x, y, largura, altura, raio das bordas)
local retanguloArredondado = display.newRoundedRect (730, 80, 200, 140, 30)
retanguloArredondado:setFillColor (0.7, 0.4, 0.5)
-- Adicionar uma linha
-- Comandos: display.newLine (x inicial da linha, y inicial da linha, x final da linha, y final da linha)
local linha = display.newLine (0, 250, 1200, 250)

-- Criar um Polígono
-- Comandos: display.newPolygon (y, x, vertices)

local localizacaoX = 200
local localizacaoY = 350

local vertices = {0, -110, 27, -35, 105, -35, 43, 16, 65, 90, 0, 45, -65, 90, -43, 15, -105, -35, -27, -35}
local estrela = display.newPolygon (localizacaoX, localizacaoY, vertices)

-- Criar um novo texto
-- Comandos: display.newText ("Texto que quero inserir", x, y, fonte, fontsize)
local helloWord = display.newText ("Hello Word!", 500, 350, native.systemFont, 50)

local parametros = {text = "Olá Mundo!",
 x = 500,
 y = 450,
 font = "Arial",
 fontSize = 50,
 align = "right"}

local olaMundo = display.newText (parametros)
olaMundo:setFillColor (0.7, 0.5, 0.7)
-- Adicionar texto em relevo
-- Comandos: display.newEmbossedText ()

local opcoes = {text = "PLAYER", x = 730, y = 450, font = "Arial", fontSize = 50}



 local textoRelevo = display.newEmbossedText (opcoes)
 textoRelevo:setFillColor (0.4,0.7,0.6)

 -- Adicionar a cor ao objeto/texto:
-- Comandos: variavel:setFillColor (cinza, vermelho, verde, azul, alfa)

helloWord:setFillColor (0.4, 0.2, 0.3)
helloWord.alfa = 0.5

local color = {
    -- destaque
    highlight = {r = 0.5, g = 0.3, b = 0.7}, 
    -- sombra
    shadow = {r = 0, g = 0, b = 0}
}

textoRelevo: setEmbossColor (color)

-- Gradiente:
-- Comandos: variavel = {type = color1 = { ,  , }, color2 = { ,  , }, direction= ""}
local gradiente = {
    type = "gradient",
    color1 = {1, 0.1 , 0.2 },
    color2 = {0, 0.2 , 0.2},
    direction = "down"
}

estrela:setFillColor (gradiente)