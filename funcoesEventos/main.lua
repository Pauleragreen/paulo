-- -- Incluindo Funções 
-- -- Comando para iniciar a função local function nome da função, seguido de parênteses
-- local function detectarTap (event) -- determina que essa função é uma função de evento.
--     -- Código que é executado quando o botão for tocado
--     -- tostring: para sequenciar     .. para concatenação (unir as informações)
--     -- event.target: serve para nomear o objeto ou evento, ou objeto tocado
--     print ("Objeto tocado:" .. tostring (event.target) )

--     return true -- "zera" todos os dados depois da função executada.

-- end -- Fecha a function 

-- local botaoTap = display.newRect (200, 200, 200, 50)
-- botaoTap:addEventListener ("tap", detectarTap) -- Adiciona um ouvinte "tap" ao objeto.

-- local function tapDuplo (event)
--     -- se (numero de taps do event for igual a 2) então 
--     if (event.numTaps == 2) then 
--         print ("Objeto tocado duas vezes: " .. tostring (event.target) )

--     else -- se não 
--         return true
--     end -- fecha o if/else
-- end -- fecha a function

-- local botaoDuplo = display.newRect (100, 300, 300, 50)
-- botaoDuplo:setFillColor (0.4, 0, 0.3)
-- botaoDuplo:addEventListener ("tap", tapDuplo)

-- -- Evento de toque (touch)
-- -- Fases de toque:
-- -- began = Primeira fase de toque, quando o usuario encosta na tela.
-- -- moved = quando o usuario mantém o toque e move pela tela.
-- -- ended = última fase de toque, quando o usuario solta o toque.
-- -- cancelled = quando o evento de toque é cancelado do sistema.

-- local function fasesToque (event)
-- -- se a fase de toque for igual a began, então 
--     if (event.phase == "began" ) then
--         print ("Objeto tocado: " .. tostring(event.target) )
-- -- Porém se a fase de toque for igual a moved então
--     elseif (event.phase == "moved" ) then 
--         print ("Localiação de toque nas seguintes coordenadas: x=" .. event.x .. ", y= " .. event.y)
-- -- Entretanto se a fase de toque for igual a ended ou cancelled então
--     elseif (event.phase == "ended" or "cancelled" ) then 
--         print ("Touch terminado no objeto: " .. tostring(event.target) )
--     end -- Fecha os ifs

--     return true
-- end -- Fecha a function

-- local botaoTouch = display.newRect (200, 400, 200, 50)
-- botaoTouch:setFillColor (1, 0.3, 0.5)
-- botaoTouch:addEventListener ("touch", fasesToque)
--------------------------------------------------------
-- Multitoque:
-- Para saber qual o primeiro e o segundo toque o usuario fez, basta utilizar o event.numTouches e o event.touches. -- Para utiliar o multitouch precisamos habilitar (ativar) primeiro.
system.activate ("multitouch")

local retangulo = display.newRect ( display.contentCenterX, display.contentCenterY, 280, 440 )
retangulo:setFillColor (1, 0, 0.3)

local function eventoTouch (event)
    print ("Fase de toque: " .. event.phase )
    print ("Localização x: " .. tostring(event.x) .. ", localização y: " .. tostring(event.y) )
    print ("ID de toque exclusivo: " .. tostring(event.id) )
    print ("-----------")
    return true
end 

retangulo:addEventListener ("touch", eventoTouch)

