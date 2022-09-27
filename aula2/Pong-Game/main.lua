function love.load()

math.randomseed(os.time())

racket1 = {} --Table
height = love.graphics.getHeight()
width = love.graphics.getWidth()
racket1.x = 10
racket1.w = 20 --largura
racket1.h = 80 --altura

-- Centraliza racket1 no eixo y
racket1.y = height /2 - 40

ball = {}
ball.w = 20
ball.h = 20
ball.x = width / 2
ball.y = height / 2
ball.dx = - 300 --Velocidade da bola no eixo x
ball.dy = 0
end

function love.update(dt)

    if collides(ball, racket1) then
    --ball.dx = 0
    ball.dx = - ball.dx --Inverte a direção da bola
    -- Velocidade da bola no eixo y é aleatória
    ball.dy = math.random(-200, 200)
    end
if ball.x + ball.w >= width then
    --Detecta colisão da bola com a borda direita
    ball.x = width - ball.w - 1
    ball.dx = -ball.dx
end
ball.x = ball.x + ball.dx * dt
ball.y = ball.y + ball.dy *dt --dt faz a velocidade ser dependente do tempo

end

function love.draw()
 love.graphics.setColor (1, 1 ,1)
 love.graphics.rectangle("line", racket1.x, racket1.y, racket1.w, racket1.h )
 love.graphics.rectangle("line", ball.x, ball.y, ball.w, ball.h )

end

function collides(ball, racket)
    --Verifica se há colisão entre os dois objetos

if ball.y > racket.y + racket.h or ball.y + ball.h < racket.y then
     --Bola abaixo ou acima da raquete
    return false

end
if ball.x > racket.x + racket.w or ball.x + ball.w < racket.x then 
    --Bola à esquerda ou direita da raquete
    return false 
end
return true
end