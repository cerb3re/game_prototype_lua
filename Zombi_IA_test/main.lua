io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

local human       = {}
local lst_sprites = {}
local lst_env     = {}
local ZSTATES     = {} -- zombi state
local blood_image   = love.graphics.newImage("pictures/blood.png")
local alert_picture = love.graphics.newImage("pictures/alert.png")
local DEAD        = false
ZSTATES.NONE      = ""
ZSTATES.WALK      = "walk"
ZSTATES.ATTACK    = "attack"
ZSTATES.BITE      = "bite"
ZSTATES.CHANGEDIR = "change"

function math.angle(x1, y1, x2, y2)
  return math.atan2(y2 - y1, x2 - x1)
end

function math.dist(x1, y1, x2, y2)
  return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end
----------------------------------------------------------------
function create_zombi()
  local zombi
  local angle
  local i

  zombi         = create_sprite(lst_sprites, "zombi", "monster_", 2)
  zombi.state   = ZSTATES.NONE
  zombi.x       = math.random(10, screen_width - 10)
  zombi.y       = math.random(10, (screen_height / 2) - 10)
  zombi.speed   = math.random(5, 50) / 200
  zombi.range   = math.random(10, 150)
  zombi.target  = nil
  angle         = math.angle(zombi.x, zombi.y, math.random(0, screen_width), math.random(0, screen_height))
end

function attack_human(pHuman, pZombi)
  local distance_x = pZombi.x - pHuman.x
  local distance_y = pZombi.y - pHuman.y
  local difference = math.abs(math.floor(distance_y + distance_x))

  if difference <= 50 then
    angle         = math.angle(pZombi.x, pZombi.y, pHuman.x, pHuman.y)
    pZombi.vx     = pZombi.speed * 60 * math.cos(angle) 
    pZombi.vy     = pZombi.speed * 60 * math.sin(angle)
  end

end

function update_zombi(pZombi, pEntities)
  local angle

  if pZombi.state == ZSTATES.NONE then
    pZombi.state = ZSTATES.CHANGEDIR

  elseif pZombi.state == ZSTATES.WALK then -- walk
    local bCollide = false
    if pZombi.x < 0 then
      pZombi.x = 0
      bCollide = true
    end
    if pZombi.x > screen_width then
      pZombi.x = screen_width
      bCollide = true
    end
    if pZombi.y > screen_height then
      pZombi.y = screen_height
      bCollide = true
    end
    if pZombi.y < 0 then
      pZombi.y = 0
      bCollide = true
    end
    if bCollide then
      pZombi.state = ZSTATES.CHANGEDIR
    end

    for i, sprite in ipairs(pEntities) do
      if sprite.type == "human" and sprite.visible == true then

        distance      = math.abs(math.floor(math.dist(pZombi.x, pZombi.y, sprite.x, sprite.y)))
        if distance < pZombi.range then
          pZombi.state  = ZSTATES.ATTACK
          pZombi.target = sprite 
        end
      end
    end

  elseif pZombi.state == ZSTATES.ATTACK then -- ATTACK
    local distance
    
    distance = math.abs(math.floor(math.dist(pZombi.x, pZombi.y, pZombi.target.x, pZombi.target.y)))

    if pZombi.target == nil then
      pZombi.state = ZSTATES.CHANGEDIR
    
    elseif distance > pZombi.range and pZombi.target.type == "human" then
      pZombi.state = ZSTATES.CHANGEDIR

    elseif distance < 5 and pZombi.target.type == "human" then

      pZombi.state = ZSTATES.BITE
      pZombi.vy    = 0
      pZombi.vx    = 0 
    else

      local dest_x  = math.random(pZombi.target.x - 10, pZombi.target.x + 10)
      local dest_y  = math.random(pZombi.target.y - 10, pZombi.target.y + 10)

      angle         = math.angle(pZombi.x, pZombi.y, pZombi.target.x, pZombi.target.y)
      pZombi.vx     = pZombi.speed * 2 * 60 * math.cos(angle) 
      pZombi.vy     = pZombi.speed * 2 * 60 * math.sin(angle)
    end
  
  elseif pZombi.state == ZSTATES.BITE then -- BITE
    local distance
    local blood

    distance  = math.abs(math.floor(math.dist(pZombi.x, pZombi.y, pZombi.target.x, pZombi.target.y)))
    if distance > 5 then
      pZombi.state = ZSTATES.ATTACK
      pZombi.target.isHurt = false
      pZombi.touchInThisArea = false
    else
      if pZombi.target.hurt() and pZombi.touchInThisArea == false then
        love.audio.play(love.audio.newSource("sounds/bite.wav", "static"))
        local blood     = {}

        blood.picture   = love.graphics.newImage("pictures/blood.png")
        blood.x         = pZombi.target.x 
        blood.y         = pZombi.target.y 

        table.insert(lst_env, blood)

        pZombi.touchInThisArea = true      
      end
      if pZombi.target.visible == false then
        pZombi.state = ZSTATES.CHANGEDIR
        DEAD = true
      end
    end

  elseif pZombi.state == ZSTATES.CHANGEDIR then -- CHANGE DIRECTION
    angle         = math.angle(pZombi.x, pZombi.y, math.random(0, screen_width), math.random(0, screen_height))
    pZombi.vx     = pZombi.speed * 60 * math.cos(angle) 
    pZombi.vy     = pZombi.speed * 60 * math.sin(angle) 

    pZombi.state  = ZSTATES.WALK 
  end

