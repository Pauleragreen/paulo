-- Variável global. (Deve ser evitado)
vidas = 2
vidas = 8
print (vidas)
print ("O valor de vidas:"..vidas)
----------------
-- Variáveis locais (só é linda dentro do script)
-- (local) é utilizado somente na criação da variável.
local pontos = 10
print (pontos)
print ("O valor de pontos: " .. pontos)

--------- Operações Aritméticas---------
-- local (significa que a variável é local) laranjas (nome da variável) = (atriuir valor) 10 (valor atribuído a variável)
-- Soma
local laranjas = 10

laranjas = laranjas + 5
-- print imprime a informação dentro do console
print (laranjas)

local bananas = 5

-- Soma entre variáveis
local cesta = 0
cesta = laranjas + bananas
print ("A soma entre as variáveis laranjas e bananas é:" .. cesta)
print ("Na sua cesta possuem " .. cesta .. " frutas")

-- Subtração

cesta = bananas - laranjas
bananas = bananas - 1
print ("a quantidade de bananas é:")

-- Multiplicação

local carro = 8
carro = carro * 2
print ("quantidade de carro: " .. carro)

-- Dividindo pela multiplicação
carro = carro * 0,5 
print ("Divisão pela multiplicação" .. carro)

--Divisão
local gato = 6
gato = gato / 2
print ("A Divisão final é: " .. gato)

local arvore = 97.5
arvore = arvore / 4
print ("Divisão com virgula: " .. arvore)