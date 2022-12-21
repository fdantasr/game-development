Player = Class {}
anim8 = require 'lib/anim8'

function Player:init(world)
    self.world = world
    self.speed = 200
    self.finalfase = false
    -- self.w = 20
    -- self.h = 20
    self.spritesheet = love.graphics.newImage("red hood itch free Copy-Sheet.png")
    self.w = self.spritesheet:getWidth() / 12 -- 12 colunas
    self.h = self.spritesheet:getHeight() / 11 -- 11 linhas
    self.cw = self.w - 85
    self.ch = self.h - 100
    g = anim8.newGrid(self.w, self.h, self.spritesheet:getWidth(), self.spritesheet:getHeight())

    self.animations = {}
    self.animations.idle = anim8.newAnimation(g('1-12', 4), 0.1) -- Parado
    self.animations.run = anim8.newAnimation(g('1-12', 1), 0.1) -- Correndo
    self.animations.jump = anim8.newAnimation(g('5-12', 4), 0.4) -- Pulando
    self.animations.fight = anim8.newAnimation(g('5-12', 10), 0.4) -- Lutando

    self.curAnimation = self.animations.idle

    self.body = world:newRectangleCollider(50, 10, self.cw, self.ch)
    self.body:setFixedRotation(true)
    self.grounded = false
    self.direction = 1
    -- estado de vida, inicia como vivo (false)
    self.dead = false
end

function Player:update(dt)
    if self.dead then
        return
    end
    local x
    local y
    x, y = self.body:getPosition()
    if love.keyboard.isDown('d') then
        x = x + self.speed * dt
        self.curAnimation = self.animations.run
        self.direction = -1
    elseif love.keyboard.isDown('a') then
        x = x - self.speed * dt
        self.curAnimation = self.animations.run
        self.direction = 1
    else
        self.curAnimation = self.animations.idle
    end
    self.body:setX(x)
    colliders = world:queryRectangleArea(x - self.cw / 2, y + self.ch / 2, self.cw, 3, {'platform'})
    -- O player está apoiado sobre algum corpo? 
    if #colliders > 0 then
        self.grounded = true
    else
        self.grounded = false
    end
    -- Verifica se o Player colidiu com um collider do tipo inimigo
    if self.body:enter('enemy') then
        self.body:destroy()
        self.dead = true
    end
    if self.body:enter('conclusion') then
        self.finalfase = true
    end
    if self.body:enter('youaredead') then
        self.body:destroy()
        self.dead = true
    end
    self.curAnimation:update(dt)
end

function Player:jump()
    -- O player pode fazer o salto?
    if self.dead then
        return
    end
    if self.grounded then
        self.body:applyLinearImpulse(0, -700)
    end
end

function Player:draw()
    if self.dead then
        return
    end

    self.curAnimation:draw(self.spritesheet, self.body:getX(), self.body:getY(), 0, self.direction, 1, self.w / 2,
        self.h / 1.7)
end
