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
            Nesta primeira fase, mergulhamos em um tema crucial para o nosso planeta: a reciclagem. 
                Como defensores do meio ambiente, somos chamados a aprender sobre a importância de jogar os objetos na lixeira correta e ajudar a preservar o nosso mundo para as gerações futuras.

                A reciclagem é muito mais do que uma atividade simples de descarte; é uma ação poderosa que pode fazer uma diferença real em nossa sociedade e no ecossistema global. Ao separar os materiais de maneira correta, estamos desempenhando um papel fundamental na redução do desperdício, economia de recursos naturais preciosos e na redução da poluição.
                
                Nossa primeira missão é focada em demonstrar o impacto direto de nossas ações cotidianas. No jogo, as cestas representam diferentes tipos de resíduos - papel, plástico, vidro e metal. Cada uma dessas cestas corresponde a uma categoria específica de material, e a bola que você joga deve ser jogada na cesta correspondente.
                
                Ao jogar as bolas nos lugares certos, você não apenas ganha pontos no jogo, mas também está ajudando a prevenir a contaminação de resíduos que ocorre quando materiais diferentes são misturados. A reciclagem correta garante que os materiais sejam processados de maneira eficiente para serem reutilizados na fabricação de novos produtos, reduzindo a necessidade de extrair novas matérias-primas da natureza.
                
                À medida que avançamos nessa primeira fase, lembre-se de que cada pequena ação conta. Ao jogar as bolas nas cestas certas, você está contribuindo para a preservação dos recursos naturais, a redução da poluição e a construção de um futuro mais sustentável. Vamos nos unir como jogadores comprometidos e defensores do meio ambiente para alcançar o objetivo de pontuação e avançar para a próxima fase, onde novos desafios e oportunidades nos aguardam.
                
                Sua participação é vital para o sucesso desta missão e para a saúde do nosso planeta. Vamos jogar e aprender, lembrando-nos de que cada ação consciente nos aproxima de um mundo mais verde e saudável. Junte-se a nós e faça sua parte para a reciclagem correta!
            

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

    local creditsTitle = display.newText(sceneGroup, "Bem-Vindos a Primeira Fase", display.contentCenterX, 30, native.systemFontBold, 24)
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