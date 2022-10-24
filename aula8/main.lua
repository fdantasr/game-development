Class = require 'class'

require 'Fighter'

--Instancia a calasse  Fighter (cria um objeto)
--Fighter("Nome", "Largura", "Altura", cor)
blanka = Fighter("Blanka",20, 20, {1, 0.3, 0.0})
honda = Fighter("Honda", 60, 30, {0.2, 0.4, 0.7})


function love.draw()
    blanka:draw(20, 30)
    honda:draw(80, 500)
end

-- fighter = {}
-- fighter.name = "Blanka"

-- -- Modo 1

-- fighter.sayHello = function(s) love.graphics.print('Oi, Meu nome é' .. s) end

-- --fighter.sayHello = function(f)
--     --love.graphics.print('Oi, meu nome é' .. f.name)
-- --end

-- --function fighter:sayHello()
--     -- function fighter.sayHello(self)
--    -- love.graphics.print('Oi, meu nome é' .. self.name)
-- --end

-- -- Modo 2

-- function fighter:scream() love.graphics.print("ARRRRRRH") end

-- -- Modo 3

-- function fighter.kick() love.graphics.print("Um chute!") end

-- -- Invocando os métodos 

-- function love.draw()
--     -- fighter.kick()
--     -- fighter:sayHello(fighter.name)
--     fighter:sayHello()
--     -- fighter:scream()
-- end
