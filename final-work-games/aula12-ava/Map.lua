Map = Class {}

function Map:init(world)
    self.world = world
    self.platforms = {}
    self.final = {}
    self.Gameover = {}
    self.Range = {}
    self.gameMap = sti('maps/map.lua')
    self:createPlatforms()
    self:createFinal()
    self:createGameover()
    self:createRange()
end

function Map:update(dt)

end

function Map:draw()
    self.gameMap:drawLayer(self.gameMap.layers['Camada de Blocos 1'])
end

function Map:createPlatforms()
    local platform
    for _, obj in ipairs(self.gameMap.layers['plataforma'].objects) do
        platform = self.world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height, {
            collision_class = 'platform'
        })
        platform:setType('static')
        table.insert(self.platforms, platform)
    end
end

function Map:createFinal()
    local conclusion
    for _, obj2 in ipairs(self.gameMap.layers['final'].objects) do
        conclusion = self.world:newRectangleCollider(obj2.x, obj2.y, obj2.width, obj2.height, {
            collision_class = 'conclusion'
        })
        conclusion:setType('static')
        table.insert(self.final, conclusion)
    end
end

function Map:createGameover()
    local gameover
    for _, obj3 in ipairs(self.gameMap.layers['espinhos'].objects) do
        gameover = self.world:newRectangleCollider(obj3.x, obj3.y, obj3.width, obj3.height, {
            collision_class = 'youaredead'
        })
        gameover:setType('static')
        table.insert(self.Gameover, gameover)
    end
end

-- Insere inimigo no collider inimigo
function Map:createRange()
    local range
    for _, obj4 in ipairs(self.gameMap.layers['inimigo'].objects) do
        range = self.world:newRectangleCollider(obj4.x, obj4.y, obj4.width, obj4.height, {
            collision_class = 'range'
        })
        range:setType('static')
        table.insert(self.Range, range)
    end
end
