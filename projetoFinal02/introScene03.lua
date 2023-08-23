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
        composer.gotoScene("gameScene03", { effect = "slideLeft", time = 500 })
    end
    return true
end

local function showCredits(sceneGroup)
    
    local bgRect = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth - 20, display.contentHeight - 100)
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
            Bem-vindo à terceira e última fase do jogo! Nesta etapa final, mergulhamos em um dos estágios mais importantes do processo de gerenciamento de resíduos: a reciclagem. Agora, como parte fundamental da equipe de uma empresa de coleta de lixo comprometida com a sustentabilidade, é sua responsabilidade ajudar a separar o lixo coletado para que ele possa ser devidamente reciclado.

                Imagine que o lixo que você coletou nas fases anteriores finalmente chegou à instalação da empresa de limpeza. Aqui, o verdadeiro desafio começa, pois o lixo deve ser classificado e separado em diferentes categorias para ser processado de maneira adequada e transformado em matéria-prima valiosa para novos produtos. Sua tarefa agora é crucial: ajudar a separar o lixo reciclável dos resíduos não recicláveis.
                
                A reciclagem é uma etapa vital na gestão de resíduos, com inúmeros benefícios para o meio ambiente e a sociedade como um todo. Quando os materiais recicláveis, como plástico, papel, vidro e metal, são separados e reciclados, eles têm a chance de ser reutilizados, reduzindo a demanda por recursos naturais e minimizando a quantidade de resíduos enviados para aterros sanitários.
                
                Ao tocar nos diferentes tipos de lixo que chegam à empresa de limpeza, você está desempenhando um papel crucial na separação de resíduos. Cada vez que você coloca um resíduo reciclável na cesta correta, está contribuindo para a criação de um ciclo de reciclagem eficiente e sustentável. Cada ação sua ajuda a reduzir a poluição, conservar energia e preservar o meio ambiente para as gerações futuras.
                
                Mas cuidado! Se você colocar um resíduo na cesta errada, estará comprometendo o processo de reciclagem. Lembre-se de que cada ação sua conta para determinar o sucesso desta fase. Sua ajuda é fundamental para que a empresa de limpeza possa cumprir sua missão de reciclar e promover a sustentabilidade.
                
                Junte-se a nós nessa jornada final, onde suas escolhas farão a diferença no destino do lixo coletado. Cada resíduo que você coloca na cesta certa é um passo em direção a um futuro mais limpo e mais verde. Vamos trabalhar juntos para garantir que a reciclagem seja bem-sucedida, a empresa de limpeza alcance seus objetivos e o jogo seja finalizado com sucesso.
                
                Avance nesta etapa com determinação, lembrando que cada ação sua ajuda a preservar nosso planeta e a construir um mundo mais sustentável. A missão está em suas mãos, e o sucesso está ao alcance. Boa sorte em sua tarefa final de separar e reciclar resíduos para concluir com êxito este emocionante jogo!
            

]],
        x = 0,
        y = 10,
        width = display.contentWidth - 20,
        font = native.systemFont,
        fontSize = 14,
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

    local creditsTitle = display.newText(sceneGroup, "Você chegou na ultima Fase", display.contentCenterX, 30, native.systemFontBold, 22)
    creditsTitle:setFillColor(0, 0, 0)

    showCredits(sceneGroup)

    local backButton = widget.newButton(
        {
            label = "Voltar",
            fontSize = 22,
            font = native.systemFontBold,
            labelColor = { default = { 0 }, over = { 128 } },
            onEvent = onBackButtonTap
        }
    )
    backButton.x = 30
    backButton.y = display.contentHeight - 20
    sceneGroup:insert(backButton)

    local followButton = widget.newButton(
        {
            label = "Seguir",
            fontSize = 22,
            font = native.systemFontBold,
            labelColor = { default = { 0 }, over = { 128 } },
            onEvent = onFollowButtonTap
        }
    )
    followButton.x = display.contentWidth - 30
    followButton.y = display.contentHeight - 20
    sceneGroup:insert(followButton)
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