function love.load()
   x = 1 
   y = 10
end

function love.update(dt)
    x = x+1 
end

function love.draw()
  
   love.graphics.rectangle("fill",x,y,40,40)
end