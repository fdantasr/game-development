function love.load()

     bullet = love.graphics.newImage("aviao.png")
     speed = 300 -- 20 pixels por segundo
     y = 100
     x = 0
     xscale = 0.5
     w = love.graphics.getWidth()
     h = love.graphics.getHeight()
end

function love.update(dt)
   x = x + speed * dt
   if x >= w then
     --parar a bala

  x = w
  --deformar a bala no eixo x (achatamento)
  if xscale > 0.3 then
    xscale = xscale - 0.70 * dt
end
end
end

function love.draw()

    love.graphics.setBackgroundColor(197/255, 224/255, 220/255)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(bullet, x, y, 0, -xscale, 0.5 )
    --Terra
    love.graphics.setColor(119/255, 79/255, 56/255)
    love.graphics.rectangle("fill", 0, 400, 800, 300)

    --Grama
    love.graphics.setColor(131/255, 242/255, 122/255)
    love.graphics.rectangle("fill", 0, 400, 800, 30)

    --Sol
    love.graphics.setColor(200/255, 255/255, 10/255)
    love.graphics.circle( "fill", 700, 100, 50 )

    --Arvore
    love.graphics.setColor(131/255, 242/255, 122/255)
    love.graphics.rectangle("fill", 50, 330, 40, 50 )
    love.graphics.setColor(83/255, 35/255, 27/255)
    love.graphics.rectangle("fill", 65, 380, 10, 20 )




end
