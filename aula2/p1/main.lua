function love.load()

     bullet = love.graphics.newImage("bullet.png")
     speed = 200 -- 20 pixels por segundo
     y = 100
     x = 0

end

function love.update(dt)
   x = x + speed * dt

end

function love.draw()

    love.graphics.setBackgroundColor(197/255, 224/255, 220/255)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(bullet, x, y, 0, -0.5, 0.5 )
    --Terra
    love.graphics.setColor(119/255, 79/255, 56/255)
    love.graphics.rectangle("fill", 0, 400, 800, 300)

    --Grama
    love.graphics.setColor(131/255, 242/255, 122/255)
    love.graphics.rectangle("fill", 0, 400, 800, 30)

end