end
function create_human()
  human         = create_sprite(lst_sprites, "human", "player_", 4)
  human.x       = screen_width / 2
  human.y       = (screen_height / 6) * 4
  human.life    = 150
  human.isHurt  = false
  human.hurt    = function ()
    human.life  = human.life - 0.1
    human.isHurt = true
    if human.life <= 0 then
      human.life = 0
      human.visible = false
    end
    return human.isHurt
  end

  return human
end

function create_sprite(pList, pType, pPicture, pNbFrame)
  local sprite          = {}
  sprite.type           = pType
  sprite.actual_picture = {}
  sprite.current_frame  = 1
  sprite.visible        = true

  local i
  for i=1, pNbFrame do
    if pType == "blood" then
      file_name = "pictures/"..pPicture..".png"
    else
      file_name = "pictures/"..pPicture..tostring(i)..".png"
    end
    sprite.actual_picture[i] = love.graphics.newImage(file_name)
  end

  sprite.y      = 0
  sprite.x      = 0
  sprite.vx     = 0 
  sprite.vy     = 0 
  sprite.width  = sprite.actual_picture[1]:getWidth()
  sprite.height = sprite.actual_picture[1]:getHeight()

  table.insert(lst_sprites, sprite)

  return sprite
end

function love.draw()
  love.graphics.push()
  love.graphics.print("Life: "..tostring(math.floor(human.life)), 1, 1) -- print life
  love.graphics.scale(2, 2)

  local i
  for i, actual_sprite in ipairs(lst_sprites) do
    if actual_sprite.visible == true then
      local frame = actual_sprite.actual_picture[math.floor(actual_sprite.current_frame)]
        love.graphics.draw(frame, actual_sprite.x - actual_sprite.width / 2, actual_sprite.y - actual_sprite.height / 2)
    
      -- debug
      if actual_sprite.type == "zombi" then
        
        if actual_sprite.state == ZSTATES.ATTACK then
          love.graphics.draw(alert_picture, actual_sprite.x - alert_picture:getWidth() / 2, actual_sprite.y -  actual_sprite.height - 2)
        end
        
        if love.keyboard.isDown("d") then
           love.graphics.print(actual_sprite.state, actual_sprite.x - 10, actual_sprite.y - actual_sprite.height - 10)
        end

      end
    end
  end


  for i, sprite in ipairs(lst_env) do
    local picture = sprite.picture

    love.graphics.draw(picture, sprite.x, sprite.y)
  end

  love.graphics.pop()

end

function love.update(dt)
  local i
  for i, sprite in ipairs(lst_sprites) do
    sprite.current_frame = sprite.current_frame + 0.1

    if sprite.current_frame >= #sprite.actual_picture + 1 then
      sprite.current_frame = 1
    end

    sprite.x = sprite.x + sprite.vx * dt
    sprite.y = sprite.y + sprite.vy * dt 

    if sprite.type == "zombi" then
      update_zombi(sprite, lst_sprites)
    end
  end

  if love.keyboard.isDown("left") then
    human.x = human.x - 1
  end
  if love.keyboard.isDown("right") then
    human.x = human.x + 1
  end
  if love.keyboard.isDown("up") then
    human.y = human.y - 1
  end
  if love.keyboard.isDown("down") then
    human.y = human.y + 1
  end
  if love.keyboard.isDown("space") then 
      create_zombi() -- for debug
  end

end

function love.load()
  screen_height = love.graphics.getHeight() / 2
  screen_width  = love.graphics.getWidth() / 2

  for i=10, 1, -1 do
    create_zombi()
  end
  create_human()
  
end