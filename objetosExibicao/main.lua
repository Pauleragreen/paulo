-- Adicionar nova imagem na tela:
-- Comandos: display.newImageRect ("Pasta.arquivo.formato", largura, altura)
local bg = display.newImageRect ("imagens/bg.jpg", 1280*1.25, 720*1.25)
-- Definir localização do objeto.
-- Comando: variavel.linha que vou definir = localização na linha
bg.x = display.contentCenterX -- Comando que centraliza a variavel em qualquer resolução.
bg.y = display.contentCenterY

local pikachu = display.newImageRect ("imagens/pikachu.png", 1191/5, 1254/5)
pikachu.x = display.contentCenterX
pikachu.y = display.contentCenterY
local charmander = display.newImageRect ("imagens/charmander.png", 507/2, 492/2)
charmander.x = 230
charmander.y = 390
local retangulo = display.newRect (750, 500, 250, 200)
local mystery = display.newImageRect ("imagens/mystery.png", 507/2, 492/2)
mystery.x = 740
mystery.y = 500
----------------------------------------------
-- Criando um retângulo:
-- Comando: display.newRect (Localização x, localização y, largura, altura)
-- Criando um circulo:
-- Comando: display.newCircle (x,y,radius(raio do circulo que equivale a metade dele))
local bola = display.newImageRect ("imagens/bola.png", 120, 120)
bola.x = 120
bola.y = 150