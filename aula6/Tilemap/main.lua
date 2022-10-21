--Tamanho do Tile
SCALE = 4
TSIZE = SCALE * 16
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
tilemap = {
    {1,0,1,1,1,1,1,1,1,1},
    {0,0,0,0,0,0,0,1,1,1},
    {1,0,1,1,1,1,0,1,1,1},
    {1,0,1,1,0,0,0,0,0,1},
    {1,0,1,1,1,1,0,1,0,0},
    {1,0,1,1,1,1,0,1,0,1},
    {1,0,0,0,3,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1}
}

sprite = {}
sprite.wall = love.graphics.newImage("tile_0014.png")
sprite.floor = love.graphics.newImage("tile_0024.png")
sprite.player = love.graphics.newImage("tile_0084.png")
sprite.pocao = love.graphics.newImage("tile_0114.png")
player = {x = 3, y =2} --Posição do Player
end 

function love.update(dt)

end

function love.draw()
    for i, row in ipairs(tilemap) do
        for j, col in ipairs(row) do
            if col == 1 then --Parede
            love.graphics.draw(sprite.wall, j * TSIZE, i * TSIZE, 0-- Coordenada (x, y) do retangulo
            , SCALE, SCALE) -- tamanho do retangulo
            
            elseif col == 0 then --Chão
                love.graphics.draw(sprite.floor, j * TSIZE, i * TSIZE, 0-- Coordenada (x, y) do retangulo
                , SCALE, SCALE) -- tamanho do retangulo
            end
            if col == 2 then -- Cavaleiro
                    love.graphics.draw(sprite.player, j * TSIZE, i * TSIZE, 0-- Coordenada (x, y) do retangulo
                    , SCALE, SCALE) -- tamanho do retangulo
            end
            if col ==0 or col == 3 then -- Cavaleiro
                love.graphics.draw(sprite.floor, j * TSIZE, i * TSIZE, 0-- Coordenada (x, y) do retangulo
                , SCALE, SCALE) -- tamanho do retangulo
                if col == 3  then
                    love.graphics.draw(sprite.pocao, j * TSIZE, i * TSIZE, 0-- Coordenada (x, y) do retangulo
                    , SCALE, SCALE) -- tamanho do retangulo
                
                end
            end 
        end 
    end
    love.graphics.draw(sprite.player,
    player.x*TSIZE, player.y * TSIZE, 0,
    SCALE, SCALE)
end

  function love.keypressed(key)
    local x = player.x --Coluna em que o player se encontra
    local y = player.y --Linha em que se encontra o player

    if key == 'w' then
        y = y-1
    end
    if key == 'a' then
        x = x-1
    end
    if key == 's' then
        y = y+1
    end
    if key == 'd' then
        x = x+1
    end
    if tilemap[y][x] ~= 1 then --Não é parede
        player.x = x
        player.y = y
    end
end
end