local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local function onBackButtonTap(event)
    if (event.phase == "ended") then
        composer.gotoScene("principal", { effect = "slideRight", time = 500 })
    end
    return true
end

local function onFollowButtonTap(event)
    if (event.phase == "ended") then
        composer.gotoScene("gameScene", { effect = "slideLeft", time = 500 })
    end
    return true
end

local function showCredits(sceneGroup)
    
    local bgRect = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth - 0, display.contentHeight - 100)
    bgRect:setFillColor(0, 0, 0, 0.8)

    local scrollView = widget.newScrollView(
        {
            x = display.contentCenterX,
            y = display.contentCenterY,
            width = display.contentWidth - 20,
            height = display.contentHeight - 100,
            backgroundColor = { 0, 0, 0, 0 }, 
            horizontalScrollDisabled = true,
            hideScrollBar = false
        }
    )

    local creditsTextOptions = {
        text = [[         
Para jogar a fase 1: 
        
Bem-vindo à emocionante jornada de reciclagem de basquete! Nesta fase, você será o defensor incansável da natureza, jogando lixos recicláveis nos cestos de reciclagem apropriados. Aqui está o que você precisa fazer para brilhar nessa tarefa:

Na palma da sua mão, segure uma bola representando um lixo reciclável. Cada tipo de lixo corresponde a um cesto específico de reciclagem.
            
Toque no cesto de reciclagem correspondente com o dedo para lançar a bola nele. Cada vez que você acertar o cesto correto, você ganhará 10 pontos.
            
A precisão é fundamental! Certifique-se de escolher o cesto certo para cada tipo de lixo. Se você errar, não ganhará pontos.
            
Sua meta é acumular 100 pontos para avançar para a próxima fase. À medida que você acerta os cestos, sua pontuação aumentará gradualmente. Fique focado e siga em frente!
            
Cuidado com suas vidas. Você começa com 3 vidas no total. Se você errar um arremesso e não acertar o cesto correto, perderá uma vida.
            
Para avançar, você precisa cumprir a pontuação mínima necessária. Continue acertando os cestos e reciclando com eficiência para atingir esse objetivo.
            
Lembre-se, a responsabilidade é sua! Se você esgotar todas as vidas, a fase acabará. Portanto, arremesse com precisão para evitar isso.

Para jogar a fase 2:

Para jogar a fase 2, você será o condutor habilidoso de um caminhão de lixo em uma missão importante de coleta. Sua tarefa é crucial: percorrer a cidade e recolher o lixo que está espalhado pelas ruas. Aqui está o que você precisa fazer para ter sucesso nessa tarefa:

Toque no caminhão de lixo e deslize o dedo para movê-lo para a esquerda ou direita. Mantenha-se atento, pois você precisa estar na posição certa para coletar o lixo à medida que avança.

À medida que você dirige o caminhão, observe o lixo espalhado pelas ruas. Seja rápido e hábil para coletar o lixo tocando nele com o caminhão. A cada peça de lixo coletada, você ganhará 10 pontos.

No entanto, tome cuidado para não perder nenhum lixo. Se você deixar o lixo para trás, sua pontuação permanecerá a mesma, mas você não ganhará pontos. Portanto, seja preciso e meticuloso em suas ações.

Além disso, fique de olho nas suas vidas. Cada vez que você deixar um pedaço de lixo passar despercebido, perderá uma vida. Você começa com 3 vidas no total.

O objetivo é acumular 100 pontos para avançar para a próxima fase. À medida que você coleta mais lixo, sua pontuação aumenta gradualmente. Mantenha o foco e continue coletando para atingir essa meta.

Lembre-se de que suas ações têm impacto. Se você perder todas as suas vidas, o jogo chegará a um fim. Portanto, mantenha-se vigilante e colete com precisão para evitar que isso aconteça.

Para jogar a fase 3:

Para jogar a fase 3, você desempenhará um papel vital na última etapa do processo de reciclagem. Agora, como membro essencial da equipe de uma empresa de limpeza comprometida com a sustentabilidade, você deve ajudar a separar o lixo reciclável dos não recicláveis. Veja como fazer isso:

Toque nos diferentes tipos de lixo que chegam à empresa de limpeza. Sua tarefa é separar o lixo reciclável, como plástico, papel, vidro e metal, dos resíduos não recicláveis.
    
Cada vez que você coloca um resíduo na cesta de reciclagem correta, você está contribuindo para a criação de um ciclo de reciclagem eficiente. Isso ajuda a conservar recursos naturais, reduzir a poluição e contribuir para um ambiente mais limpo.
    
Porém, atenção: se você colocar um resíduo na cesta errada, isso comprometerá o processo de reciclagem. A precisão é essencial, portanto, esteja certo de que está fazendo a escolha certa.
    
Seu objetivo é acumular 100 pontos para finalizar o jogo com sucesso. A cada resíduo reciclável corretamente separado, sua pontuação aumenta gradualmente. Mantenha-se focado e determinado para atingir esse objetivo.
    
No entanto, você tem um limite de vidas. Cada vez que você erra a separação, você perde uma vida. Mantenha-se atento e tome decisões conscientes para evitar perder todas as vidas.
            

]],
        x = 0,
        y = 10,
        width = display.contentWidth - 20,
        font = native.systemFont,
        fontSize = 13,
        align = "left"
    }

    local creditsText = display.newText(creditsTextOptions)
    creditsText.anchorX, creditsText.anchorY = 0, 0
    creditsText:setFillColor(255, 255, 255) 
    scrollView:insert(creditsText)

    sceneGroup:insert(scrollView)
end

function scene:create(event)
    local sceneGroup = self.view

    local bg_menu777 = display.newImageRect(sceneGroup, "imagens/bg_menu777.png", 1024/1.8, 1024/1.8)
    bg_menu777.x = display.contentCenterX
    bg_menu777.y = display.contentCenterY -40

    local logo_cpdi3 = display.newImageRect(sceneGroup, "imagens/logo_cpdi3.png", 548/2, 456/2)
    logo_cpdi3.x = display.contentCenterX
    logo_cpdi3.y = 200

    local creditsTitle = display.newText(sceneGroup, "Controles", display.contentCenterX, 30, native.systemFontBold, 24)
    creditsTitle:setFillColor(0, 0, 0)

    showCredits(sceneGroup)

    local backButton = widget.newButton(
        {
            label = "Voltar",
            fontSize = 20,
            font = native.systemFontBold,
            labelColor = { default = { 0 }, over = { 128 } },
            onEvent = onBackButtonTap
        }
    )
    backButton.x = 30
    backButton.y = display.contentHeight - 20
    sceneGroup:insert(backButton)
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        if (sceneGroup.scrollView) then
            sceneGroup.scrollView:removeSelf()
            sceneGroup.scrollView = nil
        end
    end
end

function scene:show(event)
    local phase = event.phase

    if (phase == "will") then
        local sceneGroup = self.view
        if (sceneGroup.scrollView) then
            sceneGroup.scrollView.isVisible = true
        end
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("show", scene)

return scene