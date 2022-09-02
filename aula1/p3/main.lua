function love.load()
   bullet = love.graphics.newImage("images/bullet.png")
   dog = love.graphics.newImage("images/dog.jpg")
   x = 0
   y = 100
   position = 0;

   x2 = 0
   y2 = 400
end

function love.update(dt)
   position = position+2
   x2 = x2+1
end

function love.draw() 


  love.graphics.setBackgroundColor(0/255, 138/255, 197/255)
  love.graphics.draw(bullet, position, 100,0, -0.1, 0.1 )
  love.graphics.draw(bullet, x2, y2,0, -0.4, 0.4 )
end

