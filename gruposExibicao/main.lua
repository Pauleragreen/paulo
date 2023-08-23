-- Criando grupos de exibição

local backGroup = display.newGroup () -- Back usado para plano de fundo, decorações que não terão interação com o jogo.
local mainGroup = display.newGroup () -- Usado para objetos que terão interação dentro do jogo, grupo principal.
local uiGroup = display.newGroup () -- Utilizado para placar, vidas, texto, que ficarão na frente do jogo, porém sem interação.

-- Método embutido:
-- Incluir o objeto já na sua criação.
local bg = display.newImageRect (backGroup, "imagens/bg.jpg", 509*2, 339*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- Método direto:
-- Inclui o objeto depois da sua criação.
local chao = display.newImageRect ("imagens/chao.png", 4503/5, 613/5)
chao.x = display.contentCenterX
chao.y = 450
mainGroup:insert (chao)

-- Colocar o Sol e Nuvem (um direto e outro embutido pelo método)
-- Adicionar 2 Árvores (um direto e outro embutido pelo método)
-- arvores no = mainGroup
-- nuvem e sol = backGroup
local bg = display.newImageRect (backGroup, "imagens/sun.png", 256, 256)
bg.x = 300
bg.y = 60
local cloud = display.newImageRect ("imagens/cloud.png", 2360/7, 984/7)
cloud.x = 100
cloud.y = 45
backGroup:insert (cloud)
cloud: toFront (cloud)
local tree1 = display.newImageRect (mainGroup, "imagens/tree.png", 1024/7, 1024/7)
tree1.x = 50
tree1.y = 350
local tree2 = display.newImageRect ("imagens/tree.png", 1024/7, 1024/7)
tree2.x = 240
tree2.y = 350
mainGroup:insert (tree2)
chao: toFront (chao)