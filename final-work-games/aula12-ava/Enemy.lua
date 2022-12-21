-- Enemy  =  Class{}
-- function Enemy:init(world, sprite, x, y)
--     self.sprite = sprite
--     self.w = sprite:getWidth()
--     self.h = sprite:getHeight()
--     self.body = world:newRectangleCollider(x, y, self.w, self.h,
--                 {collision_class = 'enemy'})
-- end
-- --self.animations = {}
--  --   self.animations.walking = anim8.newAnimation(g('1-12', 4), 0.1) -- Parado
--   --  self.animations.dead = anim8.newAnimation(g('1-12', 1), 0.1) -- Correndo
-- function Enemy:update(dt)
-- end
-- function Enemy:draw()
--     love.graphics.draw(self.sprite, 
--         self.body:getX()-self.w/2,
--         self.body:getY()-self.h/2)
-- end

Enemy = Class {}
anim8 = require 'lib/anim8'

function Enemy:init(world)
    self.world = world
    self.speed = 50
    self.finalfase = false
    -- self.w = 20
    -- self.h = 20
    self.spritesheet = love.graphics.newImage("Skeleton.png")
    self.w = self.spritesheet:getWidth() / 13
    self.h = self.spritesheet:getHeight() / 5
    self.cw = self.w - 30
    self.ch = self.h - 23
    g = anim8.newGrid(self.w, self.h, self.spritesheet:getWidth(), self.spritesheet:getHeight())

    self.animations = {}
    self.animations.walking = anim8.newAnimation(g('1-12', 3), 0.1) -- walkig

    self.body = world:newRectangleCollider(744, 110, self.cw, self.ch, {
        collision_class = 'enemy'
    })
    self.body:setFixedRotation(true)
    self.direction = 1
    -- estado de vida, inicia como vivo (false)
end

function Enemy:update(dt)
    local x
    local y
    x, y = self.body:getPosition()
    x = x + self.speed * dt
    self.body:setX(x)
    colliders = world:queryRectangleArea(x - self.cw / 2, y + self.ch / 2, self.cw, 3, {'platform'})

    if self.body:enter('range') then
        self.direction = self.direction * -1 -- Inverte direção
        self.speed = self.speed * -1 -- Inverte velocidade
    end
    self.curAnimation = self.animations.walking
    self.curAnimation:update(dt)

end

function Enemy:draw()
    if self.dead then
        return
    end

    self.curAnimation:draw(self.spritesheet, self.body:getX(), self.body:getY(), 0, self.direction, 1, self.w / 2,
        self.h / 2.1)
end

