
local composer = require( "composer" )

local scene = composer.newScene()

local fundo
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local json = require ("json") -- Chama a biblioteca json para a cena
local pontosTable = {} -- String/table que irá conter as pontuações guardadas.
local filePath = system.pathForFile ("pontos.json", system.DocumentsDirectory) -- cria o arquivo pontos.json e juntamente um caminho para a pasta.

local function carregaPontos()
	-- Verificar se o arquivo existe abrindo-o somente leitura
	local pasta = io.open (filePath, "r") -- r é == somente leitura

	if pasta then
		local contents = pasta:read ("*a") -- Extrai os dados do arquivo e guarda na variavel contents (formato JSON)
		io.close (pasta) -- fecha o arquivo pontos.json
		pontosTable = json.decode (contents) -- decodificar a variavel contents de json para Lua e armazena-los na tabela.
	end
	-- Se a tabela na existir ou estiver vazia (# == índice da taela ou total de dados.)
	if (pontosTable == nil or #pontosTable == 0) then
		pontosTable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0} -- define as pontuações iniciais
	end
end

local function salvaPontos ()
	for i = #pontosTable, 11, -1 do -- Define que apenas 10 valores podem ser salvos na pontosTable.
		table.remove (pontosTable, i)
	end
	-- Abre o arquivo pontos.json para alterações.
	local pasta = io.open (filePath, "w") -- ("w" == acesso de gravação)

	if pasta then
		-- Inclui os dados da pontosTable no arquivo pontos.json codificada para JSON	
		pasta:write (json.encode(pontosTable))
		io.close (pasta) -- Fecha o arquivo pontos.json
	end
end

local function gotoMenu ()
	composer.gotoScene ("menu", {time==800, effect="crossFade"})
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	carregaPontos ()

	table.insert (pontosTable, composer.getVariable("scoreFinal"))

	composer.setVariable ("scoreFinal", 0)

	local function compare (a, b)
		return a > b
	end

	table.sort (pontosTable, compare)

	salvaPontos()

	local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800, 1400)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	local cabecalho = display.newText (sceneGroup, "Recordes", display.contentCenterX, 100, native.SystemFont, 80)
	cabecalho:setFillColor (0.75, 0.78, 1)

	for i = 1, 10 do
		if (pontosTable[i]) then
			-- Define que o espaçamento das pontuações seja uniforme de acordo com o numero.
			local yPos = 150 + (i*56)

			local ranking = display.newText (sceneGroup, i .. ")", display.contentCenterX-50, yPos, native.systemFont, 44)
			ranking:setFillColor (0.8)

			ranking.anchorX = 1 -- alinha o texto a direita alterando a âncora.

			local finalPontos = display.newText (sceneGroup, pontosTable[i], display.contentCenterX-30, yPos, native.systemFont, 44)
			finalPontos.anchorX = 0

			fundo = audio.loadStream ("audio/final.wav")

		end
	end
	local menu = display.newText (sceneGroup, "Menu", display.contentCenterX, 810, native.systemFont, 50)
	menu:setFillColor (0.75, 0.78, 1)
	menu:addEventListener ("tap", gotoMenu)
end



-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play (fundo, {channel=1, loops=-1})
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene("recordes")
		audio.stop (1)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose (fundo)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene