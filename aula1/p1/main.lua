function love.load()
    x = 0
    newFont = love.graphics.newFont("assets/fonts/Silkscreen-Regular.ttf",35 )
end


function love.draw()

   x = x + 1
   love.graphics.setFont(newFont)
   love.graphics.setBackgroundColor(96/255, 151/255, 254/255)
   love.graphics.print(x, 400, 300) --X (400) e Y (300) 
  
end