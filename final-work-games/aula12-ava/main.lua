WINDOW_WIDTH = 980
WINDOW_HEIGHT = 500
WIDTH = 640
HEIGHT = 360

push = require 'lib/push'
wf = require 'lib/windfield' -- física

sti = require 'lib/sti'
Class = require 'lib/class'
Camera = require 'lib/camera'

require 'Map'
require 'Player'
require 'Enemy'

function love.load()
    Font = love.graphics.newFont('Caveat-VariableFont_wght.ttf', 40)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(WIDTH, HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)
    world = wf.newWorld(0, 800, false)
    world:setQueryDebugDrawing(true) -- visualiza o campo de busca
    -- ground = world:newRectangleCollider(10, 300, 600, 60)
    -- ground:setType('static')
    world:addCollisionClass('platform')
    world:addCollisionClass('enemy')
    world:addCollisionClass('range')
    world:addCollisionClass('conclusion')
    world:addCollisionClass('youaredead')
    -- ground:setCollisionClass('platform')
    player = Player(world) -- inicialização (metodo init() em ação)

    map = Map(world)

    cam = Camera() -- Instacia do objeto camera

    enemy = Enemy(world) -- Instacia do objeto enemy)

    songs = {}
    songs.background = love.audio.newSource("background.mp3", "static")
    songs.jump = love.audio.newSource("jump.mp3", "static")
    songs.song = love.audio.newSource("song.mp3", "static")
    songs.gameover = love.audio.newSource("Gameover.mp3", "static")

    -- enemies = {}
    -- creature = love.graphics.newImage("zombie.png")
    -- for _, obj in ipairs(map.gameMap.layers['inimigo'].objects) do
    --     table.insert(enemies, Enemy(world, creature, obj.x, obj.y))
    -- end
end

function love.update(dt)
    world:update(dt)
    player:update(dt)
    enemy:update(dt)

    songs.background:play()
    songs.background:setVolume(0.1)

    songs.song:play()
    songs.song:setVolume(0.03)

end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(Font)
    if player.finalfase ~= true then
        push:start()
        cam:attach() -- anexa a camera ao ceário
        -- world:draw()
        map:draw()
        player:draw()
        enemy:draw()
        -- for _, e in ipairs(enemies) do
        --     e:draw()
        -- end
        if player.dead ~= true then
            cam:lookAt(player.body:getX(), HEIGHT - 110)
        end
        cam:detach() -- desanexa a camera do cenário
        if player.dead == true then
            -- body
            love.graphics.printf('Game Over', 0, HEIGHT / 3, WIDTH, 'center')
            songs.gameover:play()
            songs.gameover:setVolume(1)
            songs.song:stop()
        end

        -- if player.finalfase == true then
        -- body
        --   love.graphics.printf('FASE CONCLUIDA', 0, HEIGHT/3, WIDTH, 'center')
        -- end

        push:finish()
        -- Fase concluida tela
    else
        love.graphics.printf(' FASE CONCLUÍDA! ELLIE CONSEGUE SAIR DAS PROFUNDEZAS DO CASTELO SUBTERRÂNEO. ', 0,
            WINDOW_HEIGHT / 3, WINDOW_WIDTH, 'center')
    end
end

function love.keypressed(key)
    if key == 'w' then

        player:jump()
        songs.jump:play()
        songs.jump:setVolume(0.2)
    end
end
