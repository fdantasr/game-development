
function love.load()
    math.randomseed(os.time())
    height = love.graphics.getHeight()
    width = love.graphics.getWidth()
    
    sprite = {}
    sprite.bg = love.graphics.newImage("sprites/tile_01.png")
    sprite.bullet = love.graphics.newImage("sprites/tile_187.png")
    sprite.player = love.graphics.newImage("sprites/survivor1_machine.png")
    sprite.zombie = love.graphics.newImage("sprites/zoimbie1_hold.png")
    Font = love.graphics.newFont("fonts/OKINE.otf", 15)

    player = {}
    player.h = sprite.player:getHeight()/2
    player.w = sprite.player:getWidth()/2
    player.x = width / 2
    player.y = height / 2
    player.direction = 0 --girar a esquer ou direita
    player.angular_speed = 6
    player.speed = 180
    player.rotation = 0 --math.pi/2 -- radianos
    player.vector = {}



    bullets = {}
    bullets.speed = 500
    bullets.h = sprite.bullet:getHeight()/2
    bullets.w = sprite.bullet:getWidth()/2

    monsters = {}
    monsters.h = sprite.zombie:getHeight()/2
    monsters.w = sprite.zombie:getWidth()/2
    monsters.speed = 50

    time_limit = 3 --segundos
    timer  = time_limit
    
    monster_killed = {}
    monster_killed.score = 0
end

function love.update(dt)
    timer = timer - dt
    if timer <= 0 then
        --esgotou o tempo
        create_monster()
        time_limit = time_limit * 0.96 --reset do timer
        timer = time_limit

    end
    player.direction = 0
    player.vector.x = 0
    player.vector.y = 0
    if love.keyboard.isDown('w') then
        player.vector.y = math.sin(player.rotation)
        player.vector.x = math.cos(player.rotation) 
    end
    if love.keyboard.isDown('d') then
        player.direction = 1
    end
    if love.keyboard.isDown('a') then
        player.direction = -1
    end
    player.rotation = player.rotation + player.direction * player.angular_speed * dt
    player.x = player.x + player.vector.x * player.speed * dt
    player.y = player.y + player.vector.y * player.speed * dt

    -- Remover Balas do View Port

    for i = #bullets, 1, -1 do
        local b = bullets[i]
        if b.x < 0 or b.x > width or b.y < 0 or b.y > height then
            table.remove(bullets, i)
        end
        --verificar se a bala atinge algum monstro
        for j = #monsters, 1, -1 do
            local m = monsters[j]
            if collides(b, m, 25) then 
                table.remove(bullets, i)
                table.remove(monsters, j)
                monster_killed.score = monster_killed.score + 1
        end
    end
end
     
     -- Atualiza a posição da bala
    for i,b in ipairs(bullets) do 
        b.x = b.x + b.vector.x * bullets.speed * dt
        b.y = b.y + b.vector.y * bullets.speed * dt
    end
    for i, m in ipairs(monsters) do
        m.x = m.x + math.cos(m.rotation)*monsters.speed * dt
        m.y = m.y + math.sin(m.rotation)*monsters.speed * dt
        m.rotation = player_monster_angle(m)
         end
end

function love.draw()
    love.graphics.setFont(Font)
    draw_bg()
    love.graphics.print("Quantidade de Balas: ".. #bullets) --Aula 05 adicionado, para contar as balas no View POrt
    love.graphics.draw(sprite.player, 
        player.x, 
        player.y, 
        player.rotation,
        nil, nil,
        player.w,
        player.h
    )
    -- QUANTIDADE DE MOSNTROS MORTOS

    love.graphics.printf("Zumbis mortos: " .. monster_killed.score, 700, height/2, width, 'left') --Aula 05 adicionado, para contar as balas no View POrt
    
    for i, b in ipairs(bullets) do
        love.graphics.draw(
            sprite.bullet,
            b.x, b.y, 0,
            nil, nil,
            bullets.h,
            bullets.w
        )
    end
    --desenha monstro
    
    for i, m in ipairs(monsters) do
        love.graphics.draw(
            sprite.zombie,
            m.x, m.y, m.rotation,
            nil, nil,
            monsters.h,
            monsters.w
        )
    end
end



function draw_bg()

    img_h = sprite.bg:getHeight()
    img_w = sprite.bg:getWidth()
    cols = math.ceil(width / img_w)
    rows = math.ceil(height / img_h)
    for row = 0, rows - 1 do
        for col = 0, cols - 1 do
            love.graphics.draw(sprite.bg, col * img_w, row * img_h)
        end
    end

end

function love.keypressed(key)
    if key == 'space' then
        local bullet = {}
        bullet.x = player.x
        bullet.y = player.y
        bullet.vector = {}
        bullet.vector.x = math.cos(player.rotation)
        bullet.vector.y = math.sin(player.rotation)
        table.insert(bullets, bullet)
    end    
    if key == 'return' then
        create_monster()
    end
end

function create_monster()
    local monster = {}
--monster.x =  math.random(0, width)
--monster.y = math.random(0, height)

side = math.random(1,4)
if side == 1 then
    monster.x = -30
    monster.y = math.random(0, height)
elseif side == 2 then 
    monster.x = math.random(0, width)
    monster.y = -30
elseif side == 3 then
    monster.x = width+10
    monster.y = math.random(0, height)
else 
monster.x = math.random(0, width)
monster.y = height + 10

end
monster.rotation = math.random(-2*math.pi, 2*math.pi)
monster.rotation = player_monster_angle(monster)
table.insert(monsters, monster)
end

function collides(a, b, min_distance)
    --distancia euclidiana entre dois pontos
    h = math.sqrt((a.x - b.x) ^ 2 + (a.y - b.y) ^ 2)
    if h < min_distance then
        return true
    end
    return false
end
function player_monster_angle(monster)
return math.atan2(player.y -monster.y, player.x - monster.x)

end
